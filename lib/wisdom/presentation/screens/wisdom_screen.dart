import '/core/global/theme/app_colors_light.dart';

import '/core/utilities/app_constance.dart';
import '/core/utilities/enums.dart';
import '/wisdom/domain/entities/wisdom_menu.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/utilities/app_strings.dart';
import '../manager/wisdom_menu_cubit.dart';

class WisdomScreen extends StatelessWidget {
  const WisdomScreen({Key? key, required this.wisdom}) : super(key: key);
  final WisdomMenu wisdom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wisdom.name),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppConstance.userType == UserType.admin.name
          ? FloatingActionButton(
              onPressed: () {
                WisdomMenuCubit.get(context).onAddNewSingleWisdomClicked(
                  context: context,
                  name: wisdom.name,
                );
              },
              tooltip: AppStrings.addNewWisdom,
              child: const Icon(Icons.add),
            )
          : null,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            child: Column(
              children: [
                if (wisdom.subMenu.isEmpty)
                  Text(
                    AppStrings.noData,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: wisdom.subMenu.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4.w),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                wisdom.subMenu[index],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            if (AppConstance.userType == UserType.admin.name)
                              IconButton(
                                onPressed: () {
                                  WisdomMenuCubit.get(context)
                                      .onDeleteSingleWisdomClicked(
                                    context: context,
                                    name: wisdom.name,
                                    subMenu: wisdom.subMenu[index],
                                  );
                                },
                                icon: const Icon(Icons.delete),
                                color: AppColorsLight.errorColor,
                              ),
                          ],
                        ),
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
