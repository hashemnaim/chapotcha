import 'package:capotcha/widgets/custom_loading.dart';
import 'package:capotcha/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/animate_do.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              BounceInDown(
                  duration: Duration(milliseconds: 2000),
                  child: CustomPngImage("icon",
                      width: 170.w, heigth: 155.h, fit: BoxFit.contain)),
              FadeInLeft(
                duration: Duration(milliseconds: 2000),
                child: CustomPngImage(
                  "im2",
                  heigth: 50.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10.h),
              FadeInRight(
                duration: Duration(milliseconds: 2000),
                child: CustomPngImage(
                  "im3",
                  heigth: 80.h,
                  width: 220.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 30.h),
              CustomLoading()
            ],
          ),
        ),
      ),
    );
  }
}
