import '/core/global/theme/app_colors_light.dart';

import '/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';

class WisdomMenuErrorWidget extends StatelessWidget {
  const WisdomMenuErrorWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColorsLight.errorColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
