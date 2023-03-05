import 'package:capotcha/modules/Offer/offer_controller.dart';
import 'package:get/get.dart';
import '../Cart/controller/cart_controller.dart';
import '../My_Order/controller/order_controller.dart';
import '../Profile/controller/profile_controller.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(MainController());
    Get.put(ProfileController());

    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => OrderController(), fenix: true);
    Get.lazyPut(() => OfferController(), fenix: true);
  }
}
