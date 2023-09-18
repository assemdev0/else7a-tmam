import '/core/utilities/app_strings.dart';
import '/wisdom/presentation/manager/wisdom_menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/global/widgets/app_default_button.dart';

class AddNewWisdomMenuScreen extends StatelessWidget {
  const AddNewWisdomMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addNewWisdomMenu),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        child: Column(
          children: [
            TextFormField(
              controller: WisdomMenuCubit.get(context).wisdomMenuNameController,
              decoration: const InputDecoration(
                labelText: AppStrings.wisdomMenuName,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            TextFormField(
              controller: WisdomMenuCubit.get(context).wisdomNameController,
              decoration: const InputDecoration(
                labelText: AppStrings.wisdomName,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            AppDefaultButton(
              onPressed: () {
                return WisdomMenuCubit.get(context).addNewWisdomMenu(context);
              },
              text: AppStrings.addNewWisdomMenu,
            ),
          ],
        ),
      ),
    );
  }
}
