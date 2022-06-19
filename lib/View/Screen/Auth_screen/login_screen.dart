import 'package:capotcha/View/widgets/custom_text.dart';
import 'package:capotcha/View/widgets/customer_button.dart';
import 'package:capotcha/View/widgets/customer_text_Failed.dart';
import 'package:capotcha/View/widgets/cutomer_pass.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/s_helpar.dart';
import 'package:capotcha/features/repository/sql_table.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

import '../../../animate_do.dart';
import '../home_screen.dart';
import 'forget_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  String number;
  String password;
  String email;
  FToast fToast;

  @override
  void initState() {
    super.initState();
  }

  setNumber(String value) {
    this.number = "2" + value;
    //  "2" + value;
  }

  setPassword(String value) {
    this.password = value;
  }

  // setemail(String value) {
  //   this.email = value;
  // }

  setEmailValidator(String value) {
    if (value == null || !isEmail(value) || value.isEmpty) {
      return "البريد الالكتروني  خطا";
    }
  }

  setNumberValidator(String value) {
    if (value.length < 9) {
      return "رقم الهاتف خطا";
    }
  }

  setPasswordValidator(String value) {
    if (value == null || value.isEmpty) {
      return "كلمة المرور خطا";
    }
  }

  log(context) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final fcmToken = await firebaseMessaging.getToken();

    final providerModalHand =
        Provider.of<HomeProvieder>(context, listen: false);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      providerModalHand.changeModelhan(true);
      try {
        await providerModalHand.fetchUser(number, password, fcmToken);
        if (providerModalHand.loginModel.accessToken != null) {
          // await Provider.of<HomeProvieder>(context, listen: false).getToken();

          await Provider.of<HomeProvieder>(context, listen: false).getHome();
          await Provider.of<HomeProvieder>(context, listen: false).getProfile();
          await Provider.of<HomeProvieder>(context, listen: false).setCart();
          await Provider.of<HomeProvieder>(context, listen: false).getCarton(0);

          DBClint.dbClint.deleteproductAll();

          providerModalHand.changeModelhan(false);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            ModalRoute.withName('/HomePage'),
          );
        } else {
          providerModalHand.changeModelhan(false);

          await Fluttertoast.showToast(
              msg: providerModalHand.loginModel.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        providerModalHand.changeModelhan(false);
        await Fluttertoast.showToast(
            msg: "يوجد مشكلة في البيانات",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      providerModalHand.changeModelhan(false);
    }
    setState(() {});
  }

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final providerModalHand =
        Provider.of<HomeProvieder>(context, listen: false);
    return ModalProgressHUD(
      inAsyncCall: providerModalHand.isLoad,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Expanded(
                // flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ExactAssetImage(
                            "assets/images/login-Background.png")),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
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
                          // Container(
                          //     // height: MediaQuery.of(context).size.height * 0.1,
                          //     alignment: Alignment.center,
                          //     child: Text(
                          //       "تسجيل الدخول",
                          //       style: TextStyle(
                          //         color: Color(0xff658199),
                          //         fontFamily: 'Cairo',
                          //         fontSize: 20.0,
                          //       ),
                          //     )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          CustomerTextFalied(
                              label: "رقم الموبايل",
                              validatorValue: setNumberValidator,
                              onSaveV: setNumber,

                              // maxLength: 11,
                              iconTextfiled: Icons.phone,
                              typeInput: 3),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          CustomerText(
                            label: " كلمة المرور  ",
                            onSaveV: setPassword,
                            validatorValue: setPasswordValidator,
                            typeInput: 7,
                            pass: Provider.of<HomeProvieder>(context).toggleEye,
                            iconTextfiled:
                                Provider.of<HomeProvieder>(context).iconData,
                            hintText: " *******",
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          CustomerButton(
                            submitFrom: () {
                              log(context);
                            },
                            label: "تسجيل الدخول",
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ForgetScreen()));
                            },
                            child: Text(
                              "هل نسيت كلمة المرور؟",
                              style: TextStyle(
                                color: Color(0xff658199),
                                fontFamily: 'Cairo',
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              providerModalHand.changeModelhan(false);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                              //  width: 190,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "  أنشاء حساب  ",
                                      style: TextStyle(
                                        color: Color(0xff658199),
                                        fontFamily: 'Cairo',
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      " لا يوجد لديك حساب ؟",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Cairo',
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                )),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomText(
                                    'أو',
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'NunitoSans',
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () async {
                              // await Provider.of<HomeProvieder>(context,
                              //         listen: false)
                              //     .setPoints();
                              // await Provider.of<HomeProvieder>(context,
                              //         listen: false)
                              //     .getDiscount();

                              providerModalHand.changeModelhan(true);
                              await Provider.of<HomeProvieder>(context,
                                      listen: false)
                                  .getHome();
                              DBClint.dbClint.deleteproductAll();
                              await Provider.of<HomeProvieder>(context,
                                      listen: false)
                                  .getCarton(0);

                              providerModalHand.changeModelhan(false);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                ModalRoute.withName('/HomePage'),
                              );
                            },
                            child: Text(
                              "تصفح كزائر",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                                fontSize: 22.0,
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
              // Expanded(
              //   // flex: 1,
              //   child: Transform.rotate(
              //     origin: Offset(0, 0),
              //     angle: 3.142,
              //     child: Container(
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //             fit: BoxFit.cover,
              //             image: ExactAssetImage(
              //                 "assets/images/login-Background.png")),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
