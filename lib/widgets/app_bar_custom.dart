import 'package:capotcha/config/theme/light_theme_colors.dart';
import 'package:capotcha/modules/Map/model/address_model.dart';
import 'package:capotcha/modules/Profile/controller/profile_controller.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../modules/Map/controller/map_controller.dart';
import '../modules/Map/view/enter_location_screen.dart';
import '../utils/location_helper.dart';
import '../utils/lunchers_helper.dart';
import '../utils/method_helpar.dart';
import '../utils/shared_preferences_helpar.dart';
import 'custom_svg.dart';

class AppBarCustom extends StatelessWidget {
  final bool isBack;
  final bool isHome;
  final String title;

  AppBarCustom(
      {Key? key, this.isBack = false, this.title = "", this.isHome = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: SHelper.sHelper.getToken() == null
          ? true
          : isBack == true
              ? true
              : false,
      titleSpacing: 0,
      title: isBack == false
          ? SHelper.sHelper.getToken() == null
              ? CustomPngImage("im3", heigth: 40.h, width: 110.w)
              : Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            bottomLeft: Radius.circular(20.r)),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 8.w),
                            CustomSvgImage("location",
                                height: 25.h, width: 25.w),
                            SizedBox(width: 8.w),
                            GetBuilder<ProfileController>(
                                id: "profile",
                                builder: (controller) {
                                  if (controller.profileModel.address == null) {
                                    return InkWell(
                                        onTap: () {
                                          LocationHelper
                                              .checkLocationPermission(
                                                  () async {
                                            DataAddress addressLocation =
                                                await Get.find<MapController>()
                                                    .getCurrentLocation(true);
                                            Get.to(() => EnterLocationScreen(
                                                address: DataAddress(
                                                    lat: addressLocation.lat,
                                                    lng: addressLocation.lng,
                                                    area: addressLocation.area),
                                                fromApp: false));
                                          });
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text("اضاف عنوانك",
                                                style: Theme.of(context)
                                                    .appBarTheme
                                                    .titleTextStyle!
                                                    .copyWith(
                                                        color: LightThemeColors
                                                            .blackColor
                                                            .withOpacity(
                                                                0.6)))));
                                  } else {
                                    return InkWell(
                                        onTap: () {
                                          changeMyAddress();
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                                "${controller.profileModel.address!.city} - ${controller.profileModel.address!.area}",
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .appBarTheme
                                                    .titleTextStyle!
                                                    .copyWith(
                                                        fontSize: 14.sp))));
                                  }
                                })
                          ])))
          : Text(title, style: Theme.of(context).appBarTheme.titleTextStyle),
      leading: isBack == true
          ? InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CustomSvgImage("back", height: 30.h, width: 30.w)))
          : Container(width: 1.w),
      leadingWidth: isBack == true ? 60.w : 0,
      actions: [
        isHome
            ? Container()
            : InkWell(
                onTap: () {
                  LuncherHelper.validationHelper
                      .launchWhatsApp(message: "اريد");
                },
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: CustomSvgImage("whatup",
                        height: 30.h,
                        color: AppColors.bluColor,
                        isColor: true))),
        SizedBox(width: 8.w)
      ],
    );
  }
}
