import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../chow_ordering/widget/products_card.dart';
import '../modals.dart';
import '../widgets/cart_icon.dart';
import '../widgets/custom_text.dart';
import '../widgets/filter_search_section.dart';
import 'filter_modal.dart';

class PopularGroceryVendors extends StatelessWidget {
  const PopularGroceryVendors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: CustomText(
            size: 18,
            text: 'Popular Grocery Vendors',
            color: Theme.of(context).textTheme.bodyText1!.color,
            weight: FontWeight.w600,
          ),
          actions: const [CartIcon()],
          backgroundColor: Theme.of(context).primaryColor),
      body: Column(
        children: [
          const SizedBox(height: 19),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FilterSearchView(
              hintText: 'Search for Grocery or Vendor',
              onFilterTap: () {
                Modals.showBottomSheetModal(context,
                    page: const FilterModalContent(),
                    isScrollControlled: true,
                    heightFactor: 0.9);
              },
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return ProductCard.popular(
                    details:
                        'Check in for all your African Delicacies and Grocery ',
                    title: 'Dreams Grocery & Bar',
                    rating: '3.6(500+)',
                    imageUrl: AppImages.grocery,
                    duration: '20 - 30 mins',
                    discount: '20% Discount',
                    onPressed: () {},
                  );
                })),
          ),
        ],
      ),
    );
  }
}
