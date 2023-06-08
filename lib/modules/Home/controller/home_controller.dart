import 'dart:developer';

import 'package:get/get.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  HomeModel homeModel = HomeModel();
  HomeModel catogryModel = HomeModel();
  ApiCallStatus homeStatus = ApiCallStatus.holding;
  ApiCallStatus catogryStatus = ApiCallStatus.holding;

  getHome(isLoad, String parent_id) async {
    if (isLoad) homeStatus = ApiCallStatus.loading;
    await BaseClient.baseClient.post(Constants.HomeUrl, onSuccess: (response) {
      log(response.data.toString());
      if (response.data['status'] == true) {
        homeModel = HomeModel.fromJson(response.data);
        homeStatus = ApiCallStatus.success;
      } else {
        homeStatus = ApiCallStatus.error;
      }
      update(["home"]);
    });
  }

  getCatogry(String parent_id) async {
    catogryModel.dataCategory != null
        ? catogryModel.dataCategory!.clear()
        : null;
    catogryStatus = ApiCallStatus.loading;
    await BaseClient.baseClient.post(Constants.HomeUrl,
        data: {"parent_id": parent_id}, onSuccess: (response) {
      if (response.data['status'] == true) {
        catogryModel = HomeModel.fromJson(response.data);
        catogryStatus = ApiCallStatus.success;
      } else {
        catogryStatus = ApiCallStatus.error;
      }

      update(["product"]);
    });
  }
}
