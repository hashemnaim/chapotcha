import 'package:capotcha/modules/Products/controller/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController(), permanent: true);
  }
}
