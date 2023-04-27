import 'package:chow/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/products/products.dart';
import '../../../model/data_models/user/user.dart';
import '../../../model/view_models/products_view_model.dart';
import '../../../requests/repositories/products_repository/product_repository_impl.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/filter_search_section.dart';
import '../../widgets/image_view.dart';
import '../../widgets/loading_page.dart';

class Vendors extends StatelessWidget {
  const Vendors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (BuildContext context) => ProductsCubit(
          productsRepository: ProductRepositoryImpl(),
          viewModel: Provider.of<ProductsViewModel>(context, listen: false)),
      child: const VendorContainer(),
    );
  }
}

class VendorContainer extends StatefulWidget {
  const VendorContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<VendorContainer> createState() => _VendorContainerState();
}

class _VendorContainerState extends State<VendorContainer>
    with WidgetsBindingObserver {
  late ProductsCubit _productsCubit;

  var vendors;

  var vendorsList = [];
  var searchCtrl = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _asyncInitMethod();
    super.initState();
  }

  void _asyncInitMethod() {
    _productsCubit = context.read<ProductsCubit>();
    _productsCubit.getAllProducts();
    vendors = _productsCubit.viewModel.productVendors;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: FilterSearchView(
            controller: searchCtrl,
            onSearchTap: () {},
            onFilterTap: () {},
            onChanged: (val) {
              searchVendor(val);
            },
            showFilter: false,
          ),
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
              final productsList = _productsCubit.viewModel.foods;

              final vendorList = [];
              bool addIt = false;
              for (var vendor in productsList) {
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
              return Expanded(
                flex: 11,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: vendorList.length,
                    itemBuilder: ((context, index) {
                      final vendor = vendorList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context, vendor.vendor);
                        },
                        child: Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: (vendor.vendor?.picture?.url == null)
                                        ? const ImageView.asset(
                                            AppImages.icon,
                                            height: 65,
                                            width: 65,
                                          )
                                        : ImageView.network(
                                            vendor.vendor?.picture?.url,
                                            height: 75,
                                            width: 75,
                                            fit: BoxFit.fill),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: vendor.vendor?.businessName,
                                          color: Colors.black,
                                          size: 16,
                                          weight: FontWeight.w700,
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            const ImageView.svg(
                                                AppImages.icHouse),
                                            const SizedBox(width: 13.83),
                                            Flexible(
                                              child: CustomText(
                                                text: vendor.vendor?.location ??
                                                    '',
                                                maxLines: 2,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .color,
                                                size: 14,
                                                weight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    })),
              );
            }),
      ],
    );
  }

  void searchVendor(String vendorName) {
    List<User>? results = [];

    if (vendorName.isEmpty) {
      results = _productsCubit.viewModel.productVendors;
    } else {
      results = _productsCubit.viewModel.productVendors
          ?.where((element) => element.businessName
              .toString()
              .toLowerCase()
              .contains(vendorName.toLowerCase()))
          .toList();
    }

    setState(() {
      vendors = results;
    });
  }
}
