import 'package:firebase_messaging/firebase_messaging.dart';

import 'shared_preferences_helpar.dart';

class NotificationHelper {
  initialNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? fcmToken = await firebaseMessaging.getToken();
    await SHelper.sHelper.setFcmToken(fcmToken!);
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      return print("onBackgroundMessage");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      return print("onBackgroundMessage");
    });
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   return print("onBackgroundMessage");
    // });
  }
}
