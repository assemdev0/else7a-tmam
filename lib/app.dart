import 'package:responsive_sizer/responsive_sizer.dart';

import 'auth/presentation/manager/auth_cubit.dart';
import '/core/utilities/app_constance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';
import 'auth/presentation/screens/login_screen.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/services/notifications_services.dart';
import 'wisdom/presentation/manager/wisdom_menu_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.homePage});
  final Widget homePage;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationsServices.setListeners();
    super.initState();
  }

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
            navigatorKey: MyApp.navigatorKey,
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
                ? widget.homePage
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
