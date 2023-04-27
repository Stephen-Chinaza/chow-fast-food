import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../widgets/meal_detail.dart';
import '../modals.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import 'widget/add_meal_content.dart';
import 'widget/food_details_card.dart';
import 'widget/products_card.dart';

class FoodVendorScreen extends StatefulWidget {
  const FoodVendorScreen({Key? key}) : super(key: key);

  @override
  State<FoodVendorScreen> createState() => _FoodVendorScreenState();
}

class _FoodVendorScreenState extends State<FoodVendorScreen> {
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
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  image: const DecorationImage(
                      image: AssetImage(AppImages.food1),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter),
                ),
                margin: const EdgeInsets.only(bottom: 240),
              ),
              Positioned(
                  top: 44,
                  left: 25,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const ImageView.svg(
                      AppImages.icArrowBack,
                      fit: BoxFit.fill,
                      width: 24,
                      height: 24,
                    ),
                  )),
              Positioned(
                left: 25,
                top: 108,
                child: SizedBox(
                  height: 24,
                  child: ButtonView(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
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
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 166,
                left: 0,
                right: 0,
                child: FoodDetailsCard(
                  address: '12 Chime’s Avenue, New Heaven, Enugu.',
                  distance: '20km away',
                  options: ['Wines', 'Soft Drinks', 'Spirit'],
                  rating: '3.6  (500+)',
                  title: 'Nice Wine and Bar',
                ),
              ),
              const Positioned(
                  top: 144,
                  right: 88,
                  child: ImageView.svg(
                    AppImages.icLike,
                    width: 32,
                  )),
              const Positioned(
                  top: 144,
                  right: 24,
                  child: ImageView.svg(AppImages.icForward)),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 38),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  size: 24,
                  text: 'Trending Meals',
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
                      title: 'Fried Rice and Plantain',
                      titleSmall: 'Rice',
                      rating: '',
                      imageUrl: AppImages.food1,
                      duration: '',
                      discount: '',
                      titleSize: 18,
                      titleWeight: FontWeight.w700,
                      price: '2500',
                      onPressed: () {},
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
                  title: 'Rice and Stew',
                  titleSmall: 'Swallow',
                  rating: '',
                  imageUrl: AppImages.food1,
                  duration: '',
                  discount: '',
                  price: '',
                  onPressed: () => Modals.showBottomSheetModal(context,
                      borderRadius: 25,
                      page: const MealDetail(
                          child: AddMealContent(
                            businessName: '',
                            imageUrl: '',
                            price: 0.0,
                            prepTime: '',
                            productId: '',
                          ),
                          imageUrl: ''),
                      isScrollControlled: true,
                      heightFactor: 0.9),
                );
              })),
        ],
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(vertical: 65, horizontal: 21),
        child: ButtonView(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
          onPressed: () {},
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
}
