import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {

  UserModel _user = UserModel.empty();

  bool _loading = false;

  //--------------------------------------------

  UserModel get user => _user;

  bool get loading => _loading;

  bool get isLoggedIn => _user.isLoggedIn;

  //--------------------------------------------

  Future<void> loadUser() async {

    _loading = true;

    notifyListeners();

    try {

      UserModel? profile = await AuthService.getProfile();

      if (profile != null) {

        _user = profile;

      }

    } catch (e) {

      debugPrint(
        "Load User Error : $e",
      );

    }

    _loading = false;

    notifyListeners();

  }

  //--------------------------------------------

  void updateUser(UserModel profile) {

    _user = profile;

    notifyListeners();

  }

  //--------------------------------------------

  Future<void> refresh() async {

    await loadUser();

  }

  //--------------------------------------------

  void clear() {

    _user = UserModel.empty();

    notifyListeners();

  }

}