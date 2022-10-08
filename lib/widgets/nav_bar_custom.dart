import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../modules/Main/main_controller.dart';
import 'custom_svg.dart';

class NavBottomBarCustom extends GetView<MainController> {
  NavBottomBarCustom({Key? key, this.isHome = true}) : super(key: key);
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        id: "navBottomBar",
        builder: (controller) {
          return BottomAppBar(
            child: Container(
              height: 51.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navBarItem(
                    text: "الرئيسية",
                    icon: "icon-store",
                    index: 0,
                  ),
                  navBarItem(
                    text: "طلباتي",
                    icon: "Bill Icon",
                    index: 1,
                  ),
                  navBarItem(
                    text: "",
                    icon: "",
                    index: 1,
                  ),
                  navBarItem(
                    text: "العروض",
                    icon: "icon-recipes",
                    index: 3,
                  ),
                  navBarItem(
                    text: "المزيد",
                    icon: "icon-settings",
                    index: 4,
                  ),
                ],
              ),
            ),
            shape: CircularNotchedRectangle(),
          );
        });
  }

  Widget navBarItem({required String text, String? icon, int? index, double size = 19}) {
    return InkWell(
      onTap: () => {
        controller.changeIndexBar(index, isHome),
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon == "")
            SizedBox.shrink()
          else
            CustomSvgImage(icon,
                isColor: true,
                height: size,
                width: size,
                color: controller.selectedPageIndex == 2
                    ? Color(0xff98B119)
                    : controller.selectedPageIndex == index
                        ? Colors.blue[900]
                        : Color(0xff98B119)),
          Text(
            text,
            style: TextStyle(
              fontSize: 9.sp,
              color: controller.selectedPageIndex == 2
                  ? Color(0xff98B119)
                  : controller.selectedPageIndex == index
                      ? Colors.blue[900]
                      : Color(0xff98B119),
            ),
          ),
        ],
      ),
    );
  }
}
