import 'package:chow/extentions/custom_string_extension.dart';
import 'package:chow/model/view_models/products_view_model.dart';
import 'package:chow/requests/repositories/products_repository/product_repository_impl.dart';
import 'package:chow/ui/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/products/products.dart';
import '../../model/data_models/product/product.dart';
import '../../res/app_routes.dart';
import '../../res/enum.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../bookings/widget/modal_content.dart';
import '../modals.dart';
import '../widgets/button_view.dart';
import '../widgets/cart_icon.dart';
import '../widgets/custom_text.dart';
import '../widgets/empty_widget.dart';
import '../widgets/filter_search_section.dart';
import '../widgets/meal_detail.dart';
import '../widgets/progress_indicator.dart';
import 'widget/add_meal_content.dart';
import 'widget/combo_meal_widget.dart';
import 'widget/create_meal_widget.dart';
import 'widget/products_card.dart';

class Food extends StatelessWidget {
  const Food({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (BuildContext context) => ProductsCubit(
          productsRepository: ProductRepositoryImpl(),
          viewModel: Provider.of<ProductsViewModel>(context, listen: false)),
      child: const FoodScreen(),
    );
  }
}

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> with WidgetsBindingObserver {
  final _controller = PageController(viewportFraction: 0.7);
  final _scrollController = ScrollController();

  List<Product> vendorsList = [];
  List<Product> productsList = [];

  late ProductsCubit _productsCubit;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _asyncInitMethod();
    _initScrollListener();
    super.initState();
  }

  void _initScrollListener() {
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.9 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        _productsCubit.getAllProducts(page: _productsCubit.page);
      }
    });
  }

  void _asyncInitMethod() {
    _productsCubit = context.read<ProductsCubit>();
    _productsCubit.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: CustomText(
            size: 24,
            text: 'Food',
            color: Theme.of(context).textTheme.bodyText1!.color,
            weight: FontWeight.w600,
          ),
          actions: const [CartIcon()],
          backgroundColor: Theme.of(context).primaryColor),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 19),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FilterSearchView(
              hintText: 'Search for Food or Vendor',
              onSearchTap: () {
                AppNavigator.pushAndStackNamed(context,
                    name: AppRoutes.searchScreen,
                    arguments: {
                      'product_type': 'Food',
                      'category': ProductsType.food,
                      'products': productsList
                    });
              },
              onFilterTap: () {
                Modals.showBottomSheetModal(context,
                    page: const ModalSheetContent(
                      values: [
                        'All',
                        'Popular',
                        'Rating',
                        'Free Delivery',
                        'Special Offers'
                      ],
                    ),
                    isScrollControlled: true,
                    heightFactor: 0.9);
              },
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  size: 24,
                  text: 'Vendors Near you',
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  weight: FontWeight.w700,
                ),
                GestureDetector(
                  onTap: () {
                    if (vendorsList.isEmpty) {
                      Modals.showToast('failed to load vendors try again',
                          messageType: MessageType.error);
                      _productsCubit.getAllProducts();
                    } else {
                      AppNavigator.pushAndStackNamed(context,
                          name: AppRoutes.vendorsScreen,
                          arguments: {
                            'title': 'Vendors Near you',
                            'product_type': ProductsType.food,
                            'vendors': vendorsList
                          });
                    }
                  },
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CustomText(
                            size: 14,
                            text: 'See all',
                            color: Theme.of(context).colorScheme.primary,
                            weight: FontWeight.w700,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.primary,
                              size: 12,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocConsumer<ProductsCubit, ProductsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const LoadingPage(length: 3);
                } else if (state is ProductNetworkErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _productsCubit.getAllProducts(),
                  );
                } else if (state is ProductApiErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _productsCubit.getAllProducts(),
                  );
                }
                final foods = _productsCubit.viewModel.foods;

                List<Product> vendorList = [];
                bool addIt = false;
                for (var vendor in foods) {
                  addIt = true;
                  for (var e in vendorList) {
                    if (e.vendor?.id == vendor.vendor?.id) {
                      addIt = false;
                      break;
                    }
                  }
                  if (addIt) vendorList.add(vendor);
                }

                vendorsList = vendorList;

                return SizedBox(
                  height: (vendorList.isEmpty) ? 0 : 262,
                  child: PageView.builder(
                      controller: _controller,
                      itemCount: vendorList.length,
                      padEnds: false,
                      itemBuilder: ((context, index) {
                        final vendor = vendorList[index];

                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ProductCard.near(
                            details: 'business Details',
                            title: vendor.vendor?.businessName ?? '',
                            rating: '3.6',
                            imageUrl: vendor.vendor?.picture?.url ?? '',
                            duration: '20 - 30 mins',
                            discount: ''
                                '% Discount',
                            onPressed: () {
                              AppNavigator.pushAndStackNamed(context,
                                  name: AppRoutes.chowDetailScreen,
                                  arguments: {
                                    "vendor_id": vendor.vendor?.id,
                                    "image_url":
                                        vendor.vendor?.picture?.url ?? '',
                                    "preparation_time": vendor.vendor?.product
                                            ?.first.preparationTime ??
                                        '20 - 30mins',
                                    "business_name":
                                        vendor.vendor?.businessName ?? '',
                                    "location": vendor.vendor?.location ?? '',
                                    'product_type': ProductsType.food,
                                  });
                            },
                          ),
                        );
                      })),
                );
              }),
          const SizedBox(
            height: 40,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ComboMealCard()),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomText(
              size: 24,
              text: 'Popular Vendors',
              color: Theme.of(context).textTheme.bodyText1!.color,
              weight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BlocConsumer<ProductsCubit, ProductsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const LoadingPage(length: 8);
                } else if (state is ProductNetworkErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _productsCubit.getAllProducts(),
                  );
                } else if (state is ProductApiErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _productsCubit.getAllProducts(),
                  );
                }
                final foods = _productsCubit.viewModel.foods;

                List<Product> vendorList = [];
                bool addIt = false;
                for (var vendor in foods) {
                  addIt = true;
                  for (var e in vendorList) {
                    if (e.vendor?.id == vendor.vendor?.id) {
                      addIt = false;
                      break;
                    }
                  }
                  if (addIt) vendorList.add(vendor);
                }

                vendorsList = vendorList;

                return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vendorList.length,
                    itemBuilder: ((context, index) {
                      final vendor = vendorList[index];

                      return ProductCard.popular(
                        details: 'business Details',
                        title: vendor.vendor?.businessName ?? '',
                        rating: '3.6',
                        imageUrl: vendor.vendor?.picture?.url ?? '',
                        duration: '',
                        discount:
                            '${vendor.vendor?.product?.first.discountPercentage}'
                            '% Discount',
                        onPressed: () {
                          AppNavigator.pushAndStackNamed(context,
                              name: AppRoutes.chowDetailScreen,
                              arguments: {
                                "vendor_id": vendor.vendor?.id,
                                "image_url": vendor.vendor?.picture?.url ?? '',
                                "preparation_time": vendor.vendor?.product
                                        ?.first.preparationTime ??
                                    '',
                                "business_name":
                                    vendor.vendor?.businessName ?? '',
                                "location": vendor.vendor?.location ?? '',
                                'product_type': ProductsType.food,
                              });
                        },
                      );
                    }));
              }),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ButtonView(
              color: Theme.of(context).primaryColor,
              borderWidth: 0.2,
              borderColor: Theme.of(context).textTheme.caption!.color,
              onPressed: () {
                setState(() {});
                if (vendorsList.isEmpty) {
                  Modals.showToast('failed to load vendors try again',
                      messageType: MessageType.error);
                  _productsCubit.getAllProducts();
                } else {
                  AppNavigator.pushAndStackNamed(context,
                      name: AppRoutes.vendorsScreen,
                      arguments: {
                        'title': 'Popular Food Vendors',
                        'product_type': ProductsType.food,
                        'vendors': vendorsList
                      });
                }
              },
              child: Center(
                child: CustomText(
                  text: 'See all Vendors',
                  color: Theme.of(context).colorScheme.secondary,
                  size: 14,
                  weight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CreateMealCard(),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomText(
              size: 24,
              text: 'Hot Deals',
              color: Theme.of(context).textTheme.bodyText1!.color,
              weight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BlocConsumer<ProductsCubit, ProductsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const LoadingPage(length: 8);
                } else if (state is ProductNetworkErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _productsCubit.getAllProducts(),
                  );
                } else if (state is ProductApiErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _productsCubit.getAllProducts(),
                  );
                }
                final foods = _productsCubit.viewModel.foods;

                productsList = foods;

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: foods.length,
                    controller: _scrollController,
                    itemBuilder: ((context, index) {
                      final food = foods[index];

                      if (state is ProductsLoadingMore) {
                        return ProgressIndicators.linearProgressBar(context);
                      } else {
                        return ProductCard.hotDeals(
                          details: food.vendor?.businessName ?? '',
                          title: food.name.capitalizeFirstOfEach,
                          rating: '3.6(500+)',
                          imageUrl: food.image,
                          duration: food.preparationTime,
                          discount: '${food.discountPercentage}' '% Discount',
                          price: AppUtils.convertPrice(food.price),
                          onPressed: () => Modals.showBottomSheetModal(context,
                              borderRadius: 25,
                              page: MealDetail(
                                  child: AddMealContent(
                                    businessName:
                                        food.vendor?.businessName ?? '',
                                    imageUrl: food.image,
                                    price: double.parse(food.price),
                                    prepTime: food.preparationTime ?? '',
                                    productId: food.id,
                                  ),
                                  imageUrl: food.image),
                              isScrollControlled: true,
                              heightFactor: 0.9),
                        );
                      }
                    }));
              }),
          const SizedBox(
            height: 25,
          ),
        ]),
      ),
    );
  }
}
