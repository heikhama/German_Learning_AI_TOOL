import 'dart:io';

import '../models/user_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  //---------------------------------------------------------
  // Register
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await ApiService.register(
        name: name,
        email: email,
        password: password,
      );

      if (result["success"] == true) {
        return result;
      }

      return {
        "success": false,
        "message":
            result["detail"] ?? result["message"] ?? "Registration failed",
      };
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  //---------------------------------------------------------
  // Login
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await ApiService.login(email, password);

      if (result["success"] == true) {
        final token = result["data"]["access_token"];

        await StorageService.saveToken(token);

        return {"success": true, "message": result["message"]};
      }

      return {
        "success": false,
        "message":
            result["detail"] ??
            result["message"] ??
            "Invalid email or password",
      };
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  //---------------------------------------------------------
  // Logout
  //---------------------------------------------------------

  static Future<void> logout() async {
    await StorageService.logout();
  }

  //---------------------------------------------------------
  // Is Logged In
  //---------------------------------------------------------

  static Future<bool> isLoggedIn() async {
    return StorageService.isLoggedIn();
  }

  //---------------------------------------------------------
  // JWT Token
  //---------------------------------------------------------

  static Future<String?> getToken() async {
    return StorageService.getToken();
  }

  //---------------------------------------------------------
  // Get User Profile
  //---------------------------------------------------------

  static Future<UserModel?> getProfile() async {
    print("==========================================");
    print("AuthService.getProfile()");
    print("==========================================");

    try {
      final token = await StorageService.getToken();

      print("Token:");
      print(token);

      if (token == null) {
        print("Token is NULL");

        return null;
      }

      final result = await ApiService.getProfile(token);

      print("Response From API:");

      print(result);

      //------------------------------------------------

      if (result.containsKey("success")) {
        if (result["success"] != true) {
          print("API returned success=false");

          return null;
        }

        final user = UserModel.fromJson(result["data"]);

        print("User Loaded");
        print(user.toJson());

        return user;
      }

      //------------------------------------------------
      // Direct User JSON
      //------------------------------------------------

      final user = UserModel.fromJson(result);

      print("Direct User Loaded");

      print(user.toJson());

      return user;
    } catch (e) {
      print("Exception:");

      print(e);

      return null;
    }
  }

  //---------------------------------------------------------
  // Update Profile
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> updateProfile(String name) async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        return {"success": false, "message": "Please login again"};
      }

      return await ApiService.updateProfile(token: token, name: name);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  //---------------------------------------------------------
  // Upload Avatar
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> uploadAvatar(File image) async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        return {"success": false, "message": "Please login again"};
      }

      return await ApiService.uploadAvatar(token: token, image: image);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  //---------------------------------------------------------
  // Change Password
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        return {"success": false, "message": "Please login again"};
      }

      return await ApiService.changePassword(
        token: token,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  //---------------------------------------------------------
  // Change Email
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> changeEmail(String email) async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        return {"success": false, "message": "Please login again"};
      }

      return await ApiService.changeEmail(token: token, newEmail: email);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  //---------------------------------------------------------
  // Get Learning Preferences
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> getPreferences() async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        return {"success": false, "message": "Please login again"};
      }

      return await ApiService.getPreferences(token: token);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  //---------------------------------------------------------
  // Update Learning Preferences
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> updatePreferences({
    required String language,

    required String category,

    required String level,

    required int wordsPerSession,
  }) async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        return {"success": false, "message": "Please login again"};
      }

      return await ApiService.updatePreferences(
        token: token,

        language: language,

        category: category,

        level: level,

        wordsPerSession: wordsPerSession,
      );
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
