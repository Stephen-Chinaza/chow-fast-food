import 'package:chow/blocs/products/products_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/data_models/cart_info.dart';
import '../../model/data_models/product/cart.dart';
import '../../model/data_models/product/product.dart';
import '../../model/view_models/products_view_model.dart';
import '../../requests/repositories/products_repository/product_repository.dart';
import '../../utils/exceptions.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit({required this.productsRepository, required this.viewModel})
      : super(const InitialState());
  final ProductsRepository productsRepository;
  final ProductsViewModel viewModel;
  int page = 0;

  Future<void> getAllProducts({String? vendorId = '', int page = 0}) async {
    try {
      Products products;

      if (page > viewModel.lastProductPageIndex ||
          state is ProductsLoading ||
          state is ProductsLoadingMore) {
        return;
      }

      if (page == 0) {
        emit(ProductsLoading());
      } else {
        emit(ProductsLoadingMore());
      }

      if (vendorId == '') {
        products = await productsRepository.getAllProducts(page);
      } else {
        products = await productsRepository.getVendorProducts(
            page: page, vendorId: vendorId);
      }

      await viewModel.setProducts(products, page != 0);
      emit(ProductsLoaded(products.products));
      this.page = page + 1;
    } on ApiException catch (e) {
      emit(ProductApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(ProductNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> fetchVendors([int page = 0]) async {
    try {
      // if (page > viewModel.lastPageIndex ||
      //     state is ProductsLoading ||
      //     state is ProductsLoadingMore) {
      //   return;
      // }

      // if (page == 0) {
      //   emit(ProductsLoading());
      // } else {
      //   emit(ProductsLoadingMore());
      // }

      final vendors = await productsRepository.getVendors(
        page: page,
      );

      await viewModel.getAllVendors(vendors);

      emit(VendorsLoaded(vendors.vendors));
    } on ApiException catch (e) {
      emit(VendorsApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(VendorsNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> searchProducts(
      {required String searchText,
      required String productType,
      int page = 0}) async {
    try {
      if (page > viewModel.lastProductPageIndex ||
          state is ProductsLoading ||
          state is ProductsLoadingMore) {
        return;
      }

      if (page == 0) {
        emit(ProductsLoading());
      } else {
        emit(ProductsLoadingMore());
      }

      final products = await productsRepository.searchProducts(
        page: page.toString(),
        productType: productType,
        searchText: searchText,
      );

      await viewModel.setProducts(products, page != 0);
      emit(SearchLoaded(products.products));
      this.page = page + 1;
    } on ApiException catch (e) {
      emit(SearchApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(SearchNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> addToCart(List<CartInfo> cartInfo) async {
    try {
      emit(ProductsLoading());

      final cartProducts = await productsRepository.addToCart(cartInfo);

      await viewModel.accessCart(cartProducts);
      emit(CartLoaded(cartProducts.items));
    } on ApiException catch (e) {
      emit(CartApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CartNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getCartProduct({String productId = ''}) async {
    try {
      emit(ProductsLoading());

      Cart cartProducts;

      if (productId == '') {
        cartProducts = await productsRepository.getCartProducts();
      } else {
        cartProducts =
            await productsRepository.deleteFromCart(productId: productId);
      }

      await viewModel.accessCart(cartProducts);
      emit(CartLoaded(cartProducts.items));
    } on ApiException catch (e) {
      emit(CartApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CartNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
