import '/core/global/widgets/app_default_button.dart';
import '/core/utilities/app_strings.dart';
import '/wisdom/presentation/manager/wisdom_menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddNewWisdom extends StatelessWidget {
  const AddNewWisdom({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addNewWisdom),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.5.w,
            vertical: 2.5.h,
          ),
          child: Form(
            key: WisdomMenuCubit.get(context).addNewWisdomFormKey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  controller: WisdomMenuCubit.get(context).newWisdomController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.wisdomName,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.pleaseEnterSomeText;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                AppDefaultButton(
                  text: AppStrings.addNewWisdom,
                  onPressed: () {
                    return WisdomMenuCubit.get(context).addNewWisdom(
                      context: context,
                      name: name,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
