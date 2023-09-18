import '../../../core/global/widgets/app_default_button.dart';
import '../manager/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utilities/app_strings.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return AppDefaultButton(
          onPressed: () {
            return AuthCubit.get(context).login(context);
          },
          text: AppStrings.login,
        );
      },
    );
  }
}
