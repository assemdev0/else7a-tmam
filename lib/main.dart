import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/services/notifications_services.dart';
import 'core/services/services_locator.dart';
import 'core/utilities/app_constance.dart';
import 'core/utilities/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServicesLocator().init();
  Bloc.observer = AppBlocObserver();
  await SharedPref.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  AppConstance.userType =
      SharedPref.getData(key: AppConstance.userTypeKey) ?? '';
  AppConstance.uId = SharedPref.getData(key: AppConstance.uIdKey) ?? '';
  await NotificationsServices.init();
  NotificationsServices.backgroundMessageHandler();
  NotificationsServices.foregroundMessageHandler();
  await FirebaseMessaging.instance.getToken().then((value) {
    log(value.toString());
  }).catchError((error) {
    log(error.toString());
  });
  runApp(const MyApp());
}
