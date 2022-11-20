import 'dart:io';

import 'package:capotcha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../services/base_client.dart';
import '../../utils/constants.dart';
import 'package:version_check/version_check.dart';

import '../../utils/styles.dart';

class InitialController extends GetxController {
  validateSession() {
    Future.delayed(Duration(seconds: 2), () {
      Get.offAndToNamed(Routes.MAIN);
    });
  }

  final versionCheck = VersionCheck(
      packageName:
          Platform.isIOS ? 'com.capotcha.capotcha' : 'com.capotcha.capotcha',
      packageVersion: '1.0.1',
      showUpdateDialog: (BuildContext context, VersionCheck versionCheck) {});

  getVersion() async {
    await BaseClient.baseClient.get(Constants.settingUrl,
        onSuccess: (response) async {
      if (response.data['data'][12]["value"] == "2.1.3") {
        validateSession();
      } else {
        return customShowUpdateDialog(Get.context!, versionCheck);
      }
    });
  }

  @override
  void onInit() {
    getVersion();
    // validateSession();
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
              await versionCheck.launchStore();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
