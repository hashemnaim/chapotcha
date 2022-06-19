import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:capotcha/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../View/Screen/Auth_screen/login_screen.dart';
import '../animate_do.dart';

pushWithReplecemnet(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

pushWithNoReplecemnet(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => FadeOut(child: screen)));
}

double sizeh(context) {
  double sizeh = MediaQuery.of(context).size.height;
  return sizeh;
}

double sizew(context) {
  double sizew = MediaQuery.of(context).size.width;
  return sizew;
}

AwesomeDialog awesomeDialog(BuildContext context) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      // title: " تسجيل دخول ",
      desc: 'تحتاج الى تسجيل دخول',
      btnCancelText: "الغاء",
      btnOkText: "تسجيل دخول",
      btnOkColor: AppColors.greenColor,
      btnCancelColor: AppColors.bluColor,
      titleTextStyle: GoogleFonts.cairo(),
      descTextStyle: GoogleFonts.cairo(),
      buttonsTextStyle: GoogleFonts.cairo(),
      btnCancelOnPress: () {
        // Navigator.of(context).pop();
      },
      btnOkOnPress: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
}
