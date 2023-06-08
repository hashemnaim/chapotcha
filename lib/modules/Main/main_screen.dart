import 'package:capotcha/widgets/app_bar_custom.dart';
import 'package:capotcha/widgets/nav_float_custom.dart';
import 'package:capotcha/modules/Home/view/components/page_nav.dart';
import 'package:capotcha/utils/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/nav_bar_custom.dart';
import '../../utils/constants.dart';
import 'main_controller.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        id: "navBottomBar",
        builder: (controller) => Scaffold(
            appBar: PreferredSize(
                preferredSize: controller.selectedPageIndex == 0
                    ? Size(0, 0)
                    : Size.fromHeight(AppBar().preferredSize.height),
                child: AppBarCustom()),
            body: GetBuilder<MainController>(
                id: "navBottomBar",
                builder: (controller) => Container(
                      decoration: backgroundImage,
                      child: FadeInRight(
                          delay: Duration(
                              milliseconds:
                                  100 * controller.selectedPageIndex!),
                          child: PageNav
                              .widgetOptions[controller.selectedPageIndex!]),
                    )),
            floatingActionButton: NavBarFloatCustom(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: NavBottomBarCustom()));
  }
}
