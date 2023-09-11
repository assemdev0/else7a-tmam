import 'package:else7a_tamam/core/utilities/app_constance.dart';
import 'package:else7a_tamam/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
      ),
      body: Center(
        child: Column(
          children: [
            Text('''UserType: ${AppConstance.userType}
uId: ${AppConstance.uId}'''),
            ElevatedButton(
              onPressed: () {
                // AuthCubit.get(context).logout(context);
              },
              child: const Text(AppStrings.logout),
            ),
          ],
        ),
      ),
    );
  }
}
