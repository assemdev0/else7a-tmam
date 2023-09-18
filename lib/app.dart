import 'package:responsive_sizer/responsive_sizer.dart';

import 'auth/presentation/manager/auth_cubit.dart';
import '/core/utilities/app_constance.dart';
import '/wisdom/presentation/screens/wisdom_menu_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';
import 'auth/presentation/screens/login_screen.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'wisdom/presentation/manager/wisdom_menu_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider(create: (BuildContext context) => WisdomMenuCubit()),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: const Locale('ar', 'EG'),
            supportedLocales: const [
              Locale('ar', 'EG'),
            ],
            theme: getThemeDataLight(),
            title: AppStrings.appName,
            home: AppConstance.uId.isNotEmpty
                ? const WisdomMenuScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
