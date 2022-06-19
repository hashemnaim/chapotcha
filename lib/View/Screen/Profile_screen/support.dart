import 'package:capotcha/View/widgets/AppCustomer.dart';
import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/customer_button.dart';
import 'package:capotcha/View/widgets/navBottom2.dart';
import 'package:capotcha/View/widgets/navfloat2.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SupportScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<SupportScreen> {
  String mobile;

  String titleMastek;

  String name;

  String mastike;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final providerModalHand =
        Provider.of<HomeProvieder>(context, listen: false);
    double sizeh = MediaQuery.of(context).size.height;
    double sizew = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: providerModalHand.isLoad,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
                appBar: PreferredSize(
                  child: AppCustomer("الدعم الفني"),
                  preferredSize: const Size(double.infinity, 60),
                ),
                body: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Form(
                      key: formKey,
                      child: Stack(
                        children: [
                          Bakeground(),
                          ListView(
                            children: <Widget>[
                              SizedBox(height: sizeh * 0.02),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    height: sizeh * 0.1,
                                    child: TextFormField(
                                        textAlign: TextAlign.right,
                                        keyboardType: TextInputType.name,
                                        onChanged: (value) async {
                                          name = value;
                                        },
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: "الاسم كاملا",
                                            hintStyle: Style.cairo,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white)),
                              ),
                              SizedBox(height: sizeh * 0.02),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    height: sizeh * 0.1,
                                    child: TextFormField(
                                        textAlign: TextAlign.right,
                                        keyboardType: TextInputType.phone,
                                        onChanged: (value) async {
                                          mobile = value;
                                        },
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: "رقم الموبايل",
                                            hintStyle: Style.cairo,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                        color: Colors.white)),
                              ),
                              SizedBox(height: sizeh * 0.02),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    height: sizeh * 0.1,
                                    child: TextFormField(
                                        textAlign: TextAlign.right,
                                        onChanged: (value) async {
                                          titleMastek = value;
                                        },
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: "عنوان الموضوع",
                                            hintStyle: Style.cairo,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white)),
                              ),
                              SizedBox(height: sizeh * 0.02),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    height: sizeh * 0.16,
                                    child: TextFormField(
                                        textAlign: TextAlign.right,
                                        onChanged: (value) async {
                                          mastike = value;
                                        },
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: " وصف المشكلة",
                                            hintStyle: Style.cairo,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white)),
                              ),
                              SizedBox(height: sizeh * 0.08),
                              ModalProgressHUD(
                                inAsyncCall: providerModalHand.isLoad,
                                child: Container(
                                  height: sizeh * 0.08,
                                  width: sizew * 3,
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  child: CustomerButton(
                                    submitFrom: () async {
                                      providerModalHand.changeModelhan(true);
                                      await Provider.of<HomeProvieder>(context,
                                              listen: false)
                                          .setSendMassage(name, mobile,
                                              titleMastek, mastike);
                                      if (providerModalHand
                                              .sendMassage.status ==
                                          false) {
                                        providerModalHand.changeModelhan(false);
                                        Fluttertoast.showToast(
                                            msg: "العملية فشلت",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                AppColors.greenColor,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        providerModalHand.changeModelhan(false);
                                        Fluttertoast.showToast(
                                            msg: "تم ارسال الطلب",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                AppColors.greenColor,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }

                                      setState(() {});
                                    },
                                    label: 'ارسال',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: sizeh * 0.01,
                                width: sizew * 0.01,
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                floatingActionButton: NavFloat2(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: NavCustomer2()),
          )),
    );
  }
}
