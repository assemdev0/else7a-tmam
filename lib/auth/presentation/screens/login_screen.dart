import 'package:else7a_tamam/auth/presentation/screens/register_screen.dart';
import 'package:else7a_tamam/auth/presentation/widgets/login_button_widget.dart';
import 'package:else7a_tamam/core/global/theme/app_colors_light.dart';
import 'package:else7a_tamam/core/utilities/app_strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../manager/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.login),
      ),
      body: BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.0.w,
                  vertical: 3.0.h,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColorsLight.whiteColor,
                      border: Border.all(
                        color: AppColorsLight.primaryColor,
                        width: 0.5.w,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(5.0.w),
                      boxShadow: [
                        BoxShadow(
                          color: AppColorsLight.shadowColor.withOpacity(0.7),
                          blurRadius: 10.0.w,
                          spreadRadius: 2.w,
                          offset: const Offset(0, 5),
                        ),
                      ]),
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.0.w,
                    vertical: 4.0.h,
                  ),
                  child: Form(
                    key: AuthCubit.get(context).loginFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller:
                              AuthCubit.get(context).loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            final bool isValid =
                                EmailValidator.validate(value ?? '');
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
                              AuthCubit.get(context).loginPasswordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.pleaseEnterSomeText;
                            } else if (value.length < 6) {
                              return AppStrings
                                  .passwordMustBeatLeast6Characters;
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
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(AppStrings.createNewAccount)),
                        ),
                        SizedBox(
                          height: 0.8.h,
                        ),
                        const LoginButtonWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
