import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../core/global/widgets/default_dialog.dart';
import '/auth/presentation/screens/login_screen.dart';
import '/core/utilities/app_constance.dart';
import '/core/utilities/enums.dart';
import '/wisdom//presentation/screens/wisdom_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/network/shared_preferences.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../../core/utilities/app_strings.dart';
import '../../domain/use_cases/login_with_email_usecase.dart';
import '../../domain/use_cases/logout_usecase.dart';
import '../../domain/use_cases/register_with_email_usecase.dart';

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

  /// Register controllers
  final registerFormKey = GlobalKey<FormState>();
  var registerEmailController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerConfirmPasswordController = TextEditingController();

  /// Login with email and password
  login(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      emit(AuthLoginLoading());
      final result = await loginWithEmailUseCase(
        AuthParams(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        ),
      );

      result.fold(
        (l) {
          defaultAppDialog(
            context: context,
            dialogType: DialogType.error,
            title: AppStrings.error,
            desc: l.message,
            btnOkOnPress: () {},
          ).show();
          emit(AuthLoginFailed());
        },
        (r) {
          defaultAppDialog(
            context: context,
            dialogType: DialogType.success,
            title: AppStrings.success,
            desc: AppStrings.loginSuccess,
            btnOkOnPress: () {
              AppConstance.uId = r.uid;
              SharedPref.setData(key: AppConstance.uIdKey, value: r.uid);
              if (r.email!.contains('admin')) {
                AppConstance.userType = UserType.admin.name;
                SharedPref.setData(
                    key: AppConstance.userTypeKey,
                    value: AppConstance.userType);
              } else {
                AppConstance.userType = UserType.user.name;
                SharedPref.setData(
                    key: AppConstance.userTypeKey,
                    value: AppConstance.userType);
              }
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const WisdomMenuScreen(),
                ),
                (route) => false,
              );
            },
          ).show();
          emit(AuthLoginSuccess());
        },
      );
    }
  }

  /// logout
  logout(BuildContext context) async {
    emit(AuthLogoutLoading());
    final result = await logoutUseCase(const NoParams());

    result.fold(
      (l) {
        log("Error is: ${l.message}");
        defaultAppDialog(
          context: context,
          dialogType: DialogType.error,
          title: AppStrings.error,
          desc: l.message,
          btnOkOnPress: () {},
        ).show();
        emit(AuthLogoutFailed());
      },
      (r) {
        defaultAppDialog(
          context: context,
          dialogType: DialogType.success,
          title: AppStrings.success,
          desc: AppStrings.logoutSuccess,
          btnOkOnPress: () {
            SharedPref.deleteData(key: AppConstance.uIdKey);
            SharedPref.deleteData(key: AppConstance.userTypeKey);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          },
        ).show();
      },
    );
  }

  /// Register with email and password
  register(BuildContext context) async {
    if (registerFormKey.currentState!.validate()) {
      emit(AuthRegisterLoading());
      final result = await registerWithEmailUseCase(
        AuthParams(
          email: registerEmailController.text,
          password: registerPasswordController.text,
        ),
      );

      result.fold(
        (l) {
          defaultAppDialog(
            context: context,
            dialogType: DialogType.error,
            title: AppStrings.error,
            desc: l.message,
            btnOkOnPress: () {},
          ).show();
          emit(AuthRegisterFailed());
        },
        (r) {
          defaultAppDialog(
            context: context,
            dialogType: DialogType.success,
            title: AppStrings.success,
            desc: AppStrings.registerSuccess,
            btnOkOnPress: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ).show();
          emit(AuthRegisterSuccess());
        },
      );
    }
  }
}
