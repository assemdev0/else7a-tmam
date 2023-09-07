import 'package:flutter/material.dart';

import 'auth/presentation/screens/login_screen.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getThemeDataLight(),
      home: const LoginScreen(),
    );
  }
}
