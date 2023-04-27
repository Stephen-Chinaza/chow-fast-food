import 'package:chow/model/data_models/product/cart.dart';
import 'package:chow/model/data_models/product/product.dart';
import '../../../model/data_models/cart_info.dart';
import '../../../model/data_models/product/vendors.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductsRepository {
  @override
  Future<Products> getAllProducts(int page) async {
    final map = await Requests().get(
      AppStrings.getAllProductsUrl(page),
    );

    return Products.fromMap(map);
  }

  @override
  Future<Products> searchProductsByCat(
      {required String page, required String category}) async {
    final body = {"category": category};
    final map = await Requests().post(
        AppStrings.searchProductsByCatUrl(
          page: page,
        ),
        body: body);
    return Products.fromMap(map);
  }

  @override
  Future<Vendor> getVendors({required int page}) async {
    final vendors = await Requests().get(
      AppStrings.getVendorsUrl(page: page),
    );

    return Vendor.fromJson(vendors);
  }

  @override
  Future<Products> searchProducts(
      {required String page,
      required String productType,
      required String searchText}) async {
    final map = await Requests().post(AppStrings.searchProductsUrl(page: page),
        body: {"product_type": productType, "search_text": searchText});
    return Products.fromMap(map);
  }

  @override
  Future<Cart> addToCart(List<CartInfo> cartInfo) async {
    final map = await Requests().post(AppStrings.addProductsToCartUrl,
        body: List<dynamic>.from(cartInfo.map((item)=>item.toMap())));
    return Cart.fromJson(map);
  }

  @override
  Future<Cart> getCartProducts() async {
    final map = await Requests().get(
      AppStrings.getCartProductsUrl,
    );
    return Cart.fromJson(map);
  }

  @override
  Future<Cart> deleteFromCart({required String productId}) async {
    final map = await Requests().post(
      AppStrings.removeProductsFromCartUrl(
        productId: productId,
      ),
    );
    return Cart.fromJson(map);
  }

  @override
  Future<Products> getVendorProducts(
      {required int page, required String? vendorId}) async {
    final map = await Requests().get(
      AppStrings.getVendorProductsUrl(page: page, vendorId: vendorId),
    );
    return Products.fromMap(map);
  }

  @override
  Future<List<Product>> getProductCategories(
      {required String productType}) async {
    final map = await Requests().get(
      AppStrings.getAvailableCategoriesUrl(productType: productType),
    );

    return List<Product>.from(map["products"].map((x) => Product.fromJson(x)));
  }

  @override
  Future<List<Product>> searchProductsByType(
      {required String page, required String productType}) async {
    final map = await Requests().post(
        AppStrings.getProductsByTypeUrl(
          page: page,
        ),
        body: {"product_type": productType});
    return List<Product>.from(map["products"].map((x) => Product.fromJson(x)));
  }
}
