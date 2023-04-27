import 'package:chow/extentions/custom_string_extension.dart';
import 'package:chow/res/app_routes.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/products/products.dart';
import '../../handlers/secure_handler.dart';
import '../../model/data_models/product/product.dart';
import '../../model/view_models/products_view_model.dart';
import '../../requests/repositories/products_repository/product_repository_impl.dart';
import '../../res/app_images.dart';
import '../../res/enum.dart';
import '../../utils/app_utils.dart';
import '../modals.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';
import '../widgets/meal_detail.dart';
import 'widget/add_meal_content.dart';
import 'widget/food_details_card.dart';
import 'widget/products_card.dart';

class ChowDetail extends StatelessWidget {
  const ChowDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (BuildContext context) => ProductsCubit(
          productsRepository: ProductRepositoryImpl(),
          viewModel: Provider.of<ProductsViewModel>(context, listen: false)),
      child: const ChowDetailScreen(),
    );
  }
}

class ChowDetailScreen extends StatefulWidget {
  const ChowDetailScreen({Key? key}) : super(key: key);

  @override
  State<ChowDetailScreen> createState() => _ChowDetailScreenState();
}

class _ChowDetailScreenState extends State<ChowDetailScreen>
    with WidgetsBindingObserver {
  late PageController _controller;
  int initCount = 0;

  late ProductsCubit _productsCubit;

  List<Product>? specialOffers = [];
  List<Product>? trendingMeals = [];

  Map arguments = {};
  String vendorId = '';
  String imageUrl = '';
  String preparationTime = '';
  String businessName = '';
  String location = '';
  String cartItemCount = '';
  String cartTotalPrice = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _asyncInitMethod();
    super.initState();
  }

  void _asyncInitMethod() async {
    _productsCubit = context.read<ProductsCubit>();

    cartItemCount =
        await StorageHandler.getCartDetails(key: 'cart_count') ?? '';
    cartTotalPrice =
        await StorageHandler.getCartDetails(key: 'cart_total') ?? '';

    _controller = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
    vendorId = arguments['vendor_id'];
    imageUrl = arguments['image_url'];
    preparationTime = arguments['preparation_time'];
    businessName = arguments['business_name'];
    location = arguments['location'];
    ProductsType productType = arguments['product_type'];

    _productsCubit.getAllProducts(vendorId: vendorId);

    return Scaffold(
      extendBody: true,
      body: BlocConsumer<ProductsCubit, ProductsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const LoadingPage(length: 12);
            } else if (state is ProductNetworkErr) {
              return EmptyWidget(
                title: 'Network error',
                description: state.message,
                onRefresh: () =>
                    _productsCubit.getAllProducts(vendorId: vendorId),
              );
            } else if (state is ProductApiErr) {
              return EmptyWidget(
                title: 'Network error',
                description: state.message,
                onRefresh: () =>
                    _productsCubit.getAllProducts(vendorId: vendorId),
              );
            }

            switch (productType) {
              case ProductsType.food:
                trendingMeals = _productsCubit.viewModel.foods;
                break;
              case ProductsType.drinks:
                trendingMeals = _productsCubit.viewModel.drinks;
                break;
              case ProductsType.groceries:
                trendingMeals = _productsCubit.viewModel.groceries;
                break;
              case ProductsType.pharmacy:
                trendingMeals = _productsCubit.viewModel.pharmacy;
                break;
            }

            switch (productType) {
              case ProductsType.food:
                specialOffers = _productsCubit.viewModel.foods;
                break;
              case ProductsType.drinks:
                specialOffers = _productsCubit.viewModel.drinks;
                break;
              case ProductsType.groceries:
                specialOffers = _productsCubit.viewModel.groceries;
                break;
              case ProductsType.pharmacy:
                specialOffers = _productsCubit.viewModel.pharmacy;
                break;
            }

            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  pinned: false,
                  expandedHeight: 250.0,
                  leading: Center(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const ImageView.svg(
                        AppImages.icArrowBack,
                        fit: BoxFit.fill,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Stack(
                          children: [
                            if (imageUrl != '') ...[
                              SizedBox(
                                width: double.infinity,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7.2),
                                        topRight: Radius.circular(7.2)),
                                    child: ImageView.network(imageUrl,
                                        fit: BoxFit.cover,
                                        placeholder: AppImages.icon)),
                              ),
                            ] else ...[
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7.2),
                                      topRight: Radius.circular(7.2)),
                                ),
                                child: const Center(
                                  child: ImageView.asset(
                                    AppImages.icon,
                                  ),
                                ),
                              )
                            ],
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10.0)),
                                  ),
                                  height: 15,
                                  padding: const EdgeInsets.all(15.0)),
                            ),
                            Positioned(
                              left: 25,
                              bottom: 50,
                              child: SizedBox(
                                height: 30,
                                child: ButtonView(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 9),
                                  onPressed: () {},
                                  expanded: false,
                                  borderRadius: 4.0,
                                  color: Theme.of(context).primaryColor,
                                  borderColor: Theme.of(context).primaryColor,
                                  child: Row(
                                    children: [
                                      const ImageView.svg(
                                        AppImages.icClockTickOutline,
                                        width: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      CustomText(
                                        weight: FontWeight.w400,
                                        size: 14,
                                        maxLines: 2,
                                        text: preparationTime,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 20,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: ImageView.svg(
                                          AppImages.icLike,
                                          width: 32,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () =>
                                            Modals.showBottomSheetModal(
                                              context,
                                              borderRadius: 25,
                                              page: _shareContentOverlay(),
                                              isScrollControlled: true,
                                            ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: ImageView.svg(
                                              AppImages.icForward),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                      )),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    FoodDetailsCard(
                      address: location,
                      distance: '20km away',
                      options: const ['Wines', 'Soft Drinks', 'Spirit'],
                      rating: '3.6  (500+)',
                      title: businessName,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 38),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            size: 24,
                            text: 'Trending Meals',
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            weight: FontWeight.w700,
                          ),
                          GestureDetector(
                            onTap: () {
                              //            if (vendorsList.isEmpty) {
                              //   Modals.showToast('failed to load vendors try again',
                              //       messageType: MessageType.error);
                              //   _productsCubit.getAllProducts();
                              // } else {
                              //   AppNavigator.pushAndStackNamed(context,
                              //       name: AppRoutes.vendorsScreen,
                              //       arguments: {
                              //         'title': 'Vendors Near you',
                              //         'product_type': ProductsType.food,
                              //         'vendors': vendorsList
                              //       });
                              // }
                            },
                            child: Row(
                              children: [
                                CustomText(
                                  size: 14,
                                  text: 'See all',
                                  color: Theme.of(context).colorScheme.primary,
                                  weight: FontWeight.w700,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 12,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (trendingMeals!.isEmpty) ...[
                      SizedBox(
                        height: 60,
                        child: Center(
                          child: CustomText(
                            text: 'No Meal yet',
                            color: Theme.of(context).colorScheme.secondary,
                            size: 18,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(
                        height: 358,
                        child: PageView.builder(
                            controller: _controller,
                            padEnds: false,
                            itemCount: trendingMeals?.length,
                            pageSnapping: true,
                            itemBuilder: ((context, index) {
                              final product = trendingMeals?[index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: ProductCard.hotDeals(
                                  spacing: 0,
                                  details:
                                      product?.name.capitalizeFirstOfEach ?? '',
                                  title: '',
                                  titleSmall:
                                      product?.vendor?.businessName ?? '',
                                  rating: '',
                                  imageUrl: product?.image,
                                  duration: '',
                                  discount: '',
                                  titleSize: 18,
                                  titleWeight: FontWeight.w700,
                                  price: AppUtils.convertPrice(product?.price),
                                  onPressed: () => Modals.showBottomSheetModal(
                                      context,
                                      borderRadius: 25,
                                      page: MealDetail(
                                          child: AddMealContent(
                                            businessName:
                                                product?.vendor?.businessName ??
                                                    '',
                                            imageUrl: product?.image,
                                            price: double.parse(product?.price ?? '0'),
                                            prepTime:
                                                product?.preparationTime ?? '',
                                            productId: product?.id ?? '',
                                          ),
                                          imageUrl: product?.image),
                                      isScrollControlled: true,
                                      heightFactor: 0.9),
                                ),
                              );
                            })),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: CustomText(
                        size: 24,
                        text: 'Special Offers',
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        weight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    if (specialOffers!.isEmpty) ...[
                      SizedBox(
                        height: 60,
                        child: Center(
                          child: CustomText(
                            text: 'No Meal yet',
                            color: Theme.of(context).colorScheme.secondary,
                            size: 18,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ] else ...[
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: specialOffers?.length,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          itemBuilder: ((context, index) {
                            var product = specialOffers?[index];
                            return ProductCard.hotDeals(
                              details: '',
                              title: product?.name.capitalizeFirstOfEach ?? '',
                              titleSmall: product?.vendor?.businessName ?? '',
                              rating: '',
                              imageUrl: product?.image,
                              duration: '',
                              discount: '',
                              price: AppUtils.convertPrice(product?.price),
                              onPressed: () =>
                                  Modals.showBottomSheetModal(context,
                                      borderRadius: 25,
                                      page: MealDetail(
                                          child: AddMealContent(
                                            businessName:
                                                product?.vendor?.businessName ??
                                                    '',
                                            imageUrl: product?.image,
                                            price: double.parse(
                                                    product?.price ?? '0'),
                                            prepTime:
                                                product?.preparationTime ?? '',
                                            productId: product?.id ?? '',
                                          ),
                                          imageUrl: product?.image),
                                      isScrollControlled: true,
                                      heightFactor: 0.9),
                            );
                          }))
                    ],
                  ]),
                )
              ],
            );
          }),
      bottomNavigationBar: Consumer<ProductsViewModel>(builder:
          (BuildContext context, ProductsViewModel viewModel, Widget? child) {
        return Container(
          height: 56,
          margin: const EdgeInsets.symmetric(vertical: 65, horizontal: 21),
          child: ButtonView(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
            onPressed: () {
              AppNavigator.pushAndStackNamed(context,
                  name: AppRoutes.cartScreen, arguments: 'food_cart');
            },
            expanded: true,
            borderRadius: 16.0,
            color: Theme.of(context).colorScheme.primary,
            borderColor: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    weight: FontWeight.w400,
                    size: 12,
                    maxLines: 2,
                    text: '${viewModel.cartCount} items',
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 5),
                  CustomText(
                    weight: FontWeight.w700,
                    size: 18,
                    maxLines: 2,
                    text: 'View Cart',
                    color: Theme.of(context).primaryColor,
                  ),
                  Text.rich(TextSpan(children: [
                    WidgetSpan(
                      child: Transform.translate(
                        offset: const Offset(0, 0),
                        child: Text('NGN',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12)),
                      ),
                    ),
                    TextSpan(
                        text: AppUtils.convertPrice(
                            viewModel.cartTotalAmount.toString()),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor,
                            fontSize: 12))
                  ])),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _shareContentOverlay() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 31),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Share',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 24,
                weight: FontWeight.w700,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const ImageView.svg(
                  AppImages.dropDown,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                const SizedBox(
                  height: 45,
                ),
                ButtonView(
                    onPressed: () {},
                    borderColor: Theme.of(context).textTheme.caption!.color,
                    borderWidth: 0.2,
                    color: Theme.of(context).primaryColor,
                    borderRadius: 16.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageView.svg(AppImages.icShareLinks,
                            color: Theme.of(context).colorScheme.secondary),
                        const SizedBox(width: 18),
                        Text('Share on Social links',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 13)),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                ButtonView(
                    onPressed: () {},
                    borderColor: Theme.of(context).textTheme.caption!.color,
                    color: Theme.of(context).primaryColor,
                    borderWidth: 0.2,
                    borderRadius: 16.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageView.svg(AppImages.icCopy,
                            color: Theme.of(context).colorScheme.secondary),
                        const SizedBox(width: 18),
                        Text('Copy Link',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 13)),
                      ],
                    )),
              ]),
        ),
      ],
    );
  }
}
