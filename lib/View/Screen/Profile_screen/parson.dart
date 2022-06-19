import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:capotcha/View/widgets/AppCustomer.dart';
import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/isload.dart';
import 'package:capotcha/View/widgets/navBottom2.dart';
import 'package:capotcha/View/widgets/navfloat2.dart';

import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/home_repository.dart';
import 'package:capotcha/models/profile_modal.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Parson extends StatefulWidget {
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<Parson>
    with SingleTickerProviderStateMixin {
  String name = "";
  String email = "";
  String address = "";
  String mobile = "";
  String password;
  String passwordNew;

  setName(String name) {
    this.name = name;
  }

  setPasswordnew(String passwordNew) {
    this.passwordNew = passwordNew;
  }

  setAddress(String address) {
    this.address = address;
  }

  setEmail(String email) {
    this.email = email;
  }

  setMobile(String mobile) {
    this.mobile = mobile;
  }

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                child: AppCustomer("الملف الشخصي"),
                preferredSize: const Size(double.infinity, 60),
              ),
              body: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Bakeground(),
                          FutureBuilder<Profile_Modal>(
                            future: HomeRepository.homeRepository.getProfile(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                print("object");
                                Profile_Modal profile = snapshot.data;

                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "بيانات المستخدمين",
                                        style:
                                            Style.cairo.copyWith(fontSize: 25),
                                      ),
                                      SizedBox(
                                        height: sizeH * 0.03,
                                      ),

                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          //  height: sizeH * 0.565,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: sizeH * 0.01,
                                                ),
                                                Text(
                                                  "اسم المستخدم",
                                                  style: Style.cairo,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      profile.user.name,
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontFamily: 'Cairo',
                                                        fontSize: 18.0,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        //     enable = true;
                                                        daulig(
                                                            "تغير اسم المستخدم",
                                                            setName);
                                                        setState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.mode_edit,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: sizeH * 0.02,
                                                ),
                                                Text(
                                                  "العنوان",
                                                  style: Style.cairo,
                                                ),
                                                SizedBox(
                                                  height: sizeH * 0.01,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      profile.user.address,
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontFamily: 'Cairo',
                                                        fontSize: 18.0,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        daulig("تغير العنوان",
                                                            setAddress);
                                                        setState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.mode_edit,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: sizeH * 0.02,
                                                ),
                                                Text(
                                                  "البريد الالكتروني ",
                                                  style: Style.cairo,
                                                ),
                                                SizedBox(
                                                  height: sizeH * 0.01,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      profile.user.email != null
                                                          ? profile.user.email
                                                          : "",
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontFamily: 'Cairo',
                                                        fontSize: 18.0,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        daulig(
                                                            "تغير البريد الالكتروني",
                                                            setEmail);
                                                        setState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.mode_edit,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: sizeH * 0.02,
                                                ),
                                                Text(
                                                  "رقم الموبايل",
                                                  style: Style.cairo,
                                                ),
                                                SizedBox(
                                                  height: sizeH * 0.01,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      profile.user.mobile,
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontFamily: 'Cairo',
                                                        fontSize: 18.0,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        daulig(
                                                            "تغير رقم الموبايل",
                                                            setMobile);
                                                        setState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.mode_edit,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: sizeH * 0.03,
                                                ),
                                                Text(
                                                  "كلمة المرور",
                                                  style: Style.cairo,
                                                ),
                                                SizedBox(
                                                  height: sizeH * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "**********",
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontFamily: 'Cairo',
                                                        fontSize: 18.0,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showMyDialog();
                                                        setState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.mode_edit,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 10),
                                      //   child: Container(
                                      //     width: sizew,
                                      //     height: sizeH * 0.06,
                                      //     decoration: BoxDecoration(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //         color: AppColors.greenColor),
                                      //     child: RaisedButton(
                                      //         color: Colors.transparent,
                                      //         elevation: 0,
                                      //         onPressed: () {},
                                      //         child: Text(
                                      //           "حفظ",
                                      //           style: Style.cairoW,
                                      //         )),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                );
                              } else {
                                return Center(child: IsLoad());
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: NavFloat2(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: NavCustomer2()),
        ));
  }

  Future<void> daulig(String tite, Function seve) async {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.NO_HEADER,
        animType: AnimType.BOTTOMSLIDE,
        title: tite,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              tite,
              style: Style.cairog,
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(onChanged: (value) => seve(value))),
          ],
        ),
        desc: tite,
        btnCancelText: "الغاء",
        btnOkText: "حفظ",
        btnOkColor: AppColors.greenColor,
        btnCancelColor: AppColors.bluColor,
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          if (email == null) {
            email = "a@a.com";
          }

          print("$address");
          await Provider.of<HomeProvieder>(context, listen: false)
              .setUpdateUser(name, email, address, mobile);

          setState(() {});
        })
      ..show();
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Colors.grey[300],
            title: Center(
                child: Text(
              "تغير كلمة المرور ",
              style: Style.cairo,
            )),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text("كلمة المرور القديمة", style: Style.cairog),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                        keyboardType: TextInputType.values[0],
                        textAlign: TextAlign.right,
                        onChanged: (newValue) => {password = newValue},
                        decoration: InputDecoration()),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text("كلمة المرور الجديدة", style: Style.cairog),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                        keyboardType: TextInputType.values[0],
                        textAlign: TextAlign.right,
                        onChanged: (newValue) => {passwordNew = newValue},
                        decoration: InputDecoration()),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('الغاء', style: Style.cairo),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'حفظ',
                  style: Style.cairo,
                ),
                onPressed: () async {
                  print("$password $passwordNew");
                  await Provider.of<HomeProvieder>(context, listen: false)
                      .getcChangePassword(password, passwordNew);
                  if (Provider.of<HomeProvieder>(context, listen: false)
                          .changePassword
                          .status ==
                      true) {
                    await Fluttertoast.showToast(
                        msg: "تم تغير كلمة المرور",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.greenColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.of(context).pop();
                  } else {
                    await Fluttertoast.showToast(
                        msg: "كلمة المرور القديمة خطا",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
