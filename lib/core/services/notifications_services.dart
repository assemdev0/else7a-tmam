import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import '../../app.dart';
import '/core/utilities/app_constance.dart';
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
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupName: AppConstance.channelGroupName,
          channelGroupKey: AppConstance.channelGroupKey,
        ),
      ],
      debug: true,
    );
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    createNotification(
      title: message.notification!.title!,
      body: message.notification!.body!,
      payload: message.data['route'] ?? message.notification!.body,
    );
  }

  static Future<void> backgroundMessageHandler() async {
    return FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler);
  }

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

  static Future<void> createNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    var result = DateTime.now().add(const Duration(minutes: 1));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateId(),
        channelKey: AppConstance.channelKey,
        title: title,
        body: body,
        actionType: ActionType.Default,
        locked: true,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
      schedule: NotificationCalendar(
        hour: result.hour,
        minute: result.minute,
        second: result.second,
        millisecond: result.millisecond,
        repeats: false,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'OK',
          label: 'حسناً',
          enabled: true,
          color: AppColorsLight.primaryColor,
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  static setListeners() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) {
        return NotificationsServices.onActionReceivedMethod(receivedAction);
      },
      onNotificationCreatedMethod: (ReceivedNotification receivedNotification) {
        return NotificationsServices.onNotificationCreatedMethod(
            receivedNotification);
      },
      onNotificationDisplayedMethod:
          (ReceivedNotification receivedNotification) {
        return NotificationsServices.onNotificationDisplayedMethod(
            receivedNotification);
      },
      onDismissActionReceivedMethod: (ReceivedAction receivedAction) {
        return NotificationsServices.onDismissActionReceivedMethod(
            receivedAction);
      },
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    log("Notification displayed: ${receivedNotification.id}");
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    log("Action received: ${receivedAction.buttonKeyPressed}");
    createNotification(
      title: 'New',
      body: 'Test',
      payload: 'Test',
    );
    // // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     '/notification-page',
    //     (route) =>
    //         (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }

  static int _generateId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000).toInt();
  }
}
