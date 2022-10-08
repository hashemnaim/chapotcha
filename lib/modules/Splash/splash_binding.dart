import 'package:get/get.dart';
import 'initial_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<InitialController>(InitialController());
  }
}
