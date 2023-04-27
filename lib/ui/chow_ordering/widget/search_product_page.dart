import 'package:chow/model/data_models/product/product.dart';
import 'package:chow/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/products/products.dart';
import '../../../model/view_models/products_view_model.dart';
import '../../../requests/repositories/products_repository/product_repository_impl.dart';
import '../../../utils/app_utils.dart';
import '../../drinks_section/filter_modal.dart';
import '../../modals.dart';
import '../../widgets/cart_icon.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/filter_search_section.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/meal_detail.dart';
import 'add_meal_content.dart';
import 'products_card.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (BuildContext context) => ProductsCubit(
          productsRepository: ProductRepositoryImpl(),
          viewModel: Provider.of<ProductsViewModel>(context, listen: false)),
      child: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with WidgetsBindingObserver {
  Map arguments = {};
  late String productType;

  late ProductsType category;
  List<Product> products = [];
  List<Product> searchResult = [];

  TextEditingController searchController = TextEditingController();
  late ProductsCubit _productsCubit;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _asyncInitMethod();
    super.initState();
  }

  void _asyncInitMethod() {
    _productsCubit = context.read<ProductsCubit>();
    _productsCubit.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
    productType = arguments['product_type'];
    category = arguments['category'];
    products = arguments['products'];

    searchResult = products;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: CustomText(
            size: 18,
            text: 'Search',
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
              hintText: 'Search for $productType or Vendor',
              controller: searchController,
              onChanged: (value) {
                if (value == '') {
                  _productsCubit.getAllProducts();
                } else {
                  switch (category) {
                    case ProductsType.food:
                      _productsCubit.searchProducts(
                          searchText: value, productType: 'food');
                      break;
                    case ProductsType.drinks:
                      _productsCubit.searchProducts(
                          searchText: value, productType: 'drinks');
                      break;
                    case ProductsType.groceries:
                      _productsCubit.searchProducts(
                          searchText: value, productType: 'groceries');
                      break;
                    case ProductsType.pharmacy:
                      _productsCubit.searchProducts(
                          searchText: value, productType: 'pharmacy');
                      break;
                  }
                }

                setState(() {});
              },
              onFilterTap: () {
                Modals.showBottomSheetModal(context,
                    page: const FilterModalContent(),
                    isScrollControlled: true,
                    heightFactor: 0.9);
              },
            ),
          ),
          const SizedBox(height: 30),
          BlocConsumer<ProductsCubit, ProductsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Expanded(child: LoadingPage(length: 12));
                } else if (state is SearchNetworkErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _productsCubit.getAllProducts(),
                  );
                }
                switch (category) {
                  case ProductsType.food:
                    products = _productsCubit.viewModel.foods;
                    break;
                  case ProductsType.drinks:
                    products = _productsCubit.viewModel.drinks;
                    break;
                  case ProductsType.groceries:
                    products = _productsCubit.viewModel.groceries;
                    break;
                  case ProductsType.pharmacy:
                    products = _productsCubit.viewModel.pharmacy;
                    break;
                }

                if (products.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: double.infinity,
                    child: const Center(
                      child: Text('No Results Found',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: products.length,
                        itemBuilder: ((context, index) {
                          final product = products[index];

                          return ProductCard.popular(
                            details: product.vendor?.businessName ?? '',
                            title: product.name,
                            rating: '3.6(500+)',
                            imageUrl: product.image,
                            duration: '20 - 30 mins',
                            discount:
                                '${product.discountPercentage}' '% Discount',
                            price: AppUtils.convertPrice(product.price),
                            onPressed: () =>
                                Modals.showBottomSheetModal(context,
                                    borderRadius: 25,
                                    page: const MealDetail(
                                        child: AddMealContent(
                                      businessName: '',
                                      imageUrl: '',
                                      price: 0,
                                      prepTime: '',
                                      productId: '',
                                    )),
                                    isScrollControlled: true,
                                    heightFactor: 0.9),
                          );
                        })),
                  );
                }
              }),
        ],
      ),
    );
  }
}
