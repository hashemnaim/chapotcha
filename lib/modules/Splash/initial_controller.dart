import 'dart:io';
import 'package:capotcha/modules/Products/controller/product_controller.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../services/base_client.dart';
import '../../utils/constants.dart';
import 'package:version_check/version_check.dart';
import '../../utils/lunchers_helper.dart';
import '../../utils/styles.dart';
import '../Home/controller/home_controller.dart';

class InitialController extends GetxController {
  HomeController homeController = Get.put(HomeController(), permanent: true);
  ProductController productController =
      Get.put(ProductController(), permanent: true);
  validateSession() async {
    await homeController.getHome(false);
    productController.getProduct();
    Get.offAllNamed(Routes.MAIN);
  }

  final versionCheck = VersionCheck(
      packageName: Platform.isIOS
          ? 'com.capotcha.capotcha'
          : "https://play.google.com/store/apps/details?id=com.capotcha.capotcha",
      packageVersion: "2.1.8",
      showUpdateDialog: (BuildContext context, VersionCheck versionCheck) {});

  getVersion() async {
    await BaseClient.baseClient.get(Constants.settingUrl,
        onSuccess: (response) async {
      if (response.data['data'][12]['value'].toString() == "1") {
        await validateSession();
      } else {
        if (response.data['data'][12]['value'] == "2.1.8") {
          await validateSession();
        } else {
          return customShowUpdateDialog(Get.context!, versionCheck);
        }
      }
    });
  }

  @override
  void onInit() {
    getVersion();
    super.onInit();
  }

  void customShowUpdateDialog(BuildContext context, VersionCheck versionCheck) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          ' يوجد تحديث جديد',
          style: Style.cairo
              .copyWith(fontSize: 20.sp, color: AppColors.greenColor),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'عليك تحديث التطبيق للمتابعة',
                style: Style.cairo.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('تحديث'),
            onPressed: () async {
              await LuncherHelper.validationHelper.launchInBrowser(Uri.parse(Platform
                      .isIOS
                  ? "https://apps.apple.com/us/app/%D9%83%D8%A7%D8%A8%D9%88%D8%AA%D8%B4%D8%A7/id6444121882"
                  : "https://play.google.com/store/apps/details?id=com.capotcha.capotcha"));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
