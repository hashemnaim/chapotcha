import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/fcm_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'config/theme/my_theme.dart';
import 'routes/app_pages.dart';
import 'utils/shared_preferences_helpar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  await FcmHelper.fcmHelper.initFcm();

  await SHelper.sHelper.initSharedPrefrences();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemStatusBarContrastEnforced: false));

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
  void initState() {
    super.initState();
    CheckConnectivity();
  }

  void CheckConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      BotToast.showText(text: 'لا يوجد انترنت ', contentColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) => ScreenUtilInit(
          designSize: Size(375, 955),
          builder: (context, widget) => snapshot.data == ConnectivityResult.none
              ? GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  builder: BotToastInit(),
                  navigatorObservers: [BotToastNavigatorObserver()],
                  locale: Locale("ar"),
                  theme: MyTheme.getThemeData(isLight: true),
                  home: Scaffold(
                    body: Center(child: Text('لا يوجد انترنت ')),
                  ),
                )
              : GetMaterialApp(
                  builder: BotToastInit(),
                  navigatorObservers: [BotToastNavigatorObserver()],
                  theme: MyTheme.getThemeData(isLight: true),
                  debugShowCheckedModeBanner: false,
                  locale: Locale("ar"),
                  getPages: AppPages.routes,
                  initialRoute: Routes.SPLASH,
                )),
    );
  }
}
