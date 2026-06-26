import 'api_service.dart';
import 'storage_service.dart';

class AuthService {

  /// Login User
  static Future<bool> login(
      String email,
      String password) async {

    try {

      final result =
          await ApiService.login(
        email,
        password,
      );

      // Verify JWT exists
      if (result.containsKey("access_token")) {

        await StorageService.saveToken(
          result["access_token"],
        );

        return true;
      }

      return false;

    } catch (e) {

      print("Login Error : $e");

      return false;
    }
  }

  /// Logout User
  static Future<void> logout() async {

    await StorageService.logout();
  }

  /// Check Login Status
  static Future<bool> isLoggedIn() async {

    return await StorageService.isLoggedIn();
  }

  /// Get JWT Token
  static Future<String?> getToken() async {

    return await StorageService.getToken();
  }

}