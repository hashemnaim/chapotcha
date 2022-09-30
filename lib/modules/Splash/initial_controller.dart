import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class InitialController extends GetxController {
  validateSession() {
    Future.delayed(Duration(seconds: 2), () {
      Get.offAndToNamed(Routes.MAIN);
    });
  }

  @override
  void onInit() {
    validateSession();
    super.onInit();
  }
}
