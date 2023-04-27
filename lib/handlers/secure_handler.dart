import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/data_models/user/user_data.dart';

class StorageHandler {
  // Create storage
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<void> saveUserDetails([UserData? userData]) async {
    // Write user details
    if (userData != null)
      await storage.write(key: 'USER', value: userData.toJson());
  }

  static Future<UserData?> getUserDetails() async {
    // Read all user details
    Map<String, String> value = await storage.readAll();
    UserData? user;
    String? data = value['USER'];
    if (data != null) {
      user = UserData.fromJson(data);
    }
    return user;
  }

  static Future<String?> getAccessToken() async {
    // Read user access token
    Map<String, String> value = await storage.readAll();
    UserData? user;
    String? data = value['USER'];
    if (data != null) {
      user = UserData.fromJson(data);
    }
    return user != null ? '${user.tokenType} ${user.accessToken}' : null;
  }

  static Future<void> clearUserDetails() async {
    // Delete user data
    await storage.delete(key: 'USER');
  }

  static Future<void> clearCache() async {
    // Delete all saved data
    await storage.deleteAll();
  }

  static Future<void> saveCartDetails(
      {required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> getCartDetails(
      {required String key}) async {
    String? value = await storage.read(key: key);

    return value;
  }
}
