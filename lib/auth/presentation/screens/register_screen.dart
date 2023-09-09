import 'package:else7a_tamam/auth/presentation/manager/cubit/cubit/auth_cubit.dart';
import 'package:else7a_tamam/core/global/theme/app_colors_light.dart';
import 'package:else7a_tamam/core/utilities/app_strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.register),
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(),
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
                    key: AuthCubit.get(context).registerFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller:
                              AuthCubit.get(context).registerEmailController,
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
                              AuthCubit.get(context).registerPasswordController,
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
                          height: 3.0.h,
                        ),
                        TextFormField(
                          controller: AuthCubit.get(context)
                              .registerConfirmPasswordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.pleaseEnterSomeText;
                            } else if (value.length < 6) {
                              return AppStrings
                                  .passwordMustBeatLeast6Characters;
                            } else if (value !=
                                AuthCubit.get(context)
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
                        if (state is AuthRegisterLoading)
                          const CircularProgressIndicator(
                            strokeWidth: 3.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColorsLight.primaryColor,
                            ),
                          )
                        else
                          ElevatedButton(
                            onPressed: () {
                              // Provider.of<AuthManager>(context, listen: false)
                              //     .register(context);
                              // context.watch().register(context);
                              AuthCubit.get(context).register(context);
                            },
                            child: const Text(AppStrings.register),
                          ),
                        // const RegisterButtonWidget(),
                        // EasyButton(
                        //   idleStateWidget: const Text(AppStrings.register),
                        //   loadingStateWidget: const CircularProgressIndicator(
                        //     strokeWidth: 3.0,
                        //     valueColor: AlwaysStoppedAnimation<Color>(
                        //       AppColorsLight.whiteColor,
                        //     ),
                        //   ),
                        //   type: EasyButtonType.elevated,
                        //   onPressed: () async {
                        //     return Provider.of<AuthManager>(context, listen: false)
                        //         .register(context);
                        //   },
                        //   elevation: 4.0.w,
                        //   width: 75.0.w,
                        //   height: 6.0.h,
                        //   useEqualLoadingStateWidgetDimension: true,
                        //   useWidthAnimation: true,
                        //   borderRadius: 5.0.w,
                        // ),
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
