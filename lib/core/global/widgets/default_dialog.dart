import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:else7a_tamam/core/global/theme/app_colors_light.dart';
import 'package:else7a_tamam/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColorsLight.textDarkColor,
      ),
      btnOkText: AppStrings.ok,
      btnOkOnPress: btnOkOnPress,
    );
