import 'package:capotcha/View/widgets/customer_button.dart';
import 'package:capotcha/View/widgets/customer_text_Failed.dart';
import 'package:capotcha/View/widgets/cutomer_pass.dart';

import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/s_helpar.dart';
import 'package:capotcha/features/repository/sql_table.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String mobile;

  String password;

  String name;

//String email;

  setNumber(String mobile) {
    this.mobile = "2" + mobile;
  }

  setPassword(String password) {
    this.password = password;
  }

  setName(String name) {
    this.name = name;
  }

  setNameValidator(String value) {
    if (value == null || value.isEmpty) {
      return "لا يوجد اسم";
    } else {
      this.name = value;
    }
  }

  setPasswordValidator(String value) {
    if (value == null || value.isEmpty) {
      return "ادخل كلمة المرور";
    } else {
      this.password = value;
    }
  }

  setNaumberValidator(String value) {
    if (value == null || value.isEmpty || value.length < 9) {
      return "الرقم موبايل خطا";
    } else {
      this.mobile = value;
    }
  }

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final providerModalHand = Provider.of<HomeProvieder>(
      context,
    );

    return ModalProgressHUD(
      inAsyncCall: providerModalHand.isLoad,
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ExactAssetImage(
                            "assets/images/login-Background.png")),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  //height: MediaQuery.of(context).size.height * 0.745,
                  child: Form(
                      key: formKey,
                      child: ListView(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                "انشاء حساب",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff658199),
                                    fontFamily: "Cairo",
                                    fontSize: 24),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          CustomerTextFalied(
                              label: "اسم المستخدم",
                              validatorValue: setNameValidator,
                              onSaveV: setName,
                              iconTextfiled: Icons.account_circle,
                              typeInput: 0),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
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
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          CustomerTextFalied(
                              label: "رقم الموبايل",
                              validatorValue: setNaumberValidator,
                              onSaveV: setNumber,
                              iconTextfiled: Icons.phone,
                              //  prefixText: " | 20+",
                              // hintText: " ******* 010",
                              maxLength: 11,
                              // initValue:" | 20+" ,
                              typeInput: 3),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: CustomerButton(
                              submitFrom: () async {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();

                                  try {
                                    providerModalHand.changeModelhan(true);

                                    await providerModalHand.regsterUser(
                                      name,
                                      password,
                                      mobile,
                                    );

                                    if (providerModalHand
                                            .registerModel.accessToken !=
                                        null) {
                                    
                                  

                                      await Provider.of<HomeProvieder>(context,
                                              listen: false)
                                          .getHome();
                                      await Provider.of<HomeProvieder>(context,
                                              listen: false)
                                          .getProfile();
                                      await Provider.of<HomeProvieder>(context,
                                              listen: false)
                                          .setCart();
                                      await Provider.of<HomeProvieder>(context,
                                              listen: false)
                                          .getCarton(0);
                                      DBClint.dbClint.deleteproductAll();

                                      providerModalHand.changeModelhan(false);

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                        ModalRoute.withName('/HomePage'),
                                      );
                                    } else {
                                      providerModalHand.changeModelhan(false);
                                      Fluttertoast.showToast(
                                          msg: "الرقم مسجل مسبقا",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  } catch (e) {
                                    providerModalHand.changeModelhan(false);
                                  }
                                } else {
                                  providerModalHand.changeModelhan(false);
                                  Fluttertoast.showToast(
                                      msg: "البيانات غير مكتملة",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                setState(() {});
                              },
                              label: 'تسجيل',
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              providerModalHand.changeModelhan(false);
                            },
                            child: Center(
                              child: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                    color: Color(0xff658199),
                                    fontFamily: "Cairo",
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  //  height: MediaQuery.of(context).size.height * 0.123,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ExactAssetImage(
                            "assets/images/login2-Background.png")),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
//  Widget icon(BuildContext context){}
}
