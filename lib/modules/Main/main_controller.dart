import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class MainController extends GetxController {
  int? selectedPageIndex = 0;
  List<String> shippingTimes = [];

  changeIndexBar(int? index, bool isHome) {
    selectedPageIndex = index;
    if (isHome == false) {
      Get.toNamed(Routes.MAIN, arguments: 0);
    }
    update(["navBottomBar"]);
  }
}
