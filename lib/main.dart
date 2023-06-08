import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/fcm_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'config/theme/my_theme.dart';
import 'routes/app_pages.dart';
import 'utils/shared_preferences_helpar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SHelper.sHelper.initSharedPrefrences();
  Firebase.initializeApp();

  await FcmHelper.fcmHelper.initFcm();

  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(systemStatusBarContrastEnforced: false));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 955),
      builder: (context, widget) => GetMaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: MyTheme.getThemeData(isLight: true),
        debugShowCheckedModeBanner: false,
        locale: Locale("ar"),
        getPages: AppPages.routes,
        initialRoute: Routes.SPLASH,
      ),
    );
  }
}
