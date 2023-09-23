import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../app_colors_light.dart';

ThemeData getThemeDataLight() => ThemeData(
      /// App Colors
      primaryColor: AppColorsLight.primaryColor,
      primaryColorLight: AppColorsLight.primaryLightColor,
      primaryColorDark: AppColorsLight.primaryDartColor,
      scaffoldBackgroundColor: AppColorsLight.scaffoldBackgroundColor,
      hintColor: AppColorsLight.accentColor,

      /// Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorsLight.primaryColor,
      ),

      /// App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsLight.appBarBackgroundColor,
        elevation: 1.0.h,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColorsLight.iconColor,
        ),
        titleTextStyle: TextStyle(
          color: AppColorsLight.whiteColor,
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
            width: 5.sp,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0.w),
          borderSide: BorderSide(
            color: AppColorsLight.primaryColor,
            width: 5.sp,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0.w),
          borderSide: BorderSide(
            color: AppColorsLight.primaryColor,
            width: 5.sp,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0.w),
          borderSide: BorderSide(
            color: AppColorsLight.errorColor,
            width: 5.sp,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0.w),
          borderSide: BorderSide(
            color: AppColorsLight.errorColor,
            width: 5.sp,
          ),
        ),
        labelStyle: TextStyle(
          color: AppColorsLight.textDarkColor,
          fontWeight: FontWeight.bold,
          fontSize: 14.0.sp,
        ),
      ),

      /// Text Theme
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: AppColorsLight.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.0.sp,
        ),
        bodyMedium: TextStyle(
          color: AppColorsLight.whiteColor,
          fontWeight: FontWeight.normal,
          fontSize: 16.5.sp,
        ),
        bodySmall: TextStyle(
          color: AppColorsLight.whiteColor,
          fontWeight: FontWeight.w300,
          fontSize: 15.0.sp,
        ),
      ),
    );
