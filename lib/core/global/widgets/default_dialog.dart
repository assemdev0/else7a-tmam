import 'package:awesome_dialog/awesome_dialog.dart';
import '/core/global/theme/app_colors_light.dart';
import '/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

AwesomeDialog defaultAppDialog({
  required BuildContext context,
  required String title,
  required String desc,
  required DialogType dialogType,
  required Function() btnOkOnPress,
}) =>
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      descTextStyle: TextStyle(
        fontSize: 16.5.sp,
        fontWeight: FontWeight.w400,
        color: AppColorsLight.textDarkColor,
      ),
      btnOkText: AppStrings.ok,
      btnOkOnPress: btnOkOnPress,
    );
