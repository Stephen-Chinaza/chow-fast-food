import 'package:chow/ui/auth/forgot_pin_otp_screen.dart';
import 'package:chow/ui/auth/forgot_pin_screen.dart';
import 'package:chow/ui/auth/reset_pin_screen.dart';
import 'package:chow/ui/chow_ordering/cart_screen.dart';
import 'package:chow/ui/chow_ordering/food_screen.dart';
import 'package:chow/ui/drinks_section/drinks_screen.dart';
import 'package:chow/ui/grocery_section/grocery_details_page.dart';
import 'package:chow/ui/payment_method/payment_method_screen.dart';
import 'package:chow/ui/location/set_location_screen.dart';
import 'package:chow/ui/auth/create_pin_screen.dart';
import 'package:chow/ui/auth/otp_screen.dart';
import 'package:chow/ui/auth/sign_in_screen.dart';
import 'package:chow/ui/auth/sign_up_screen.dart';
import 'package:chow/ui/on_boarding/welcome_screen.dart';
import 'package:chow/ui/payment_method/topup_screen.dart';
import 'package:chow/ui/payment_method/web_view_screen.dart';
import 'package:chow/ui/phamarcy_section/phamarcy_details_page.dart';
import 'package:chow/ui/plans/set_plan_screen.dart';
import 'package:chow/ui/settings/kyc_verification/kyc_verification_screen.dart';
import 'package:chow/ui/settings/notification/notification_screen.dart';
import 'package:chow/ui/settings/notification/notification_settings_screen.dart';
import 'package:chow/ui/settings/profile/profile_settings_screen.dart';
import 'package:chow/ui/splash_screen.dart';
import 'package:chow/ui/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/chow_ordering/cart_screen.dart';
import '../ui/chow_ordering/chow_detail_screen.dart';
import '../ui/chow_ordering/create_combo_screen.dart';
import '../ui/chow_ordering/widget/search_product_page.dart';
import '../ui/dashboard.dart';
import '../ui/widgets/all_vendors.dart';
import '../ui/grocery_section/grocery_screen.dart';
import '../ui/grocery_section/grocery_vendors.dart';
import '../ui/phamarcy_section/phamarcy_screen.dart';
import '../ui/phamarcy_section/phamarcy_vendors.dart';
import '../ui/plans/plans_screen.dart';
import '../ui/track_order/track_order_page.dart';
import '../ui/track_order/view_order_on_map.dart';

class AppRoutes {
  ///Route names used through out the app will be specified as static constants here in this format
  static const String splashScreen = 'splashScreen';
  static const String welcomeScreen = 'welcomeScreen';
  static const String signInScreen = 'signInScreen';
  static const String signUpScreen = 'signUpScreen';
  static const String otpScreen = 'otpScreen';
  static const String successScreen = 'successScreen';
  static const String createPinScreen = 'createPinScreen';
  static const String setLocationScreen = 'setLocationScreen';
  static const String dashboard = 'dashboard';
  static const String foodScreen = 'foodScreen';
  static const String chowDetailScreen = 'chowDetailScreen';
  static const String setPlanScreen = 'setPlanScreen';
  static const String cartScreen = 'cartScreen';
  static const String paymentMethodScreen = 'paymentMethodScreen';
  static const String kycVerificationScreen = 'kycVerificationScreen';
  static const String trackOrderScreen = 'trackOrderScreen';
  static const String viewOrderOnMap = 'viewOrderOnMap';
  static const String paymentSuccessfulScreen = 'paymentSuccessfulScreen';
  static const String createComboMealScreen = 'createComboMealScreen';
  static const String drinksScreen = 'drinksScreen';
  static const String drinksDetailScreen = 'drinksDetailScreen';
  static const String vendorsScreen = 'drinkVendorScreen';
  static const String groceryVendorScreen = 'groceryVendorScreen';
  static const String groceryDetailsScreen = 'groceryDetailsScreen';
  static const String pharmacyDetailsScreen = 'pharmacyDetailsScreen';
  static const String pharmacyScreen = 'pharmacyScreen';
  static const String groceryScreen = 'groceryScreen';
  static const String pharmacyVendorScreen = 'pharmacyVendorScreen';
  static const String topUpScreen = 'topUpScreen';
  static const String profileSettingScreen = 'profileSettingScreen';
  static const String notificationSettingScreen = 'notificationSettingScreen';
  static const String notificationScreen = 'notificationScreen';
  static const String planScreen = 'planScreen';
  static const String searchScreen = 'searchScreen';
  static const String forgotPinScreen = 'forgotPinScreen';
  static const String forgotPinOtpScreen = 'forgotPinOtpScreen';
  static const String resetPinScreen = 'resetPinScreen';
  static const String webViewScreen = 'webViewScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    ///Named routes to be added here in this format
    splashScreen: (context) => const SplashScreen(),
    welcomeScreen: (context) => const WelcomeScreen(),
    signInScreen: (context) => const SignInScreen(),
    signUpScreen: (context) => const SignUpScreen(),
    otpScreen: (context) => const OTPScreen(),
    successScreen: (context) => const SuccessScreen(),
    createPinScreen: (context) => const CreatePinScreen(),
    setLocationScreen: (context) => const SetLocationScreen.scale(),
    dashboard: (context) => const Dashboard(),
    foodScreen: (context) => const Food(),
    chowDetailScreen: (context) => const ChowDetail(),
    setPlanScreen: (context) => const SetPlanScreen(),
    cartScreen: (context) => const Cart(),
    paymentMethodScreen: (context) => const PaymentMethodScreen(),
    kycVerificationScreen: (context) => const KYCVerificationScreen(),
    trackOrderScreen: (context) => const TrackOrder(),
    viewOrderOnMap: (context) => const ViewOrderOnMap(),
    createComboMealScreen: (context) => const CreateComboScreen(),
    drinksScreen: (context) => const Drinks(),
    vendorsScreen: (context) => const AllVendors(),
    groceryDetailsScreen: (context) => const GroceryDetailScreen(),
    groceryVendorScreen: (context) => const PopularGroceryVendors(),
    pharmacyVendorScreen: (context) => const PopularPharmacyVendors(),
    pharmacyDetailsScreen: (context) => const PharmacyDetailScreen(),
    pharmacyScreen: (context) => const Pharmacy(),
    groceryScreen: (context) => const Grocery(),
    topUpScreen: (context) => const TopUpScreen(),
    profileSettingScreen: (context) => const ProfileSettingsScreen(),
    notificationSettingScreen: (context) => const NotificationSettingsScreen(),
    notificationScreen: (context) => const NotificationScreen(),
    planScreen: (context) => const PlansScreen(),
    searchScreen: (context) => const Search(),
    forgotPinScreen: (context) => const ForgotPinScreen(),
    forgotPinOtpScreen: (context) => const ForgotPinOtpScreen(),
    resetPinScreen: (context) => const ResetPinScreen(),
    webViewScreen: (context) => const WebViewScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add your screen here as well as the transition you want
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case welcomeScreen:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case signInScreen:
        return MaterialPageRoute(builder: (context) => const SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case otpScreen:
        return MaterialPageRoute(builder: (context) => const OTPScreen());
      case successScreen:
        return MaterialPageRoute(builder: (context) => const SuccessScreen());
      case createPinScreen:
        return MaterialPageRoute(builder: (context) => const CreatePinScreen());
      case setLocationScreen:
        return MaterialPageRoute(
            builder: (context) => const SetLocationScreen.scale());
      case dashboard:
        return MaterialPageRoute(builder: (context) => const Dashboard());
      case foodScreen:
        return MaterialPageRoute(builder: (context) => const Food());
      case chowDetailScreen:
        return MaterialPageRoute(builder: (context) => const ChowDetail());
      case setPlanScreen:
        return MaterialPageRoute(builder: (context) => const SetPlanScreen());
      case cartScreen:
        return MaterialPageRoute(builder: (context) => const Cart());
      case paymentMethodScreen:
        return MaterialPageRoute(
            builder: (context) => const PaymentMethodScreen());
      case kycVerificationScreen:
        return MaterialPageRoute(
            builder: (context) => const KYCVerificationScreen());
      case trackOrderScreen:
        return MaterialPageRoute(builder: (context) => const TrackOrder());
      case viewOrderOnMap:
        return MaterialPageRoute(builder: (context) => const ViewOrderOnMap());
      case createComboMealScreen:
        return MaterialPageRoute(
            builder: (context) => const CreateComboScreen());
      case drinksScreen:
        return MaterialPageRoute(builder: (context) => const Drinks());
      case pharmacyScreen:
        return MaterialPageRoute(builder: (context) => const Pharmacy());
      case pharmacyDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => const PharmacyDetailScreen());
      case vendorsScreen:
        return MaterialPageRoute(builder: (context) => const AllVendors());
      case pharmacyVendorScreen:
        return MaterialPageRoute(
            builder: (context) => const PopularPharmacyVendors());
      case groceryDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => const GroceryDetailScreen());
      case groceryVendorScreen:
        return MaterialPageRoute(
            builder: (context) => const PopularGroceryVendors());
      case groceryScreen:
        return MaterialPageRoute(builder: (context) => const Grocery());
      case topUpScreen:
        return MaterialPageRoute(builder: (context) => const TopUpScreen());
      case profileSettingScreen:
        return MaterialPageRoute(
            builder: (context) => const ProfileSettingsScreen());
      case notificationSettingScreen:
        return MaterialPageRoute(
            builder: (context) => const NotificationSettingsScreen());
      case notificationScreen:
        return MaterialPageRoute(
            builder: (context) => const NotificationScreen());
      case planScreen:
        return MaterialPageRoute(builder: (context) => const PlansScreen());
      case searchScreen:
        return MaterialPageRoute(builder: (context) => const Search());
      case forgotPinScreen:
        return MaterialPageRoute(builder: (context) => const ForgotPinScreen());
      case forgotPinOtpScreen:
        return MaterialPageRoute(
            builder: (context) => const ForgotPinOtpScreen());
      case resetPinScreen:
        return MaterialPageRoute(builder: (context) => const ResetPinScreen());
      case webViewScreen:
        return MaterialPageRoute(builder: (context) => const WebViewScreen());
      //Default Route is error route
      default:
        return CupertinoPageRoute(
            builder: (context) => errorView(settings.name!));
    }
  }

  static Widget errorView(String name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}
