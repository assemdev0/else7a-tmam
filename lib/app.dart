import '/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'auth/presentation/manager/auth_manager.dart';
import 'auth/presentation/screens/login_screen.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/services/services_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthManager>()),
      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return MaterialApp(
            theme: getThemeDataLight(),
            title: AppStrings.appName,
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
