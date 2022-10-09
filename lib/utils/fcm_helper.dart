import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:capotcha/utils/shared_preferences_helpar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/My_Order/controller/order_controller.dart';

class FcmHelper {
  FcmHelper._internal();
  static final FcmHelper fcmHelper = FcmHelper._internal();
  // FCM Messaging
  static late FirebaseMessaging messaging;
  final Dio _dio = Dio();

  // Notification lib
  static AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  /// this function will initialize firebase and fcm instance
  Future<void> initFcm() async {
    try {
      // initialize fcm and firebase core
      await Firebase.initializeApp(
          //  only un comment this line if you set up firebase vie firebase cli
          //options: DefaultFirebaseOptions.currentPlatform,
          );
      messaging = FirebaseMessaging.instance;

      await _initNotification();

      await _setupFcmNotificationSettings();

      await _generateFcmToken();

      FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);
      // FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);

      listenToActionButtons();
    } catch (error) {}
  }

  /// when user click on notification or click on button on the notification
  listenToActionButtons() {
    // awesomeNotifications.actionStream.listen(
    //   (ReceivedNotification receivedNotification) async {
    //     // for ex:
    //     //Get.toNamed(Routes.NOTIFICATIONS)
    //   },
    // );
  }

  ///handle fcm notification settings (sound,badge..etc)
  Future<void> _setupFcmNotificationSettings() async {
    //show notification with sound and badge
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    //NotificationSettings settings
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );
  }

  /// generate and save fcm token if its not already generated (generate only for 1 time)
  Future<void> _generateFcmToken() async {
    try {
      var token = await messaging.getToken();
      if (token != null) {
        SHelper.sHelper.setFcmToken(token);
        _sendFcmTokenToServer();
      } else {
        // retry generating token
        await Future.delayed(const Duration(seconds: 5));
        _generateFcmToken();
      }
    } catch (error) {}
  }

  /// this method will be triggered when the app generate fcm
  /// token successfully
  _sendFcmTokenToServer() {
    SHelper.sHelper.getFcmToken();
  }

  ///handle fcm notification when app is closed/terminated
  Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
    _showNotification(
      id: 1,
      title: message.notification?.title ?? 'Tittle',
      body: message.notification?.body ?? 'Body',
    );
  }

  //handle fcm notification when app is open
  Future<void> _fcmForegroundHandler(RemoteMessage message) async {
    _showNotification(
      id: 1,
      title: message.notification?.title ?? 'Tittle',
      body: message.notification?.body ?? 'Body',
    );
    OrderController orderController = Get.find();
    orderController.getOrders(false);
  }

  //display notification for user with sound
  _showNotification(
      {required String title,
      required String body,
      required int id,
      String? channelKey,
      String? groupKey,
      String? summary,
      Map<String, String>? payload,
      String? largeIcon}) async {
    awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        awesomeNotifications.requestPermissionToSendNotifications();
      } else {
        // u can show notification
        awesomeNotifications.createNotification(
          content: NotificationContent(
            id: id,
            title: title,
            body: body,
            groupKey: groupKey ?? NotificationChannels.generalGroupKey,
            channelKey: channelKey ?? NotificationChannels.generalChannelKey,
            showWhen:
                true, // Hide/show the time elapsed since notification was displayed
            payload:
                payload, // data of the notification (it will be used when user clicks on notification)
            notificationLayout: NotificationLayout
                .Default, // notification shape (message,media player..etc) For ex => NotificationLayout.Messaging
            autoDismissible:
                true, // dismiss notification when user clicks on it
            summary:
                summary, // for ex: New message (it will be shown on status bar before notificaiton shows up)
            largeIcon:
                largeIcon, // image of sender for ex (when someone send you message his image will be shown)
          ),
        );
      }
    });
  }

  Future sendNotificationToUser(
      {required String fcmToken,
      required String title,
      required String body}) async {
    // try {
    print(fcmToken);
    const url = "https://fcm.googleapis.com/fcm/send";

    final headerMap = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization":
          "key=AAAAQYwLq4M:APA91bG8VIA2d5-BqCqxrZ7FL-Mpv-diCluOOjlNXK5zsNTRGAEtuIB7EZEmInPBb2EadBxte6djrv6Gi4ZriQ9NxHiOts-Slch9w6WrGlmixdFa2mXuBDiiUEIp62Zk2Er3KXeWJHfe"
    };

    await _dio.post(url, options: Options(headers: headerMap), data: {
      "to": fcmToken,
      "notification": {"body": body, "title": title},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "chat_message": "1"
      }
    });

    return true;
    // } on DioError {}
  }

  ///init notifications channels
  _initNotification() async {
    await awesomeNotifications.initialize(
        null, // null mean it will show app icon on the notification (status bar)
        [
          NotificationChannel(
            channelGroupKey: NotificationChannels.generalChannelGroupKey,
            channelKey: NotificationChannels.generalChannelKey,
            channelName: NotificationChannels.generalChannelName,
            groupKey: NotificationChannels.generalGroupKey,
            channelDescription:
                'Notification channel for general notifications',
            defaultColor: Colors.green,
            ledColor: Colors.white,
            channelShowBadge: true,
            playSound: true,
            importance: NotificationImportance.Max,
          ),
          NotificationChannel(
              channelGroupKey: NotificationChannels.chatChannelGroupKey,
              channelKey: NotificationChannels.chatChannelKey,
              channelName: NotificationChannels.chatChannelName,
              groupKey: NotificationChannels.chatGroupKey,
              channelDescription: 'Notification channel for messages',
              defaultColor: Colors.green,
              ledColor: Colors.white,
              channelShowBadge: true,
              playSound: true,
              importance: NotificationImportance.Max)
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: NotificationChannels.generalChannelGroupKey,
            channelGroupName: NotificationChannels.generalChannelGroupName,
          ),
          NotificationChannelGroup(
            channelGroupKey: NotificationChannels.chatChannelGroupKey,
            channelGroupName: NotificationChannels.chatChannelGroupName,
          )
        ]);
  }
}

class NotificationChannels {
  // chat channel (for messages only)
  static String get chatChannelKey => "chat_channel";
  static String get chatChannelName => "Chat channel";
  static String get chatGroupKey => "chat group key";
  static String get chatChannelGroupKey => "chat_channel_group";
  static String get chatChannelGroupName => "Chat notifications channels";
  static String get chatChannelDescription => "Chat notifications channels";

  // general channel (for all other notifications)
  static String get generalChannelKey => "fitness_channel";
  static String get generalGroupKey => "basic group key";
  static String get generalChannelGroupKey => "basic_channel_group";
  static String get generalChannelGroupName =>
      "Fitness public notifications channels";
  static String get generalChannelName => "Fitness notifications channels";
  static String get generalChannelDescription =>
      "Notification channel for messages";
}
