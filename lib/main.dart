import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:awesome_notifications/awesome_notifications.dart';
import '/wisdom/presentation/screens/notification_screen.dart';
import '/wisdom/presentation/screens/wisdom_menu_screen.dart';
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();
  ServicesLocator().init();
  Bloc.observer = AppBlocObserver();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
  await SharedPref.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Widget homePage = const WisdomMenuScreen();

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
  await FirebaseMessaging.instance.getToken().then((value) {
    log(value.toString());
  }).catchError((error) {
    log(error.toString());
  });
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    log('didNotificationLaunchApp');
    homePage = const NotificationScreen();
  } else {
    log('else');
    if (AppConstance.firstTime) {
      homePage = const NotificationScreen();
    } else {
      homePage = const WisdomMenuScreen();
    }
  }
  runApp(MyApp(
    homePage: homePage,
  ));
}
