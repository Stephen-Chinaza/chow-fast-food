import 'package:flutter/material.dart';

import '../../model/data_models/product/product.dart';
import '../chow_ordering/widget/products_card.dart';
import '../modals.dart';
import 'cart_icon.dart';
import 'custom_text.dart';
import 'filter_search_section.dart';
import '../drinks_section/filter_modal.dart';

class AllVendors extends StatefulWidget {
  const AllVendors({Key? key}) : super(key: key);

  @override
  State<AllVendors> createState() => _AllVendorsState();
}

class _AllVendorsState extends State<AllVendors> {
  List<Product>? vendors = [];
  List<Product>? filteredvendors;

  var searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    String title = arguments['title'];
    //final productType = arguments['product_type'];
    vendors = arguments['vendors'];
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: CustomText(
            size: 18,
            text: title,
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
              hintText: 'Search for $title or Vendor',
              controller: searchCtrl,
              onChanged: (val) {
                searchVendor(val);
              },
              showFilter: false,
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
                  itemCount: vendors?.length,
                  itemBuilder: ((context, index) {
                    filteredvendors = vendors;

                    return ProductCard.popular(
                      details: 'buisness Details',
                      title: filteredvendors?[index].vendor?.businessName ?? '',
                      rating: '3.6(500+)',
                      imageUrl: filteredvendors?[index]
                              .vendor?.product?.first.image ?? '',
                      duration: '20 - 30 mins',
                      discount: '',
                      onPressed: () {},
                    );
                  }))),
        ],
      ),
    );
  }

  void searchVendor(String vendorName) {
    List<Product>? results = [];

    if (vendorName.isEmpty) {
      results = filteredvendors;
    } else {
      results = filteredvendors
          ?.where((element) => element.vendor!.businessName
              .toString()
              .toLowerCase()
              .contains(vendorName.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredvendors = results;
    });
  }
}
