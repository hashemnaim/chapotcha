import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/shared_preferences_helpar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../../../utils/keyboard.dart';
import '../view/new_password_screen.dart';

class AuthController extends GetxController {
  // InitialController initialController = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  // TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Rx<bool> saveData = false.obs;
  Rx<bool> obscureText = true.obs;
  Rx<String> token = "".obs;

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    // emailController.dispose();
    super.dispose();
  }

  clear() {
    obscureText.value = true;
    mobileController.clear();
    nameController.clear();
    // emailController.clear() ;
    passwordController.clear();
  }

  singUp(formKey) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      KeyboardUtil.hideKeyboard(Get.context!);
      BotToast.showLoading();
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? fcmToken = await firebaseMessaging.getToken();
      await SHelper.sHelper.setFcmToken(fcmToken!);
      await BaseClient.baseClient.post(Constants.registerUrl, data: {
        "name": nameController.text,
        "mobile": mobileController.text,
        "password": passwordController.text,
        "fcm_token": fcmToken,
      }, onSuccess: (response) async {
        if (response.data['status'] == true) {
          await SHelper.sHelper.setToken(response.data['accessToken']);

          BotToast.closeAllLoading();
          BotToast.showText(
            text: response.data['message'],
          );
          clear();

          Get.offAllNamed(Routes.MAIN);
        } else {
          BotToast.closeAllLoading();

          BotToast.showText(
              text: response.data["message"], contentColor: Colors.red);
        }
      });
    }
  }

  singIn(formKey) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      KeyboardUtil.hideKeyboard(Get.context!);
      BotToast.showLoading();
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? fcmToken = await firebaseMessaging.getToken();
      await SHelper.sHelper.setFcmToken(fcmToken!);
      await BaseClient.baseClient.post(Constants.loginUrl, data: {
        "mobile": mobileController.text,
        "password": passwordController.text,
        "fcm_token": fcmToken,
      }, onSuccess: (response) async {
        if (response.data['status'] == true) {
          BotToast.closeAllLoading();

          await SHelper.sHelper.setToken(response.data['accessToken']);
          BotToast.showText(
            text: response.data['message'],
          );
          clear();
          Get.offAllNamed(Routes.MAIN);
        } else {
          BotToast.closeAllLoading();

          BotToast.showText(
              text: response.data["message"], contentColor: Colors.red);
        }
      });
    }
  }

  resentPassword(formKey) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      KeyboardUtil.hideKeyboard(Get.context!);
      BotToast.showLoading();
      await BaseClient.baseClient.post(Constants.resendPasswordUrl, data: {
        "mobile": mobileController.text,
      }, onSuccess: (response) {
        BotToast.closeAllLoading();

        if (response.data['status'] == true) {
          Get.to(() => NewPasswordScreen());
        } else {
          BotToast.closeAllLoading();
          BotToast.showText(
              text: response.data["message"], contentColor: Colors.red);
        }
      });
    }
  }

  newPassword(formKey) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      KeyboardUtil.hideKeyboard(Get.context!);
      await BaseClient.baseClient.post(Constants.changePasswordUrl, headers: {
        "Authorization": "Bearer ${SHelper.sHelper.getToken()}"
      }, data: {
        "new_password": newPasswordController.text,
      }, onSuccess: (response) {
        BotToast.closeAllLoading();

        if (response.data['status'] == true) {
          BotToast.showText(
            text: response.data['message'],
          );
          Get.toNamed(Routes.SignInScreen);
        } else {
          BotToast.closeAllLoading();
          BotToast.showText(
              text: response.data["message"], contentColor: Colors.red);
        }
      });
    }
  }
  // verification(formKey) async {
  //   if (formKey.currentState.validate()) {
  //     formKey.currentState.save();
  //     KeyboardUtil.hideKeyboard(Get.context);
  //     BotToast.showLoading();
  //     await BaseClient.baseClient.post(Constants.verificationUrl, data: {
  //       "mobile": "00${codeCountry.value}" + mobileControlelr.value.text,
  //       "verification_code": codeValtionController.value.text,
  //     }, onSuccess: (response) async {
  //       if (response.data["status"] == true) {
  //         mobileControlelr.value.text = mobileControlelr.value.text;
  //         passwordControlelr.value.text = passwordControlelr.value.text;
  //         singIn(formKey);
  //       } else {
  //         BotToast.closeAllLoading();

  //         BotToast.showText(
  //             text: response.data["message"][0], contentColor: Colors.red);
  //       }
  //     });
  //   }
  // }

  // resendOtp() async {
  //   KeyboardUtil.hideKeyboard(Get.context);
  //   await BaseClient.baseClient.post(Constants.resendOtpUrl, data: {
  //     "mobile": "00${codeCountry.value}" + mobileControlelr.value.text,
  //   }, onSuccess: (response) async {
  //     if (response.data["status"] == true) {
  //       BotToast.showText(
  //           text: response.data["message"], contentColor: Colors.green);
  //     } else {
  //       BotToast.showText(
  //           text: response.data["message"][0], contentColor: Colors.red);
  //     }
  //   });
  // }

}
