import 'package:get/get.dart';
import '../Map/controller/address_controller.dart';

import 'initial_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InitialController());
    Get.put(AddressController());
    // Get.put(HomeController(), permanent: true);
    // Get.put(ProductController(), permanent: true);
    // Get.put(MapController(), permanent: true);
    // Get.put(HomeController());
  }
}
