import 'package:get/get.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  HomeModel homeModel = HomeModel();
  ApiCallStatus homeStatus = ApiCallStatus.holding;

  getHome(isLoad) async {
    if (isLoad) homeStatus = ApiCallStatus.loading;
    await BaseClient.baseClient.post(Constants.HomeUrl, onSuccess: (response) {
      if (response.data['status'] == true) {
        homeModel = HomeModel.fromJson(response.data);

        homeStatus = ApiCallStatus.success;
        update(["home"]);
      } else {
        homeStatus = ApiCallStatus.error;
        update(["home"]);
      }
    });
  }

  @override
  void onInit() {
    getHome(homeModel.dataCategory == null);
    super.onInit();
  }
}
