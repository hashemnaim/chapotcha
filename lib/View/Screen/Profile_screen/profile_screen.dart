import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:capotcha/View/Screen/Auth_screen/login_screen.dart';
import 'package:capotcha/View/Screen/Profile_screen/parson.dart';
import 'package:capotcha/View/Screen/Profile_screen/support.dart';
import 'package:capotcha/View/widgets/isload.dart';
import 'package:capotcha/animate_do.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/s_helpar.dart';
import 'package:capotcha/features/repository/sql_table.dart';

import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/constaint.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about.dart';
import 'history.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String promo = "";
  bool promoBool = false;
  // setToken() async {
  //   await Provider.of<HomeProvieder>(context, listen: false).getToken();
  // }

  launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.capotcha.capotcha';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // setToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var tokenProvider = Provider.of<HomeProvieder>(context);
    return ListView(children: <Widget>[
      Container(
        padding: EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 10)],
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: () async {
                  if (SHelper.sHelper.getToken() == null) {
                    awesomeDialog(context)..show();
                  } else {
                    //  await data.getProfile();

                    pushWithReplecemnet(context, Parson());
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("حسابي", style: Style.cairo),
                  trailing: Container(
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Icon(
                      Icons.arrow_back_ios,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              // margin: EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 10)],
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: () async {
                  String token = SHelper.sHelper.getToken();

                  if (token == null || token == "") {
                    awesomeDialog(context)..show();
                  } else {
                    IsLoad();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FadeOut(child: HistoryScreen())));
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text("سجل الطلبات", style: Style.cairo),
                  trailing: Container(
                    alignment: Alignment.centerLeft,
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Icon(
                      Icons.arrow_back_ios,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              //   margin: EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 10)],
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: GestureDetector(
                onTap: () {
                  IsLoad();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FadeOut(child: SupportScreen())));
                },
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("خدمة العملاء", style: Style.cairo),
                  trailing: Container(
                    alignment: Alignment.centerLeft,
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Icon(
                      Icons.arrow_back_ios,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              // margin: EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 10)],
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FadeOut(child: About())));
                },
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text("عن كابوتشا", style: Style.cairo),
                  trailing: Container(
                    alignment: Alignment.centerLeft,
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.1,
                    //color: Colors.amber,
                    child: Icon(
                      Icons.arrow_back_ios,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              // margin: EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 10)],
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: () {
                  return launchURL();
                },
                child: ListTile(
                  leading: Icon(Icons.rate_review),
                  title: Text("تقييم التطبيق", style: Style.cairo),
                  trailing: Container(
                    alignment: Alignment.centerLeft,
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.1,
                    //color: Colors.amber,
                    child: Icon(
                      Icons.arrow_back_ios,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3, color: AppColors.greenColor),
              ),
              child: InkWell(
                onTap: () async {
                  await SHelper.sHelper.setToken(null);
                  DBClint.dbClint.deleteproductAll();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                },
                child: Center(
                  child: ListTile(
                      title: SHelper.sHelper.getToken() == null
                          ? Center(
                              child: Text("تسجيل دخول", style: Style.cairog))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.exit_to_app,
                                  color: AppColors.greenColor,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.021,
                                ),
                                Text("تسجيل خروج", style: Style.cairo),
                              ],
                            )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SHelper.sHelper.getToken() == null
                ? Container()
                : Column(
                    children: [
                      Divider(),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "ادخال كود الخصم ",
                            style: Style.cairo,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              TextFormField(
                                  // enabled: false,
                                  textAlign: TextAlign.right,
                                  onChanged: (value) async {
                                    promo = value;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      hintText: "كود الخصم",
                                      hintStyle: Style.cairo,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () async {
                                      promoBool = true;
                                      await Provider.of<HomeProvieder>(context,
                                              listen: false)
                                          .setPromoCode(promo);
                                      if (Provider.of<HomeProvieder>(context,
                                                  listen: false)
                                              .promoCode
                                              .status ==
                                          true) {
                                        promoBool = false;

                                        await Fluttertoast.showToast(
                                            msg: Provider.of<HomeProvieder>(
                                                    context,
                                                    listen: false)
                                                .promoCode
                                                .message,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                AppColors.greenColor,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        promoBool = false;

                                        await Fluttertoast.showToast(
                                            msg: Provider.of<HomeProvieder>(
                                                    context,
                                                    listen: false)
                                                .promoCode
                                                .message,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 60,
                                      child: Center(
                                        child: Text(
                                          "تفعيل",
                                          style: Style.cairog,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              color: Colors.grey[200])),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ],
                  )
          ],
        ),
      ),
    ]);
  }
}
