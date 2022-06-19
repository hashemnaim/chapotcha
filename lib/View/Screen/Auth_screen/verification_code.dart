import 'package:capotcha/View/widgets/customer_button.dart';
import 'package:capotcha/View/widgets/isload.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/s_helpar.dart';
import 'package:capotcha/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';

class VerificationSendCode extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<VerificationSendCode> {
  bool _onEditing = true;
  String _code;

  @override
  Widget build(BuildContext context) {
    final providerModalHand = Provider.of<HomeProvieder>(
      context,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExactAssetImage("assets/images/login-Background.png")),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
          ),
          Text(
            'الرجاء ادخال الرمز',
            style: TextStyle(
                color: Color(0xff658199), fontFamily: "Cairo", fontSize: 24),
          ),
          Text(
            'OTP',
            style: TextStyle(
                color: Color(0xff658199), fontFamily: "Cairo", fontSize: 24),
          ),
          Container(
            alignment: Alignment.center,
            width: 250,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset.fromDirection(1, 3),
                    spreadRadius: 2,
                    color: Colors.grey,
                    blurRadius: 5.0,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: VerificationCode(
              textStyle: TextStyle(fontSize: 20.0, color: AppColors.greenColor),
              keyboardType: TextInputType.number,
              underlineColor: Colors.green,
              length: 4,
              onCompleted: (value) {
                _code = value;

                setState(() {});
              },
              onEditing: (bool value) {
                setState(() {
                  _onEditing = value;
                });
                if (!_onEditing) FocusScope.of(context).unfocus();
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          CustomerButton(
            submitFrom: _code != null
                ? () async {
                    providerModalHand.changeModelhan(true);

                    await providerModalHand.verifyMobile(
                        providerModalHand.mobile,
                        _code,
                        providerModalHand.password);
                    providerModalHand.changeModelhan(true);

                    if (providerModalHand.loginModel.status == true) {
                     await SHelper.sHelper
                          .setToken(providerModalHand.loginModel.accessToken);
                      await Provider.of<HomeProvieder>(context, listen: false)
                          .getHome();

                      providerModalHand.changeModelhan(false);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                    } else {
                      await Fluttertoast.showToast(
                          msg: "هناك خطا بالكود",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      providerModalHand.changeModelhan(false);
                    }
                  }
                : null,
            label: 'استمرار',
          ),
          SizedBox(
            child: providerModalHand.isLoad == true
                ? Center(child: IsLoad())
                : Container(),
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          GestureDetector(
            onTap: () async {
              await Fluttertoast.showToast(
                  msg: "تم ارسال الكود مرة اخرى ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            child: Text(
              'اعادة ارسال الكود ',
              style: TextStyle(
                  color: Color(0xff658199), fontFamily: "Cairo", fontSize: 14),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.17,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        ExactAssetImage("assets/images/login2-Background.png")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
