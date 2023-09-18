import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/global/widgets/app_default_button.dart';
import '../../../core/utilities/app_strings.dart';
import '../manager/auth_cubit.dart';

import '../../../core/utilities/app_strings.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return AppDefaultButton(
          onPressed: () {
            return AuthCubit.get(context).register(context);
          },
          text: AppStrings.register,
        );
      },
    );
  }
}
