import 'package:flutter/material.dart';

class AuthManager with ChangeNotifier {
  /// Login controllers
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();

  /// Register controllers
  var registerEmailController = TextEditingController();
  var registerPasswordController = TextEditingController();

  /// Login with email and password
  login() {}

  /// logout
  logout() {}

  /// Register with email and password
  register() {}
}
