import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import '/wisdom/data/models/wisdom_menu_model.dart';
import '../network/shared_preferences.dart';
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
          locked: true,
          importance: NotificationImportance.High,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          playSound: true,
          enableLights: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList(<int>[1000, 1000, 1000, 1000]),
          groupKey: AppConstance.channelGroupKey,
          groupAlertBehavior: GroupAlertBehavior.Children,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupName: AppConstance.channelGroupName,
          channelGroupKey: AppConstance.channelGroupKey,
        ),
      ],
      // debug: true,
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
    var result = DateTime.now().add(const Duration(seconds: 10));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateId(),
        channelKey: AppConstance.channelKey,
        title: title,
        body: body,
        actionType: ActionType.Default,
        locked: true,
        wakeUpScreen: true,
        displayOnBackground: true,
        displayOnForeground: true,
        category: NotificationCategory.Message,
        fullScreenIntent: true,
        summary: 'summary',
        // groupKey: AppConstance.channelGroupKey,
        notificationLayout: NotificationLayout.Messaging,
      ),
      schedule: NotificationCalendar(
        hour: result.hour,
        minute: result.minute,
        second: result.second,
        millisecond: result.millisecond,
        repeats: false,
      ),
      actionButtons: [
        // NotificationActionButton(
        //   key: 'OK',
        //   label: 'حسناً',
        //   enabled: true,
        //   color: AppColorsLight.primaryColor,
        //   actionType: ActionType.SilentBackgroundAction,
        // ),
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
    // onActionReceivedMethod(ReceivedAction());
    log("Action received:");
    // List<WisdomMenuModel> model = [];
    // for (var element in AppConstance.wisdomList) {
    //   model.add(WisdomMenuModel.fromJson(json.decode(element.toString())));
    // }

    // if (model.isNotEmpty) {
    //   if (AppConstance.wisdomIndex <
    //       model[AppConstance.wisdomMenuIndex].subMenu.length - 1) {
    //     AppConstance.wisdomIndex++;
    //   } else if (AppConstance.wisdomMenuIndex < model.length - 1) {
    //     AppConstance.wisdomIndex = 0;
    //     AppConstance.wisdomMenuIndex++;
    //   } else {
    //     AppConstance.wisdomMenuIndex = 0;
    //     AppConstance.wisdomIndex = 0;
    //   }
    //   await SharedPref.setData(
    //       key: AppConstance.wisdomIndexKey, value: AppConstance.wisdomIndex);
    //   await SharedPref.setData(
    //       key: AppConstance.wisdomMenuIndexKey,
    //       value: AppConstance.wisdomMenuIndex);
    //
    //   createNotification(
    //     title: model[AppConstance.wisdomMenuIndex].name,
    //     body: model[AppConstance.wisdomMenuIndex]
    //         .subMenu[AppConstance.wisdomIndex],
    //     payload: model[AppConstance.wisdomMenuIndex]
    //         .subMenu[AppConstance.wisdomIndex],
    //   );
    // }
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
    log("Action received: $receivedAction");

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

      createNotification(
        title: model[AppConstance.wisdomMenuIndex].name,
        body: model[AppConstance.wisdomMenuIndex]
            .subMenu[AppConstance.wisdomIndex],
        payload: model[AppConstance.wisdomMenuIndex]
            .subMenu[AppConstance.wisdomIndex],
      );
    }
  }

  static int _generateId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000).toInt();
  }
}

// import 'dart:convert';
// import 'dart:developer';
// import 'dart:typed_data';
// import 'package:else7a_tamam/core/global/theme/app_colors_light.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// import 'package:else7a_tamam/wisdom/data/models/wisdom_menu_model.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import '../network/shared_preferences.dart';
// import '/core/utilities/app_constance.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// class NotificationsServices {
//   /// Init notifications services
//   static Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     const LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             macOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//
//     // return await AwesomeNotifications().initialize(
//     //   // set the icon to null if you want to use the default app icon
//     //   null,
//     //   [
//     //     NotificationChannel(
//     //       channelGroupKey: AppConstance.channelGroupKey,
//     //       channelKey: AppConstance.channelKey,
//     //       channelName: AppConstance.channelName,
//     //       channelDescription: AppConstance.channelDescription,
//     //       defaultColor: AppColorsLight.primaryColor,
//     //       ledColor: AppColorsLight.whiteColor,
//     //     ),
//     //   ],
//     //   // Channel groups are only visual and are not required
//     //   channelGroups: [
//     //     NotificationChannelGroup(
//     //       channelGroupName: AppConstance.channelGroupName,
//     //       channelGroupKey: AppConstance.channelGroupKey,
//     //     ),
//     //   ],
//     //   debug: true,
//     // );
//
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//   }
//
//   /// On did receive local notification
//   static void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//     // showDialog(
//     //   context: context,
//     //   builder: (BuildContext context) => CupertinoAlertDialog(
//     //     title: Text(title),
//     //     content: Text(body),
//     //     actions: [
//     //       CupertinoDialogAction(
//     //         isDefaultAction: true,
//     //         child: Text('Ok'),
//     //         onPressed: () async {
//     //           Navigator.of(context, rootNavigator: true).pop();
//     //           await Navigator.push(
//     //             context,
//     //             MaterialPageRoute(
//     //               builder: (context) => SecondScreen(payload),
//     //             ),
//     //           );
//     //         },
//     //       )
//     //     ],
//     //   ),
//     // );
//   }
//
//   /// On did receive notification response
//   static void onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       log('notification payload: $payload');
//     }
//     // await Navigator.push(
//     //   context,
//     //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
//     // );
//   }
//
//   /// Create notification
//   static Future<void> createNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     var result = tz.TZDateTime.now(tz.local);
//     // schedule 30 minute if time in between 9:00 AM and 10:00 PM
//     if (result.hour >= 9 && result.hour <= 21) {
//       result = result.add(const Duration(seconds: 5));
//     } else {
//       result = result.add(const Duration(hours: 11));
//     }
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       AppConstance.channelKey,
//       AppConstance.channelName,
//       channelDescription: AppConstance.channelDescription,
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//       category: AndroidNotificationCategory.social,
//       playSound: true,
//       showWhen: true,
//       channelAction: AndroidNotificationChannelAction.update,
//       fullScreenIntent: true,
//       channelShowBadge: true,
//       onlyAlertOnce: false,
//       enableVibration: true,
//       groupKey: AppConstance.channelGroupKey,
//       enableLights: true,
//       visibility: NotificationVisibility.public,
//       ledColor: AppColorsLight.primaryColor,
//       ledOnMs: 1000,
//       ledOffMs: 500,
//       vibrationPattern: Int64List.fromList(<int>[1000, 1000, 1000, 1000]),
//       colorized: true,
//       color: AppColorsLight.primaryColor,
//       indeterminate: true,
//       when: DateTime.now().millisecondsSinceEpoch,
//       actions: [
//         const AndroidNotificationAction(
//           'OK',
//           'حسناً',
//         ),
//       ],
//     );
//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     flutterLocalNotificationsPlugin.zonedSchedule(
//       _generateId(),
//       title,
//       body,
//       result,
//       notificationDetails,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       payload: payload,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//
//     /* await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: _generateId(),
//         channelKey: AppConstance.channelKey,
//         title: title,
//         body: body,
//         actionType: ActionType.Default,
//         locked: true,
//         wakeUpScreen: true,
//         category: NotificationCategory.Reminder,
//         displayOnBackground: true,
//         displayOnForeground: true,
//       ),
//       schedule: NotificationCalendar(
//         hour: result.hour,
//         minute: result.minute,
//         second: result.second,
//         millisecond: result.millisecond,
//         repeats: false,
//       ),
//       actionButtons: [
//         NotificationActionButton(
//           key: 'OK',
//           label: 'حسناً',
//           enabled: true,
//           color: AppColorsLight.primaryColor,
//           actionType: ActionType.Default,
//         ),
//       ],
//     );*/
//   }
//
//   /// Firebase messaging background handler
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     createNotification(
//       title: message.notification!.title!,
//       body: message.notification!.body!,
//       payload: message.data['route'] ?? message.notification!.body,
//     );
//   }
//
//   /// Firebase messaging background handler
//
//   static Future<void> backgroundMessageHandler() async {
//     return FirebaseMessaging.onBackgroundMessage(
//         _firebaseMessagingBackgroundHandler);
//   }
//
//   /// Firebase messaging foreground handler
//   static Future<void> foregroundMessageHandler() async {
//     FirebaseMessaging.onMessage.listen(
//       (message) async {
//         await createNotification(
//           title: message.notification!.title!,
//           body: message.notification!.body!,
//           payload: message.data['route'] ?? message.notification!.body,
//         );
//       },
//     );
//   }
//
//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod() async {
//     // Your code goes here
//     log("Action received:");
//     List<WisdomMenuModel> model = [];
//     for (var element in AppConstance.wisdomList) {
//       model.add(WisdomMenuModel.fromJson(json.decode(element.toString())));
//     }
//
//     if (model.isNotEmpty) {
//       if (AppConstance.wisdomIndex <
//           model[AppConstance.wisdomMenuIndex].subMenu.length - 1) {
//         AppConstance.wisdomIndex++;
//       } else if (AppConstance.wisdomMenuIndex < model.length - 1) {
//         AppConstance.wisdomIndex = 0;
//         AppConstance.wisdomMenuIndex++;
//       } else {
//         AppConstance.wisdomMenuIndex = 0;
//         AppConstance.wisdomIndex = 0;
//       }
//       await SharedPref.setData(
//           key: AppConstance.wisdomIndexKey, value: AppConstance.wisdomIndex);
//       await SharedPref.setData(
//           key: AppConstance.wisdomMenuIndexKey,
//           value: AppConstance.wisdomMenuIndex);
//
//       createNotification(
//         title: model[AppConstance.wisdomMenuIndex].name,
//         body: model[AppConstance.wisdomMenuIndex]
//             .subMenu[AppConstance.wisdomIndex],
//         payload: model[AppConstance.wisdomMenuIndex]
//             .subMenu[AppConstance.wisdomIndex],
//       );
//     }
//   }
//
//   static int _generateId() {
//     return DateTime.now().millisecondsSinceEpoch.remainder(100000).toInt();
//   }
// }
//
// /*  static setListeners() {
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: (ReceivedAction receivedAction) {
//         return NotificationsServices.onActionReceivedMethod(receivedAction);
//       },
//       onNotificationCreatedMethod: (ReceivedNotification receivedNotification) {
//         return NotificationsServices.onNotificationCreatedMethod(
//             receivedNotification);
//       },
//       onNotificationDisplayedMethod:
//           (ReceivedNotification receivedNotification) {
//         return NotificationsServices.onNotificationDisplayedMethod(
//             receivedNotification);
//       },
//       onDismissActionReceivedMethod: (ReceivedAction receivedAction) {
//         return NotificationsServices.onDismissActionReceivedMethod(
//             receivedAction);
//       },
//     );
//   }*/
//
// /*/// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }
//
//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     log("Notification displayed: ${receivedNotification.id}");
//     // Your code goes here
//   }
//
//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     // Your code goes here
//   }*/
