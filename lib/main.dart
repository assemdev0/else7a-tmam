import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:else7a_tamam/wisdom/presentation/screens/notification_screen.dart';
import 'package:else7a_tamam/wisdom/presentation/screens/wisdom_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
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
  Widget homePage = const WisdomMenuScreen();
  ReceivedAction? receivedAction = await AwesomeNotifications()
      .getInitialNotificationAction(removeFromActionEvents: false)
      .timeout(const Duration(seconds: 5));
  if (receivedAction?.channelKey == AppConstance.channelKey) {
    homePage = const NotificationScreen();
    log('NotificationScreen ${receivedAction?.channelKey}');
  }

  AppConstance.firstTime =
      SharedPref.getData(key: AppConstance.firstTimeKey) ?? true;
  AppConstance.userType =
      SharedPref.getData(key: AppConstance.userTypeKey) ?? '';
  AppConstance.uId = SharedPref.getData(key: AppConstance.uIdKey) ?? '';
  AppConstance.wisdomList =
      SharedPref.getData(key: AppConstance.wisdomListKey) ?? [];
  log(AppConstance.wisdomList.toString());
  await NotificationsServices.init();
  await NotificationsServices.foregroundMessageHandler();
  await NotificationsServices.backgroundMessageHandler();
  // await NotificationsServices.setListeners();
  await FirebaseMessaging.instance.getToken().then((value) {
    log(value.toString());
  }).catchError((error) {
    log(error.toString());
  });
  runApp(MyApp(
    homePage: homePage,
  ));
}
