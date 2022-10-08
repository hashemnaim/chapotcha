import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/modules/Profile/model/profile_modal.dart';
import 'package:capotcha/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../model/shipping_time_model.dart';

class ProfileController extends GetxController {
  ProfileModel profileModel = ProfileModel();
  ShippingTimesModel shippingTimesModel = ShippingTimesModel();
  ApiCallStatus profileStatus = ApiCallStatus.holding;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController oldPasswordControlelr = TextEditingController();
  TextEditingController passwordControlelr = TextEditingController();
  TextEditingController confirmPasswordControlelr = TextEditingController();
  String delivaryCost = "0.0";
  RxBool edit = false.obs;

  getProfile(isLoad) async {
    profileStatus = ApiCallStatus.loading;
    await BaseClient.baseClient.post(Constants.profileUrl,
        onSuccess: (response) {
      profileModel = ProfileModel.fromJson(response.data);
      profileStatus = ApiCallStatus.success;
      if (profileModel.address == null) {
        Get.toNamed(Routes.EnterLocationScreen);
      } else {
        getShippingTimes();
      }
      update(["profile"]);
    });
  }

  sendSupport() async {
    await BaseClient.baseClient.post(Constants.sendMessageUrl, data: {
      "name": profileModel.user!.name,
      "mobile": profileModel.user!.mobile,
      "title": titleController.text,
      "body": bodyController.text,
    }, onSuccess: (response) {
      titleController.text = "";
      bodyController.text = "";
      if (response.data['status'] == true) {
        BotToast.showText(text: "تم ارسال الرسالة بنجاح");
      } else {
        BotToast.showText(text: "حدث خطأ ما");
      }
      update(["support"]);
    });
  }

  getUpdateProfile() async {
    profileStatus = ApiCallStatus.loading;
    await BaseClient.baseClient.post(Constants.updateProfileUrl, data: {
      "name": profileModel.user!.name,
      "email": profileModel.user!.email,
      "mobile": profileModel.user!.mobile,
    }, onSuccess: (response) {
      profileModel = ProfileModel.fromJson(response.data);
      profileStatus = ApiCallStatus.success;
      update(["profile"]);
      if (profileModel.address!.city == null) {
        Get.toNamed(Routes.EnterLocationScreen);
      } else {
        getShippingTimes();
      }
    });
  }

  getShippingTimes() async {
    await BaseClient.baseClient.post(Constants.completeCartUrl,
        onSuccess: (response) {
      if (response.data['statues'] == true) {
        shippingTimesModel = ShippingTimesModel.fromJson(response.data);
      }
      update(["ShippingTimes"]);
    });
  }

  getChangePasswordProfile() async {
    BotToast.showLoading();

    await BaseClient.baseClient.post(Constants.passwordUpdateUrl, data: {
      "password": oldPasswordControlelr.text,
      "new_password": passwordControlelr.text,
    }, onSuccess: (response) async {
      if (response.data['status'] == true) {
        BotToast.closeAllLoading();

        await getProfile(false);
        BotToast.showText(
          text: response.data['messages'],
        );
        oldPasswordControlelr.clear();
        passwordControlelr.clear();
        confirmPasswordControlelr.clear();
        Get.back();
      } else {
        BotToast.closeAllLoading();

        BotToast.showText(
            text: response.data['messages'][0], contentColor: Colors.red);
      }
    });
  }

  @override
  void onInit() async {
    await getProfile(true);
    super.onInit();
  }
}
