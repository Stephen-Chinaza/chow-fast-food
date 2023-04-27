import 'package:chow/model/data_models/product/product.dart';
import 'package:chow/ui/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/products/products.dart';
import '../../model/view_models/products_view_model.dart';
import '../../requests/repositories/products_repository/product_repository_impl.dart';
import '../widgets/empty_widget.dart';
import '../widgets/filter_search_section.dart';
import '../widgets/loading_page.dart';
import 'widget/choose_meal_card.dart';

class ChooseChowScreen extends StatelessWidget {
  const ChooseChowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<ProductsCubit>(
      create: (BuildContext context) => ProductsCubit(
          productsRepository: ProductRepositoryImpl(),
          viewModel: Provider.of<ProductsViewModel>(context, listen: false)),
      child: const ChooseChow());
}

class ChooseChow extends StatefulWidget {
  const ChooseChow({Key? key}) : super(key: key);

  @override
  State<ChooseChow> createState() => _ChooseChowState();
}

class _ChooseChowState extends State<ChooseChow> {
  final _scrollController = ScrollController();

  late ProductsCubit _productsCubit;

  @override
  void initState() {
    _productsCubit = context.read<ProductsCubit>();
    _productsCubit.getAllProducts();
    _initScrollListener();
    super.initState();
  }

  void _initScrollListener() {
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.9 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        /// call fetch more method here
        _productsCubit.getAllProducts(page: _productsCubit.page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductsCubit>().viewModel;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Choose chow',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))),
        body: BlocConsumer<ProductsCubit, ProductsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              final _foods = viewModel.foods;
              if (state is ProductsLoading && _foods.isEmpty) {
                return const LoadingPage(length: 15);
              } else if (state is ProductNetworkErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _productsCubit.getAllProducts(),
                );
              }
              return ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(25.0),
                children: [
                  const FilterSearchView(),
                  const SizedBox(height: 15),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      for (Product meal in _foods) ...[ChooseMealCard(meal)],
                      if (state is ProductsLoadingMore) ...[
                        ProgressIndicators.linearProgressBar(context)
                      ]
                    ],
                  )
                ],
              );
            }));
  }
}
