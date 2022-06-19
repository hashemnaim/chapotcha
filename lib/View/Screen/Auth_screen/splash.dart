import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/isload.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/s_helpar.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../animate_do.dart';
import '../../../features/repository/home_repository.dart';
import '../../../notification_firebase.dart';
import '../home_screen.dart';
import 'login_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  chackToken() async {
    await NotificationHelper().initialNotification();

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // firebaseMessaging.subscribeToTopic('all');
    final fcmToken = await firebaseMessaging.getToken();

    // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    // String tokenNot = await _firebaseMessaging.getToken();

    await Provider.of<HomeProvieder>(context, listen: false)
        .getNotfcation(fcmToken);
    print(SHelper.sHelper.getToken());

    if (SHelper.sHelper.getToken() == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    } else {
      await Provider.of<HomeProvieder>(context, listen: false).getHome();
      await Provider.of<HomeProvieder>(context, listen: false).getProfile();
      // await Provider.of<HomeProvieder>(context, listen: false).setCart();
      await Provider.of<HomeProvieder>(context, listen: false).getCarton(0);

      if (Provider.of<HomeProvieder>(context, listen: false).homeModel ==
          null) {
        await Fluttertoast.showToast(
            msg: "يوجد مشكلة في بيانات بالانترنت",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      } else {
        await Provider.of<HomeProvieder>(context, listen: false).getCartDB();
        await Provider.of<HomeProvieder>(context, listen: false).getCartonDB();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            ModalRoute.withName('HomePage'));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    chackToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Bakeground(),
          Center(
              child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              BounceInDown(
                duration: Duration(milliseconds: 2000),
                child: Container(
                  width: 170,
                  height: 155,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/im1.png"),
                    ),
                  ),
                ),
              ),
              FadeInLeft(
                duration: Duration(milliseconds: 2000),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/im2.png"),
                    ),
                  ),
                ),
              ),
              FadeInRight(
                duration: Duration(milliseconds: 2000),
                child: Container(
                  height: 80,
                  width: 220,
                  padding: EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/im3.png"),
                    ),
                  ),
                ),
              ),
            ],
          )),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.43,
              child: IsLoad()),
        ],
      ),
    );
  }
}
