import 'package:capotcha/notification_firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/Screen/Auth_screen/splash.dart';
import 'features/providers/home_provieder.dart';
import 'features/repository/s_helpar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SHelper.sHelper.initSharedPrefrences();
  await Firebase.initializeApp();

  runApp(
      // DevicePreview(
      // builder: (context) =>
      MyApp());
}
//),

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvieder>(
        create: (BuildContext context) => HomeProvieder(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // builder: DevicePreview.appBuilder,
          home: Splash(),
        ));
  }
}
