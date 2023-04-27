import 'package:chow/ui/widgets/filter_search_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../blocs/products/products.dart';
import '../../../model/data_models/product/product.dart';
import '../../../model/view_models/products_view_model.dart';
import '../../../requests/repositories/products_repository/product_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../../res/enum.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_toggle.dart';
import '../../widgets/image_view.dart';
import 'chow_meal_container.dart';
import 'vendor_container.dart';

class SelectCombo extends StatelessWidget {
  final CreateComboOverlayType overlayType;
  final String? vendorId;
  const SelectCombo({
    Key? key,
    required this.overlayType,
    this.vendorId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (BuildContext context) => ProductsCubit(
          productsRepository: ProductRepositoryImpl(),
          viewModel: Provider.of<ProductsViewModel>(context, listen: false)),
      child: SelectComboOverlay(overlayType: overlayType, vendorId: vendorId),
    );
  }
}

class SelectComboOverlay extends StatefulWidget {
  final CreateComboOverlayType overlayType;
  final String? vendorId;
  const SelectComboOverlay(
      {Key? key,
      this.overlayType = CreateComboOverlayType.vendors,
      this.vendorId})
      : super(key: key);

  @override
  State<SelectComboOverlay> createState() => _SelectComboOverlayState();
}

class _SelectComboOverlayState extends State<SelectComboOverlay>
    with WidgetsBindingObserver {
  late PageController _controller;
  int initCount = 0;

  final _scrollController = ScrollController();

  late ProductsCubit _productsCubit;

  late Products riceList;
  late Products swallowList;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _asyncInitMethod();
    _initScrollListener();

    _controller = PageController(
      initialPage: 0,
    );
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

  void isSelected(int index) {
    setState(() {
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.overlayType == CreateComboOverlayType.chow) {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Select Meal',
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    textAlign: TextAlign.center,
                    size: 24,
                    weight: FontWeight.w600,
                  ),
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const ImageView.svg(AppImages.dropDown))
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              FilterSearchView(
                hintText: 'Search for Meal',
                onFilterTap: () {},
                showFilter: false,
              ),
              const SizedBox(
                height: 26,
              ),
              SizedBox(
                height: 70,
                child: CustomToggle(
                  scrollable: false,
                  backgroundColor: Colors.transparent,
                  color: Theme.of(context).primaryColor,
                  height: 32,
                  title: const ['Soup', 'Rice'],
                  contentMargin: const EdgeInsets.all(8.0),
                  onSelected: isSelected,
                ),
              ),
              Expanded(
                  flex: 8,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: [
                      ChowMealContainer(
                        product: _productsCubit.viewModel.soup,
                        vendorId: widget.vendorId,
                      ),
                      ChowMealContainer(
                        product: _productsCubit.viewModel.rice,
                        vendorId: widget.vendorId,
                      ),
                    ],
                  )),
            ],
          ));
    } else if (widget.overlayType == CreateComboOverlayType.vendors) {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Choose food vendor',
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    textAlign: TextAlign.center,
                    size: 24,
                    weight: FontWeight.w600,
                  ),
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const ImageView.svg(AppImages.dropDown))
                ],
              ),
              const Expanded(flex: 11, child: Vendors()),
            ],
          ));
    }

    return const SizedBox.shrink();
  }
}

class Food {
  final String image;
  final String name;
  final int percentage;
  final String protein;
  final String category;
  final String price;
  final String productId;
  final String quantity;

  Food({
    required this.productId,
    required this.quantity,
    required this.image,
    required this.name,
    required this.percentage,
    required this.protein,
    required this.category,
    required this.price,
  });
}
