import 'dart:developer';
import 'package:else7a_tamam/app.dart';
import 'package:else7a_tamam/wisdom/presentation/screens/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/core/global/theme/app_colors_light.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '/core/utilities/app_constance.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationsServices {
  /// Init notifications services
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  /// On did receive local notification
  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    await Navigator.pushAndRemoveUntil(
      MyApp.navigatorKey.currentState!.context,
      MaterialPageRoute<void>(
        builder: (context) => const NotificationScreen(),
      ),
      (route) => false,
    );
  }

  /// On did receive notification response
  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      log('notification payload: $payload');
    }
    await Navigator.pushAndRemoveUntil(
      MyApp.navigatorKey.currentState!.context,
      MaterialPageRoute<void>(
        builder: (context) => const NotificationScreen(),
      ),
      (route) => false,
    );
  }

  /// Create notification
  static Future<void> createNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    var result = tz.TZDateTime.now(tz.local);
    // schedule 30 minute if time in between 9:00 AM and 10:00 PM
    if (result.hour >= 9 && result.hour <= 21) {
      result = result.add(const Duration(minutes: 30));
    } else {
      result = result.add(const Duration(hours: 11));
    }

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      AppConstance.channelKey,
      AppConstance.channelName,
      channelDescription: AppConstance.channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      category: AndroidNotificationCategory.reminder,
      playSound: true,
      showWhen: true,
      enableLights: true,
      ledColor: AppColorsLight.primaryColor,
      ledOnMs: 1000,
      ledOffMs: 500,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    flutterLocalNotificationsPlugin
        .zonedSchedule(
          _generateId(),
          title,
          body,
          result,
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
          matchDateTimeComponents: DateTimeComponents.time,
        )
        .then((value) => log('Notification created'))
        .catchError((error) {
      log(error.toString());
    });
  }


  /// Refresh notification
  static Future<void> refreshNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    var result = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      AppConstance.channelKey,
      AppConstance.channelName,
      channelDescription: AppConstance.channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      category: AndroidNotificationCategory.reminder,
      playSound: true,
      showWhen: true,
      enableLights: true,
      ledColor: AppColorsLight.primaryColor,
      ledOnMs: 1000,
      ledOffMs: 500,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    flutterLocalNotificationsPlugin
        .zonedSchedule(
          _generateId(),
          title,
          body,
          result,
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
          matchDateTimeComponents: DateTimeComponents.time,
        )
        .then((value) => log('Notification created'))
        .catchError((error) {
      log(error.toString());
    });
  }

  /// Firebase messaging background handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    createNotification(
      title: message.notification!.title!,
      body: message.notification!.body!,
      payload: message.data['route'] ?? message.notification!.body,
    );
  }

  /// Firebase messaging background handler

  static Future<void> backgroundMessageHandler() async {
    return FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler);
  }

  /// Firebase messaging foreground handler
  static Future<void> foregroundMessageHandler() async {
    FirebaseMessaging.onMessage.listen(
      (message) async {
        await createNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: message.data['route'] ?? message.notification!.body,
        );
      },
    );
  }

  static int _generateId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000).toInt();
  }
}
