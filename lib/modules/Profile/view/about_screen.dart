import 'package:capotcha/widgets/nav_bar_custom.dart';
import 'package:capotcha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../../utils/animate_do.dart';
import '../../../utils/constants.dart';

class AboutScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBarCustom(
              isBack: true,
              title: "عن التطبيق",
            )),
        body: Container(
          decoration: backgroundImage,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: FadeInRight(
                  duration: Duration(milliseconds: 2000),
                  child: Container(
                    height: 80,
                    width: 220,
                    padding: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/im3.png"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "كابوتشا",
                    style: Style.cairog,
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "هي خدمة متخصصة في تجارة التجزئة للخضروات و الفواكه عبر الانترنت",
                    style: Style.cairo,
                  )),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "ضمان الجودة",
                    style: Style.cairog,
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "هو الحصول على المنتجات من المزارع و الموزعين المعتدمين محلياً و دولياً",
                    style: Style.cairo,
                  )),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "رؤيتنا",
                    style: Style.cairog,
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "أن نكون الوجهه الاولي للخضروات والفواكه للمستهلك النهائي",
                    style: Style.cairo,
                  )),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        floatingActionButton: NavBarFloatCustom(
          isHome: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBottomBarCustom(
          isHome: false,
        ));
  }
}
