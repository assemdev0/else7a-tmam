import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global/theme/app_colors_light.dart';
import '../../../core/global/widgets/app_default_button.dart';
import '../../../core/utilities/app_strings.dart';
import '../manager/auth_cubit.dart';
import 'package:flutter/material.dart';

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
