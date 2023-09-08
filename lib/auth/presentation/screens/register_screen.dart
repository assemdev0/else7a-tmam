import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:else7a_tamam/auth/presentation/manager/auth_manager.dart';
import 'package:else7a_tamam/core/global/theme/app_colors_light.dart';
import 'package:else7a_tamam/core/utilities/app_strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.register),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 3.0.w,
            vertical: 3.0.h,
          ),
          child: Form(
            key: context.watch<AuthManager>().registerFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller:
                      context.watch<AuthManager>().registerEmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final bool isValid = EmailValidator.validate(value ?? '');
                    if (value == null || value.isEmpty) {
                      return AppStrings.pleaseEnterSomeText;
                    } else if (!isValid) {
                      return AppStrings.invalidEmail;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: AppStrings.email,
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                TextFormField(
                  controller:
                      context.watch<AuthManager>().registerPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.pleaseEnterSomeText;
                    } else if (value.length < 6) {
                      return AppStrings.passwordMustBeatLeast6Characters;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: AppStrings.password,
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                TextFormField(
                  controller: context
                      .watch<AuthManager>()
                      .registerConfirmPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.pleaseEnterSomeText;
                    } else if (value.length < 6) {
                      return AppStrings.passwordMustBeatLeast6Characters;
                    } else if (value !=
                        context
                            .watch<AuthManager>()
                            .registerPasswordController
                            .text) {
                      return AppStrings.notMach;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: AppStrings.confirmPassword,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                EasyButton(
                  idleStateWidget: const Text(AppStrings.register),
                  loadingStateWidget: const CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColorsLight.whiteColor,
                    ),
                  ),
                  type: EasyButtonType.elevated,
                  onPressed: () {
                    context.read<AuthManager>().register(context);
                  },
                  elevation: 4.0.w,
                  width: 75.0.w,
                  height: 6.0.h,
                  useEqualLoadingStateWidgetDimension: true,
                  useWidthAnimation: true,
                  borderRadius: 5.0.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
