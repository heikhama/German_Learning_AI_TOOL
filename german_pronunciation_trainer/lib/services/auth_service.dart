import 'api_service.dart';
import 'storage_service.dart';

class AuthService {

  //------------------------------------------------
  // Register
  //------------------------------------------------

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {

    try {

      final result = await ApiService.register(
        name,
        email,
        password,
      );

      if (result.containsKey("success")) {

        return {
          "success": result["success"],
          "message": result["message"],
        };

      }

      return {
        "success": false,
        "message": result["detail"] ??
            "Registration Failed",
      };

    } catch (e) {

      return {
        "success": false,
        "message": e.toString(),
      };

    }

  }

  //------------------------------------------------
  // Login
  //------------------------------------------------

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {

    try {

      final result = await ApiService.login(
        email,
        password,
      );

      if (result["success"] == true) {

        await StorageService.saveToken(
          result["data"]["access_token"],
        );

        return {
          "success": true,
          "message": result["message"],
        };

      }

      return {
        "success": false,
        "message": result["detail"] ??
            "Invalid Email or Password",
      };

    } catch (e) {

      return {
        "success": false,
        "message": e.toString(),
      };

    }

  }

  //------------------------------------------------
  // Logout
  //------------------------------------------------

  static Future<void> logout() async {

    await StorageService.logout();

  }

  //------------------------------------------------
  // Login Status
  //------------------------------------------------

  static Future<bool> isLoggedIn() async {

    return StorageService.isLoggedIn();

  }

  //------------------------------------------------
  // Get Token
  //------------------------------------------------

  static Future<String?> getToken() async {

    return StorageService.getToken();

  }

}