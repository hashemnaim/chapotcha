import 'package:capotcha/View/widgets/AppCustomer.dart';
import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ForgetScreen extends StatefulWidget {
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<ForgetScreen>
    with SingleTickerProviderStateMixin {
//List<DataProdacts> dataProdacts=[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final resetPassword = Provider.of<HomeProvieder>(
      context,
    );

    // getTap();
    String email;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: AppCustomer("نسيت كلمة المرور"),
            preferredSize: const Size(double.infinity, 60),
          ),
          //resizeToAvoidBottomInset: false,
          body: Container(
              child: Column(children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Bakeground(),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(

                            // padding: EdgeInsets.only(right: 20),
                            height: 60,
                            width: 300,
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                onChanged: (value) async {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "ادخل البريد الكتروني ",
                                    hintStyle: Style.cairo,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10)))),
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
                                color: Colors.white)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.greenColor),
                          child: RaisedButton(
                              color: Colors.transparent,
                              elevation: 0,
                              onPressed: () async {
                                await resetPassword.setResetPassword(email);
                                await Fluttertoast.showToast(
                                    msg: resetPassword.resetPassword.message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Text(
                                "ارسال",
                                style: Style.cairoW,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ])),
        ),
      ),
    );
  }
}
