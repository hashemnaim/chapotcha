import 'package:badges/badges.dart' as badges;
import 'package:capotcha/widgets/custom_svg.dart';
import 'package:capotcha/modules/Cart/controller/cart_controller.dart';
import 'package:capotcha/utils/animate_do.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../modules/Main/main_controller.dart';
import '../utils/shared_preferences_helpar.dart';

// ignore: must_be_immutable
class NavBarFloatCustom extends StatelessWidget {
  final bool isHome;

  NavBarFloatCustom({Key? key, this.isHome = true}) : super(key: key);

  MainController mainController = Get.find();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Bounce(
      child: FloatingActionButton(
          elevation: 1,
          backgroundColor: AppColors.greenColor,
          child: GetBuilder<CartController>(
            id: 'cart',
            builder: (controller) {
              return badges.Badge(
                badgeAnimation: badges.BadgeAnimation.slide(
                  disappearanceFadeAnimationDuration:
                      Duration(milliseconds: 300),
                  curve: Curves.easeInCubic,
                ),
                badgeContent: Text(
                  SHelper.sHelper.getToken() == null
                      ? "0"
                      : controller.cartApiModel.data == null
                          ? "0"
                          : controller.cartApiModel.data!.items!.length
                              .toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 10.sp),
                  textAlign: TextAlign.center,
                ),
                position: badges.BadgePosition.topEnd(top: -15.h, end: 14.w),
                child: CustomSvgImage(
                  "icon-cart",
                  height: 38.h,
                  width: 38.w,
                ),
              );
            },
          ),
          onPressed: () async {
            cartController.getCart();
            mainController.changeIndexBar(2, isHome);
          }),
    );
  }
}
