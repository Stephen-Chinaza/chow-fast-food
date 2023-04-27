import 'dart:io';

import 'package:chow/handlers/app_handler.dart';

class AppStrings {
  static const String appName = 'Chow';
  static const String _androidKey = 'Google Maps API key';
  static const String _iosKey = 'Google Maps API key';
  static final locationApiKey = Platform.isAndroid ? _androidKey : _iosKey;

  static const String networkErrorMessage = "Network error, try again later";
  static const String logoutMessage = "Are you sure you want to logout?";
  static const String proceedMessage = "Are you sure you want to Continue?";

  /// Base
  static const String mainBaseUrl = 'https://main.mychow.app/';
  static const String authBaseUrl = 'https://auth.mychow.app/';
  static const String customerBaseUrl = 'https://customer.mychow.app/';

  /// User Endpoints
  static const String loginUrl = '${authBaseUrl}auth/login/';
  static const String registerUrl = '${authBaseUrl}register/user-register/';
  static String createPinUrl({required String userId, required String pin}) =>
      '${authBaseUrl}register/create_pin/$userId/$pin';
  static const String updateUserUrl = '${authBaseUrl}data/update-user/';
  static const String fetchUserUrl = '${authBaseUrl}data/get-user/';
  static const String changePinUrl = '${authBaseUrl}data/change-pin/';
  static const String uploadAccountImageUrl =
      '${authBaseUrl}data/upload-profile-picture/';
  static const String verifyOTPUrl = '${authBaseUrl}register/verify-otp/';
  static String resendOTPUrl(String phone) =>
      '${authBaseUrl}register/resend-registration-otp/$phone/';
  static const String submitKYCUrl = '${authBaseUrl}data/submit-kyc/';
  static const String requestPinResetUrl =
      '${authBaseUrl}auth/request-pin-reset/';
  static const String confirmPinResetUrl =
      '${authBaseUrl}auth/confirm-pin-reset/';

  ///Product Endpoints
  static String getVendorsUrl({required page}) =>
      '${customerBaseUrl}product/get-vendors/$page/';
  static String getAllProductsUrl(int page) =>
      '${customerBaseUrl}product/get-all-products/$page/';
  static String getVendorProductsUrl({required vendorId, required page}) =>
      '${customerBaseUrl}product/get-vendor-products/$vendorId/$page/';
  static String searchProductsUrl({required page}) =>
      '${customerBaseUrl}product/search-products/$page/';
  static String searchProductsByCatUrl({required page}) =>
      '${customerBaseUrl}product/search-products-by-category/$page/';
  static String getAvailableCategoriesUrl({required productType}) =>
      '${customerBaseUrl}product/get-available-categories/$productType/';
  static String getProductsByTypeUrl({required page}) =>
      '${customerBaseUrl}product/search-products-by-type/$page/';
  static String addProductsToCartUrl = '${customerBaseUrl}cart/add-to-cart/';
  static String removeProductsFromCartUrl({
    required productId,
  }) =>
      '${customerBaseUrl}cart/remove-from-cart/$productId/';

  static String getCartProductsUrl = '${customerBaseUrl}cart/get-cart/';

  ///Order Endpoints
  static const String createOrderUrl = '${customerBaseUrl}order/create/';
  static String getSingleOrderUrl({required orderId}) =>
      '${customerBaseUrl}order/get-order/$orderId';
  static String getAllOrderUrl = '${customerBaseUrl}order/user-orders/';
  static String deleteSingleOrderUrl({required orderId}) =>
      '${customerBaseUrl}order/cancel-order/$orderId';
  static String trackOrderUrl({required orderId}) =>
      '${customerBaseUrl}order/track-order/$orderId';
  static const String getUserOrders = '${customerBaseUrl}order/user-orders/';

  ///Meal Plan Endpoints
  static const String createMealPlanUrl = '${customerBaseUrl}plan/create/';
  static const String getActiveMealPlansUrl =
      '${customerBaseUrl}plan/active-plans/';
  static const String getExpiredMealPlansUrl =
      '${customerBaseUrl}plan/expired-plans/';

  ///Wallet Endpoints
  static const String fundWalletUrl = '${customerBaseUrl}wallet/fund-wallet/';
  static const String getWalletBalanceUrl =
      '${customerBaseUrl}wallet/check-wallet/';

  ///Other Endpoints
  static String googlePlaceUrl(String query) =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=$query&language=en&components=country:ng'
      '&key=$locationApiKey&sessiontoken=${AppHandler.generateUniqueId()}'; //&types=address

  ///Booking Endpoints
  static const String createBookingUrl = '${customerBaseUrl}booking/create/';
  static const String getCreatedBookingUrl =
      '${customerBaseUrl}booking/get-created-bookings/';
  static const String getRequestedBookingUrl =
      '${customerBaseUrl}booking/get-requested-bookings/';
  static const String settleBookingUrl =
      '${customerBaseUrl}booking/settle-booking/';

//Notifications Endpoints
  static const String getNotificationsUrl =
      '${customerBaseUrl}notification/get-notifications/';

  static const String getSettingssUrl =
      '${customerBaseUrl}notification/get-settings/';
  static const String updateSettingsUrl =
      '${customerBaseUrl}notification/update-settings/';
}

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';
