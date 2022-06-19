import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHelper {
  initialNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final fcmToken = await firebaseMessaging.getToken();

    // await SPHelper.spHelper.setFcmToken(fcmToken);
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {});
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {});
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {});
  }
}
