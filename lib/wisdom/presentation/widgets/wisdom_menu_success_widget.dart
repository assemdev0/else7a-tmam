import '/auth/presentation/manager/auth_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '/wisdom/presentation/manager/wisdom_menu_cubit.dart';
import 'package:flutter/material.dart';

import '/core/utilities/app_constance.dart';
import '/core/utilities/app_strings.dart';
import '/core/utilities/enums.dart';

class WisdomMenuSuccessWidget extends StatelessWidget {
  const WisdomMenuSuccessWidget({Key? key, required this.state})
      : super(key: key);

  final GetWisdomMenuSuccessState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => AuthCubit.get(context).logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text(AppStrings.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppConstance.userType == UserType.admin.name
          ? FloatingActionButton(
              onPressed: () {
                WisdomMenuCubit.get(context).onNewWisdomMenuClicked(context);
              },
              tooltip: AppStrings.addNewWisdomMenu,
              child: const Icon(Icons.add),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          await WisdomMenuCubit.get(context).getWisdomMenu(context);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
              child: Column(
                children: [
                  if (state.wisdomMenu.isEmpty)
                    Text(
                      AppStrings.noData,
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.wisdomMenu.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            WisdomMenuCubit.get(context).onWisdomClicked(
                                context: context,
                                wisdom: state.wisdomMenu[index]);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 2.h),
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
                            child: Text(
                              state.wisdomMenu[index].name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
