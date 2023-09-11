import 'package:easy_loading_button/easy_loading_button.dart';
import '/auth/presentation/manager/cubit/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global/theme/app_colors_light.dart';
import '../../../core/utilities/app_strings.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return EasyButton(
          idleStateWidget: const Text(AppStrings.login),
          loadingStateWidget: const CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColorsLight.whiteColor,
            ),
          ),
          type: EasyButtonType.elevated,
          onPressed: () async {
            return AuthCubit.get(context).login(context);
          },
          elevation: 4.0.w,
          width: 75.0.w,
          height: 6.0.h,
          useEqualLoadingStateWidgetDimension: true,
          useWidthAnimation: true,
          borderRadius: 5.0.w,
        );
      },
    );
  }
}
