import 'package:chow/handlers/secure_handler.dart';

Future<Map<String, String>> rawDataHeader([String? token]) async {
  final accessToken = token ?? await StorageHandler.getAccessToken();
  return {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': accessToken,
  };
}

Future<Map<String, String>> formDataHeader([String? token]) async {
  final accessToken = token ?? await StorageHandler.getAccessToken();
  return {
    if (accessToken != null) 'Authorization': accessToken,
  };
}
