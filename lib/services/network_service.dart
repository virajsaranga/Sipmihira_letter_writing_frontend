import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NetworkHandler {
  static final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  static Future<void> storeToken(String? token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> readToken() async {
    return await storage.read(key: "token");
  }

  static AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static Future<void> storeRefreshToken(String? refreshToken) async {
    await storage.write(key: "refreshToken", value: refreshToken);
  }
}
