import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../../../../../core/utilities/app_strings.dart';
import '../../../../domain/use_cases/login_with_email_usecase.dart';
import '../../../../domain/use_cases/logout_usecase.dart';
import '../../../../domain/use_cases/register_with_email_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  /// Use Cases
  final LoginWithEmailUseCase loginWithEmailUseCase = sl();
  final RegisterWithEmailUseCase registerWithEmailUseCase = sl();
  final LogoutUseCase logoutUseCase = sl();

  /// Login controllers
  final loginFormKey = GlobalKey<FormState>();
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  bool isLoginLoading = false;

  /// Register controllers
  final registerFormKey = GlobalKey<FormState>();
  var registerEmailController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerConfirmPasswordController = TextEditingController();
  bool isRegisterLoading = false;

  /// Login with email and password
  login(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      isLoginLoading = true;
      emit(AuthLoginLoading());
      final result = await loginWithEmailUseCase(
        AuthParams(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        ),
      );

      result.fold(
        (l) {
          // AwesomeDialog(
          //   context: context,
          //   dialogType: DialogType.error,
          //   animType: AnimType.bottomSlide,
          //   title: AppStrings.error,
          //   desc: l.message,
          //   btnOkOnPress: () {},
          // ).show();
          log(l.message);
          emit(AuthLoginFailed());
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
          emit(AuthLoginSuccess());
        },
      );
    }
    isLoginLoading = false;
  }

  /// logout
  logout(BuildContext context) async {
    emit(AuthLogoutLoading());
    final result = await logoutUseCase(const NoParams());

    result.fold(
      (l) {
        log("Error is: ${l.message}");
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
      emit(AuthRegisterLoading());
      isRegisterLoading = true;
      final result = await registerWithEmailUseCase(
        AuthParams(
          email: registerEmailController.text,
          password: registerPasswordController.text,
        ),
      );

      result.fold(
        (l) {
          log("Error is: ${l.message}");
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: AppStrings.error,
            desc: l.message,
            btnOkOnPress: () {},
          ).show();
          emit(AuthRegisterFailed());
        },
        (r) {
          debugPrint(r.toString());
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: AppStrings.success,
            desc: AppStrings.registerSuccess,
            btnOkOnPress: () {},
          ).show();
          emit(AuthRegisterSuccess());
        },
      );
      isRegisterLoading = false;
    }
  }
}
