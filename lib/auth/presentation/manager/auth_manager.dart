import 'package:awesome_dialog/awesome_dialog.dart';
import '/core/usecase/base_usecase.dart';
import '/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../core/services/services_locator.dart';
import '../../domain/use_cases/login_with_email_usecase.dart';
import '../../domain/use_cases/logout_usecase.dart';
import '../../domain/use_cases/register_with_email_usecase.dart';

class AuthManager with ChangeNotifier {
  /// Use Cases
  final LoginWithEmailUseCase loginWithEmailUseCase = sl();
  final RegisterWithEmailUseCase registerWithEmailUseCase = sl();
  final LogoutUseCase logoutUseCase = sl();

  /// Login controllers
  final loginFormKey = GlobalKey<FormState>();
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();

  /// Register controllers
  final registerFormKey = GlobalKey<FormState>();
  var registerEmailController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerConfirmPasswordController = TextEditingController();

  /// Login with email and password
  login(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      final result = await loginWithEmailUseCase(
        AuthParams(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        ),
      );

      result.fold(
        (l) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: AppStrings.error,
            desc: l.message,
            btnOkOnPress: () {},
          ).show();
        },
        (r) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: AppStrings.success,
            desc: AppStrings.loginSuccess,
            btnOkOnPress: () {},
          ).show();
        },
      );
    }
  }

  /// logout
  logout(BuildContext context) async {
    final result = await logoutUseCase(const NoParams());

    result.fold(
      (l) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: AppStrings.error,
          desc: l.message,
          btnOkOnPress: () {},
        ).show();
      },
      (r) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: AppStrings.success,
          desc: AppStrings.logoutSuccess,
          btnOkOnPress: () {},
        ).show();
      },
    );
  }

  /// Register with email and password
  register(BuildContext context) async {
    if (registerFormKey.currentState!.validate()) {
      final result = await registerWithEmailUseCase(
        AuthParams(
          email: registerEmailController.text,
          password: registerPasswordController.text,
        ),
      );

      result.fold(
        (l) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: AppStrings.error,
            desc: l.message,
            btnOkOnPress: () {},
          ).show();
        },
        (r) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: AppStrings.success,
            desc: AppStrings.registerSuccess,
            btnOkOnPress: () {},
          ).show();
        },
      );
    }
  }
}
