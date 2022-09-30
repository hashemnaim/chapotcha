import 'package:capotcha/modules/Offer/offer_controller.dart';
import 'package:get/get.dart';
// import '../Home/home_controller.dart';
import '../Cart/controller/cart_controller.dart';
import '../Home/controller/home_controller.dart';
import '../My_Order/controller/order_controller.dart';
import '../Profile/controller/profile_controller.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ProfileController());

    Get.put(HomeController());

    Get.put(MainController());
    Get.put(CartController());
    Get.put(OrderController());

    Get.lazyPut(() => OfferController());
  }
}
