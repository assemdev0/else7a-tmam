import '/auth/presentation/manager/cubit/cubit/auth_cubit.dart';
import '/core/utilities/app_constance.dart';
import '/wisdom/presentation/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'auth/presentation/screens/login_screen.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthCubit()),
      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
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
                ? const HomeScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
