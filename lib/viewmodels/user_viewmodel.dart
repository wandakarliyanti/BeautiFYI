import 'package:flutter/material.dart';
import 'package:uas_mobile/database/database_helper.dart';
import 'package:uas_mobile/providers/user_provider.dart';
import 'package:uas_mobile/models/user_model.dart';

class UserViewModel with ChangeNotifier {
  final UserProvider _userProvider = UserProvider();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  bool get isLoggedIn => _userProvider.isLoggedIn;

  Future<void> login(String email, String password) async {
    try {
      UserModel? user = await _databaseHelper.getUser(email, password);
      if (user != null) {
        _userProvider.login();
      } else {
        throw Exception('Invalid email or password');
      }
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  void logout() {
    _userProvider.logout();
  }

  Future<void> registerUser(String fullname, String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      throw Exception('Passwords do not match');
    }
    try {
      UserModel user = UserModel(
        fullname: fullname,
        email: email,
        password: password,
      );
      await _databaseHelper.insertUser(user);
      _userProvider.login();
    } catch (e) {
      throw Exception('Failed to register');
    }
  }
}
