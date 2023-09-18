import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:else7a_tamam/core/utilities/app_constance.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../global/theme/app_colors_light.dart';

class NotificationsServices {
  static Future<bool> init() async {
    return await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelGroupKey: AppConstance.channelGroupKey,
          channelKey: AppConstance.channelKey,
          channelName: AppConstance.channelName,
          channelDescription: AppConstance.channelDescription,
          defaultColor: AppColorsLight.primaryColor,
          ledColor: AppColorsLight.whiteColor,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupName: AppConstance.channelGroupName,
          channelGroupkey: AppConstance.channelGroupKey,
        ),
      ],
      debug: true,
    );
  }

  static Future<void> backgroundMessageHandler() async {
    FirebaseMessaging.onBackgroundMessage((message) {
      log('onBackgroundMessage: $message');
      return createNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: message.data['route'] ?? message.notification!.body,
      );
    });
  }

  static Future<void> foregroundMessageHandler() async {
    FirebaseMessaging.onMessage.listen((message) async {
      log('onMessage: $message');

      return await createNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: message.data['route'] ?? message.notification!.body,
      );
    });
  }

  static Future<void> createNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateId(),
        channelKey: AppConstance.channelKey,
        title: title,
        body: body,
      ),
    );
  }

  static int _generateId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000).toInt();
  }
}
