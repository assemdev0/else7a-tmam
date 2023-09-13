import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/app_colors_light.dart';

class AppDefaultButton extends StatelessWidget {
  const AppDefaultButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return EasyButton(
      idleStateWidget: Text(text),
      loadingStateWidget: const CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColorsLight.whiteColor,
        ),
      ),
      type: EasyButtonType.elevated,
      onPressed: () async {
        return onPressed();
      },
      buttonColor: AppColorsLight.primaryColor,
      elevation: 4.0.w,
      width: 75.0.w,
      height: 6.0.h,
      useEqualLoadingStateWidgetDimension: true,
      useWidthAnimation: true,
      borderRadius: 5.0.w,
    );
  }
}
