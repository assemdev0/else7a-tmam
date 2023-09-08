import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../app_colors_light.dart';

ThemeData getThemeDataLight() => ThemeData(
      /// App Colors
      primaryColor: AppColorsLight.primaryColor,
      primaryColorLight: AppColorsLight.primaryLightColor,
      primaryColorDark: AppColorsLight.primaryDartColor,
      scaffoldBackgroundColor: AppColorsLight.scaffoldBackgroundColor,
      hintColor: AppColorsLight.accentColor,

      /// App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsLight.appBarBackgroundColor,
        elevation: 1.0.w,
        iconTheme: const IconThemeData(
          color: AppColorsLight.iconColor,
        ),
        titleTextStyle: TextStyle(
          color: AppColorsLight.textDarkColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.0.sp,
        ),
      ),

      /// Text Field Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0.w),
          borderSide: BorderSide(
            color: AppColorsLight.primaryColor,
            width: 0.4.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0.w),
          borderSide: BorderSide(
            color: AppColorsLight.primaryColor,
            width: 0.4.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0.w),
          borderSide: BorderSide(
            color: AppColorsLight.primaryColor,
            width: 0.4.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0.w),
          borderSide: BorderSide(
            color: AppColorsLight.errorColor,
            width: 0.4.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0.w),
          borderSide: BorderSide(
            color: AppColorsLight.errorColor,
            width: 0.4.w,
          ),
        ),
        labelStyle: TextStyle(
          color: AppColorsLight.textDarkColor,
          fontWeight: FontWeight.bold,
          fontSize: 13.0.sp,
        ),
      ),
    );
