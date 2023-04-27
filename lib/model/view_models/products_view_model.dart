import '../../res/enum.dart';
import '../data_models/product/cart.dart';
import '../data_models/product/product.dart';
import '../data_models/product/vendors.dart';
import '../data_models/user/user.dart';
import 'base_viewmodel.dart';

class ProductsViewModel extends BaseViewModel {
  final List<Product> _vendorProducts = [];
  Products? _products;

  Vendor? _vendors;
  final List<Items> cartItems = [];
  Cart? _cart;

  Future<void> setProducts(Products products, [bool update = false]) async {
    if (update && _products != null) {
      _products!.copyWith(
          products: _products!.products..addAll(products.products),
          lastIndex: products.lastIndex);
    } else {
      _products = products;
    }
    setViewState(ViewState.success);
  }

  Future<void> getAllVendors(
    Vendor vendors,
  ) async {
    _vendors = vendors;

    setViewState(ViewState.success);
  }

  Future<void> accessCart(Cart cart, [bool update = false]) async {
    _cart = cart;

    setViewState(ViewState.success);
  }

  List<User>? get productVendors => _vendors?.vendors ?? [];
  List<Product> get products => _products?.products ?? [];
  List<Items> get cart => _cart?.items ?? [];
  List<Product> get foods =>
      _products?.products.where((p) => p.productType == 'food').toList() ?? [];

  List<Product> get soup =>
      _products?.products
          .where((p) => p.category == 'swallow' || p.category == 'soup')
          .toList() ??
      [];

  List<Product> get rice =>
      _products?.products.where((p) => p.category == 'rice').toList() ?? [];

  List<Product> get drinks =>
      _products?.products.where((p) => p.productType == 'drinks').toList() ??
      [];

  List<Product> get groceries =>
      _products?.products.where((p) => p.productType == 'groceries').toList() ??
      [];

  List<Product> get pharmacy =>
      _products?.products.where((p) => p.productType == 'drugs').toList() ?? [];
  List<Product> get vendorProducts => _vendorProducts;

  int get lastProductPageIndex => _products?.lastIndex ?? 0;

  int get cartCount => _cart?.items.length ?? 0;
  double get cartTotalAmount => _cart?.cartCost ?? 0.0;

  int get lastVendorPageIndex => _vendors?.lastIndex ?? 0;
}
