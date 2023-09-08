import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:else7a_tamam/auth/presentation/manager/auth_manager.dart';
import 'package:else7a_tamam/auth/presentation/screens/register_screen.dart';
import 'package:else7a_tamam/core/global/theme/app_colors_light.dart';
import 'package:else7a_tamam/core/utilities/app_strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.login),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 3.0.w,
            vertical: 3.0.h,
          ),
          child: Form(
            key: context.watch<AuthManager>().loginFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: context.watch<AuthManager>().loginEmailController,
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
                      context.watch<AuthManager>().loginPasswordController,
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
                  height: 0.8.h,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(AppStrings.createNewAccount)),
                ),
                SizedBox(
                  height: 0.8.h,
                ),
                EasyButton(
                  idleStateWidget: const Text(AppStrings.login),
                  loadingStateWidget: const CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColorsLight.whiteColor,
                    ),
                  ),
                  type: EasyButtonType.elevated,
                  onPressed: () {
                    context.read<AuthManager>().login(context);
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
