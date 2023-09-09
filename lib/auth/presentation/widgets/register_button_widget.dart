import 'package:flutter/material.dart';

import '../../../core/utilities/app_strings.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Provider.of<AuthManager>(context, listen: false).register(context);
        // context.watch().register(context);
      },
      child: const Text(AppStrings.register),
    );
  }
}
