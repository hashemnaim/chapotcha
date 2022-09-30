import 'package:capotcha/modules/Map/controller/address_controller.dart';
import 'package:get/get.dart';

import 'map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(),
    );
    Get.put(AddressController());
  }
}
