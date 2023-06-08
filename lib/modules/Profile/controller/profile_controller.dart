import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/modules/Profile/model/profile_modal.dart';
import 'package:capotcha/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../../../utils/location_helper.dart';
import '../../../utils/shared_preferences_helpar.dart';
import '../../Map/controller/map_controller.dart';
import '../../Map/model/address_model.dart';
import '../../Map/view/enter_location_screen.dart';
import '../../My_Order/model/details_order_model.dart';
import '../model/shipping_time_model.dart';

class ProfileController extends GetxController {
  ProfileModel profileModel = ProfileModel();
  ShippingTimesModel shippingTimesModel = ShippingTimesModel();
  List<int> listCount = [];
  ApiCallStatus profileStatus = ApiCallStatus.holding;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController oldPasswordControlelr = TextEditingController();
  TextEditingController passwordControlelr = TextEditingController();
  TextEditingController confirmPasswordControlelr = TextEditingController();
  RxBool edit = true.obs;
  RxInt countOrderPeriod = 0.obs;

  getProfile() async {
    if (SHelper.sHelper.getToken() != null) {
      profileStatus = ApiCallStatus.loading;
      await BaseClient.baseClient.post(Constants.profileUrl,
          onSuccess: (response) async {
        profileModel = ProfileModel.fromJson(response.data);
        profileStatus = ApiCallStatus.success;
        if (profileModel.address == null) {
          LocationHelper.checkLocationPermission(() async {
            DataAddress addressLocation =
                await Get.find<MapController>().getCurrentLocation(true);
            Get.to(() => EnterLocationScreen(
                address: DataAddress(
                    lat: addressLocation.lat,
                    lng: addressLocation.lng,
                    area: addressLocation.area),
                fromApp: false));
          });
          update(["profile"]);
        } else {
          await SHelper.sHelper.saveAddress(Address(
              lat: profileModel.address!.lat.toString(),
              lng: profileModel.address!.lng.toString(),
              street: profileModel.address!.street,
              apartment: profileModel.address!.apartment,
              building: profileModel.address!.building,
              city_id: profileModel.address!.city_id.toString(),
              city: profileModel.address!.city,
              area: profileModel.address!.area));
          // await SHelper.sHelper
          //     .setIdAddress(profileModel.address!.city_id.toString());

          await getShippingTimes();
          update(["profile"]);
        }
      });
    }
  }

  // getProfile2(isLoad) async {
  //   profileStatus = ApiCallStatus.loading;
  //   await BaseClient.baseClient.post(Constants.profileUrl,
  //       onSuccess: (response) {
  //     profileModel = ProfileModel.fromJson(response.data);
  //     profileStatus = ApiCallStatus.success;
  //   });
  // }

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
      getProfile();
      update(["profile"]);
    });
  }

  removeUser() async {
    // profileStatus = ApiCallStatus.loading;
    BotToast.showLoading();
    await BaseClient.baseClient.post(Constants.removeUserUrl,
        onSuccess: (response) async {
      await SHelper.sHelper.removeToken();
      BotToast.closeAllLoading();

      Get.offAllNamed(Routes.SPLASH);

      update(["profile"]);
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

  Future<int> getOrdersCountPeriod(String day, String time) async {
    await BaseClient.baseClient.post(Constants.ordersCountPeriodUrl,
        data: {"day": day, "time": time}, onSuccess: (response) {
      if (response.data['status'] == true) {
        countOrderPeriod.value = response.data['count'];

        return response.data['count'];
      } else {
        return 0;
      }
    });
    return countOrderPeriod.value;
  }

  getChangePasswordProfile() async {
    BotToast.showLoading();

    await BaseClient.baseClient.post(Constants.passwordUpdateUrl, data: {
      "password": oldPasswordControlelr.text,
      "new_password": passwordControlelr.text,
    }, onSuccess: (response) async {
      if (response.data['status'] == true) {
        BotToast.closeAllLoading();

        await getProfile();
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
  void onInit() {
    getProfile();
    super.onInit();
  }
}
