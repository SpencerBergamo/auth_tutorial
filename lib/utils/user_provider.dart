import 'package:auth_tutorial/repositories/auth_repo.dart';
import 'package:auth_tutorial/utils/active_user.dart';
import 'package:flutter/material.dart';

// User Provider used to notify listeners when user data is updated

class UserProvider extends ChangeNotifier {
  ActiveUser? _user;
  final AuthRepository _authMethods = AuthRepository();

  ActiveUser get getUser => _user!;

  Future<void> refreshUser() async {
    ActiveUser user = await _authMethods.getuserDetails();

    _user = user;
    notifyListeners();
  }
}
