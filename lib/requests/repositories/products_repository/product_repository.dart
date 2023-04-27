import '../../../model/data_models/cart_info.dart';
import '../../../model/data_models/product/cart.dart';
import '../../../model/data_models/product/product.dart';
import '../../../model/data_models/product/vendors.dart';

abstract class ProductsRepository {
  Future<Vendor> getVendors({
    required int page,
  });

  Future<Products> getAllProducts(int page);

  Future<Products> searchProducts(
      {required String page,
      required String productType,
      required String searchText});

  Future<Cart> addToCart(List<CartInfo> cartInfo);

  Future<Cart> getCartProducts();

  Future<Cart> deleteFromCart({
    required String productId,
  });

  Future<Products> getVendorProducts({
    required int page,
    required String? vendorId,
  });

  Future<Products> searchProductsByCat({
    required String page,
    required String category,
  });

  Future<List<Product>> getProductCategories({
    required String productType,
  });

  Future<List<Product>> searchProductsByType({
    required String page,
    required String productType,
  });
}
