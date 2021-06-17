import 'package:flutter/material.dart';

import 'package:factories/domain/repositories/auth_repository.dart';

class LoginBLoC extends ChangeNotifier {
  LoginBLoC({required this.auth});
  final AuthRepository auth;

  final userTextEditController = TextEditingController();
  final passTextEditController = TextEditingController();
  bool isLoading = false;
  bool isAuthenticated = false;
  bool showErrorMessage = false;

  Future<void> login() async {
    isLoading = true;
    showErrorMessage = false;
    notifyListeners();

    isAuthenticated = await auth.login(
      userTextEditController.text,
      passTextEditController.text,
    );
    if (!isAuthenticated) showErrorMessage = true;

    isLoading = false;
    notifyListeners();
  }
}
