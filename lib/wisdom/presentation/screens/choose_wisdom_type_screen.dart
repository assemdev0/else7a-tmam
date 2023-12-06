import 'package:else7a_tamam/wisdom/presentation/screens/wisdom_menu_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/utilities/app_strings.dart';
import 'theoretical_wisdoms_screen.dart';

class ChooseWisdomTypeScreen extends StatelessWidget {
  const ChooseWisdomTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.chooseWisdomType),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const WisdomMenuScreen();
                    },
                  ),
                );
              },
              child: const Text(AppStrings.normalWisdom),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const TheoreticalWisdomsScreen();
                    },
                  ),
                );
              },
              child: const Text(AppStrings.theoretical),
            ),
          ],
        ),
      ),
    );
  }
}
