import 'package:chow/res/app_routes.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../chow_ordering/widget/food_details_card.dart';
import '../chow_ordering/widget/products_card.dart';
import '../modals.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/image_view.dart';
import '../widgets/meal_detail.dart';
import 'add_grocery_content.dart';

class GroceryDetailScreen extends StatefulWidget {
  const GroceryDetailScreen({Key? key}) : super(key: key);

  @override
  State<GroceryDetailScreen> createState() => _GroceryDetailScreenState();
}

class _GroceryDetailScreenState extends State<GroceryDetailScreen> {
  late PageController _controller;
  int initCount = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
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
                background: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.grocery),
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter),
                  ),
                  child: Stack(
                    children: [
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
                          height: 24,
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
                                  text: '20 - 30 mins',
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: ImageView.svg(
                                    AppImages.icLike,
                                    width: 32,
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () => Modals.showBottomSheetModal(
                                        context,
                                        borderRadius: 25,
                                        page: _shareContentOverlay(),
                                        isScrollControlled: true,
                                      ),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: ImageView.svg(AppImages.icForward),
                                  ))
                            ],
                          ))
                    ],
                  ),
                )),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const FoodDetailsCard(
                address: '12 Chime’s Avenue, New Heaven, Enugu.',
                distance: '20km away',
                options: ['Fruits', 'Beverages', 'Cookies'],
                rating: '3.6  (500+)',
                title: 'Groceries Stall',
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      size: 24,
                      text: 'Trending Fruits',
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      weight: FontWeight.w700,
                    ),
                    Row(
                      children: [
                        CustomText(
                          size: 14,
                          text: 'Sell all',
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
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).colorScheme.primary,
                                size: 12,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 358,
                child: PageView.builder(
                    controller: _controller,
                    padEnds: false,
                    itemCount: 2,
                    pageSnapping: true,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: ProductCard.hotDeals(
                          spacing: 11,
                          details: '',
                          title: 'Orange',
                          titleSmall: 'Lemon',
                          rating: '',
                          imageUrl: AppImages.grocery,
                          duration: '',
                          discount: 'Free Delivery',
                          titleSize: 18,
                          titleWeight: FontWeight.w700,
                          price: '2500',
                          onPressed: () => Modals.showBottomSheetModal(context,
                              borderRadius: 25,
                              page: const MealDetail(
                                child: AddGroceryContent(),
                                imageUrl: AppImages.grocery,
                              ),
                              isScrollControlled: true,
                              heightFactor: 0.9),
                        ),
                      );
                    })),
              ),
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
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: ((context, index) {
                    return ProductCard.hotDeals(
                      details: '',
                      title: 'Strawberries ',
                      titleSmall: 'Fresh fruit',
                      rating: '',
                      imageUrl: AppImages.grocery,
                      duration: '',
                      discount: '',
                      price: '2500',
                      onPressed: () => Modals.showBottomSheetModal(context,
                          borderRadius: 25,
                          page: const MealDetail(
                            child: AddGroceryContent(),
                            imageUrl: AppImages.grocery,
                          ),
                          isScrollControlled: true,
                          heightFactor: 0.9),
                    );
                  }))
            ]),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(vertical: 65, horizontal: 21),
        child: ButtonView(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
          onPressed: () {
            AppNavigator.pushAndStackNamed(context,
                name: AppRoutes.cartScreen, arguments: 'drinks_cart');
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
                  text: '4 items',
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
                      text: '32,000',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                          fontSize: 12))
                ])),
              ],
            ),
          ),
        ),
      ),
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
