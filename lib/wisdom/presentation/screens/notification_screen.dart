import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '/core/services/notifications_services.dart';
import '/core/utilities/app_strings.dart';
import '/wisdom/presentation/screens/wisdom_menu_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/network/shared_preferences.dart';
import '../../../core/utilities/app_constance.dart';
import '../../data/models/wisdom_menu_model.dart';
import 'choose_wisdom_type_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Timer _timer;

  @override
  void initState() {
    _createNewNotification();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ChooseWisdomTypeScreen()),
        (route) => false,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _createNewNotification() async {
    log('createNewNotification');
    List<WisdomMenuModel> model = [];
    for (var element in AppConstance.wisdomList) {
      model.add(WisdomMenuModel.fromJson(json.decode(element.toString())));
    }
    if (model.isNotEmpty) {
      if (AppConstance.wisdomIndex <
          model[AppConstance.wisdomMenuIndex].subMenu.length - 1) {
        AppConstance.wisdomIndex++;
      } else if (AppConstance.wisdomMenuIndex < model.length - 1) {
        AppConstance.wisdomIndex = 0;
        AppConstance.wisdomMenuIndex++;
      } else {
        AppConstance.wisdomMenuIndex = 0;
        AppConstance.wisdomIndex = 0;
      }
      await SharedPref.setData(
          key: AppConstance.wisdomIndexKey, value: AppConstance.wisdomIndex);
      await SharedPref.setData(
          key: AppConstance.wisdomMenuIndexKey,
          value: AppConstance.wisdomMenuIndex);

      await NotificationsServices.createNotification(
        title: model[AppConstance.wisdomMenuIndex].name,
        body: model[AppConstance.wisdomMenuIndex]
            .subMenu[AppConstance.wisdomIndex],
        payload: model[AppConstance.wisdomMenuIndex]
            .subMenu[AppConstance.wisdomIndex],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text(AppStrings.notifications),
          ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
