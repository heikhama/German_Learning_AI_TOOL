import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String tokenKey = "jwt_token";

  /// Save JWT Token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(tokenKey, token);
  }

  /// Read JWT Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    // return prefs.getString(tokenKey);
    final token = prefs.getString(tokenKey);

    // print("Stored Token = $token");

    return token;
  }

  /// Delete JWT Token
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(tokenKey);
  }

  /// Check Login Status
  static Future<bool> isLoggedIn() async {
    final token = await getToken();

    return token != null && token.isNotEmpty;
  }

  /// Logout User
  static Future<void> logout() async {
    await removeToken();
  }
}
