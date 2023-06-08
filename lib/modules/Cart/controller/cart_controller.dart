import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/modules/Cart/model/cart_model.dart';
import 'package:capotcha/modules/My_Order/controller/order_controller.dart';
import 'package:capotcha/modules/Profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helper/db_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../../../utils/method_helpar.dart';
import '../../../utils/shared_preferences_helpar.dart';
import '../../Main/main_controller.dart';
import '../../Products/model/product_model.dart';
import '../model/cart_model_api.dart';

class CartController extends GetxController {
  Rx<CartApiModel> cartApiModel = CartApiModel().obs;
  List<CartModel> _cartList = [];
  Rx<TextEditingController>? promocCodeController = TextEditingController().obs;
  List<CartModel> get cartList => _cartList;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  ApiCallStatus cartStatus = ApiCallStatus.holding;
  bool isUpdateCartload = false;
  Rx<bool> isload = false.obs;
  Rx<bool> isActivePromoCode = false.obs;
  ProfileController profileController = Get.find();
  int selectedDay = 0;
  String dateDay = getDate(0);
  RxString dateDay2 = getDay1(0).obs;
  RxString selectedTime = "".obs;
  TextEditingController notesController = TextEditingController(text: "");

  List<String> days = [
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
    "السبت",
    "الأحد",
  ];

  void clear() {
    selectedTime.value = "";
    selectedDay = 0;
    dateDay = getDate(0);
    notesController.clear();
    cartList.clear();
    isActivePromoCode.value = false;

    DBHelper.dbHelper.deleteproductAll();
    update(['cart']);
  }

  getCountOrder(dateDay, index) async {
    profileController.listCount = [];
    isload.value = true;
    for (var i = 0;
        i < profileController.shippingTimesModel.cities!.shippingTimes!.length;
        i++) {
      int count = await profileController.getOrdersCountPeriod(
          dateDay2.value +
              "/" +
              dateUtc.add(Duration(days: index)).month.toString(),
          profileController
              .shippingTimesModel.cities!.shippingTimes![i].period!);
      profileController.listCount.add(count);
    }
    isload.value = false;
  }

  sendOrder(int? idAddress, String code) async {
    BotToast.showLoading();

    await BaseClient.baseClient.post(Constants.sendOrder, data: {
      "day": dateDay.toString(),
      "time": selectedTime.value.toString(),
      "address_id": idAddress.toString(),
      "delivery_cost":
          profileController.shippingTimesModel.cities!.shippingCost.toString(),
      "notes": notesController.value.text
    }, onSuccess: (response) {
      if (response.data['status'] == "OK") {
        BotToast.closeAllLoading();
        BotToast.showText(text: "تم ارسال الطلب بنجاح");
        clear();
        Get.find<MainController>().selectedPageIndex = 1;
        selectedTime.value = "";
        Get.find<OrderController>().getOrders(true);
        getCart();
        code == "0" ? null : applyCoupon(code);
        Get.offNamed(Routes.MAIN);
        update(["cart"]);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: "حدث خطأ ما");
      }
    });
  }

  selectDay(int index) {
    selectedDay = index;
    dateDay = getDate(index);
    update(["day"]);
  }

  selectTime(String time) {
    selectedTime.value = time;
  }

  addProductToCart(Product product) async {
    isUpdateCartload = true;
    update(["cart${product.id}"]);
    await addCart(product.id);
    isUpdateCartload = false;
    update(["cart${product.id}"]);
    update(["cart"]);
  }

  addCartonCart(int id, String name) async {
    isUpdateCartload = true;
    update(["cart$name"]);

    await addCartoneCart(id);
    isUpdateCartload = false;
    update(["cart$name"]);
    update(["cart"]);
  }

  addCart(String? product_id) async {
    await BaseClient.baseClient.post(
        Constants.addCartUrl +
            "?city_id=${SHelper.sHelper.getIdAddress() ?? ""}",
        data: {
          "product_id": product_id,
          "qty": "1.0",
        }, onSuccess: (response) async {
      cartApiModel.value = CartApiModel.fromJson(response.data);
      BotToast.showText(text: "تمت الاضافة بنجاح", align: Alignment.center);
      update(["cart$product_id"]);
    });
  }

  addCartoneCart(int? product_id) async {
    await BaseClient.baseClient.post(Constants.addCartUrl, data: {
      "carton_id": product_id,
      "qty": "1.0",
    }, onSuccess: (response) async {
      cartApiModel.value = CartApiModel.fromJson(response.data);
      BotToast.showText(text: "تمت الاضافة بنجاح", align: Alignment.center);
    });
  }

  applyCoupon(String? code) async {
    BotToast.showLoading();
    await BaseClient.baseClient.post(Constants.applyCouponUrl,
        data: {"code": code}, onSuccess: (response) async {
      BotToast.closeAllLoading();
      if (response.data["status"] == false) {
        BotToast.showText(
            text: response.data["message"], align: Alignment.center);
      } else {
        isActivePromoCode.value = true;
        BotToast.showText(text: "تم التفعيل بنجاح", align: Alignment.center);
        await getCart();
      }
    });
  }

  updateCart(int? product_id, String? qty) async {
    if (SHelper.sHelper.getToken() == null) {
      Get.toNamed(Routes.SignUpScreen);
    } else {
      await BaseClient.baseClient.post(Constants.updateCartUrl, data: {
        "item_id": product_id,
        "qty": qty,
      }, onSuccess: (response) async {
        cartApiModel.value = CartApiModel.fromJson(response.data);
      });
    }
  }

  deleteCart(int? product_id) async {
    if (SHelper.sHelper.getToken() == null) {
      Get.toNamed(
        Routes.SignUpScreen,
      );
    } else {
      BotToast.showLoading();
      await BaseClient.baseClient.post(Constants.deleteCartUrl, data: {
        "item_id": product_id,
      }, onSuccess: (response) async {
        cartApiModel.value = CartApiModel.fromJson(response.data);
        isActivePromoCode.value = false;
        BotToast.closeAllLoading();
        update(['cart$product_id']);
      });
    }
  }

  getCart({bool isLoad = false}) async {
    if (SHelper.sHelper.getToken() == null) {
    } else {
      if (isLoad == true) cartStatus = ApiCallStatus.loading;
      await BaseClient.baseClient.get(Constants.getCartUrl,
          onSuccess: (response) async {
        cartApiModel.value = CartApiModel.fromJson(response.data);
        cartStatus = ApiCallStatus.success;
        update(['cart']);
      });
    }
  }

  deleteProductFromCart(int idItem, String idProduct) async {
    await deleteCart(idItem);

    BotToast.showText(text: "تم الحذف بنجاح");
    update(['cart$idProduct']);

    update(['cart']);
  }

  deleteCartonFromCart(int idItem, String name) async {
    await deleteCart(idItem);
    BotToast.showText(text: "تم الحذف بنجاح");
    update(['cart$name']);
    update(['cart']);
  }

  IncreaseQuantity(int index, int? itemId, double quantity) async {
    if (double.parse(cartApiModel.value.data!.items![index].productStok!) <=
        double.parse(cartApiModel.value.data!.items![index].qty!)) {
      BotToast.showText(
        text: "لا يوجد كمية كافية",
        align: Alignment.center,
        contentColor: Colors.red,
      );
    } else {
      if (double.parse(cartApiModel.value.data!.items![index].maxQty!) <=
          double.parse(cartApiModel.value.data!.items![index].qty!)) {
        BotToast.showText(
          text: "لا يمكن اضافة اكثر من هذه الكمية",
          align: Alignment.center,
          contentColor: Colors.red,
        );
      } else {
        isUpdateCartload = true;
        update(['cart${cartApiModel.value.data!.items![index].productId}']);

        await updateCart(
          itemId,
          (double.parse(cartApiModel.value.data!.items![index].qty!) + quantity)
              .toString(),
        );
        isUpdateCartload = false;

        update(['cart${cartApiModel.value.data!.items![index].productId}']);
        update(['cart']);
      }
    }
  }

  IncreaseCartonQuantity(int index, int? itemId, double quantity) async {
    isUpdateCartload = true;
    update(['cart${cartApiModel.value.data!.items![index].cartonName}']);
    update(['cart${cartApiModel.value.data!.items![index].productId}']);

    await updateCart(
      itemId,
      (double.parse(cartApiModel.value.data!.items![index].qty!) + quantity)
          .toString(),
    );
    isUpdateCartload = false;

    update(['cart${cartApiModel.value.data!.items![index].cartonName}']);
    update(['cart${cartApiModel.value.data!.items![index].productId}']);

    update(['cart']);
  }

  //

  decreaseCartoneQuantity(int index, int? itemId, double quantity) async {
    if (double.parse(cartApiModel.value.data!.items![index].qty!) <= quantity) {
      deleteCartonFromCart(
          itemId!, cartApiModel.value.data!.items![index].cartonName!);
    } else {
      isUpdateCartload = true;

      update(['cart${cartApiModel.value.data!.items![index].cartonName}']);

      await updateCart(
        itemId,
        (double.parse(cartApiModel.value.data!.items![index].qty!) - quantity)
            .toString(),
      );

      isUpdateCartload = false;

      update(['cart${cartApiModel.value.data!.items![index].cartonName}']);

      update(['cart']);
    }
  }

  decreaseQuantity(int index, int? itemId, double quantity) async {
    if (double.parse(cartApiModel.value.data!.items![index].qty!) <= quantity) {
      deleteProductFromCart(itemId!,
          cartApiModel.value.data!.items![index].productId!.toString());
    } else {
      isUpdateCartload = true;

      update(['cart${cartApiModel.value.data!.items![index].productId}']);

      await updateCart(
        itemId,
        (double.parse(cartApiModel.value.data!.items![index].qty!) - quantity)
            .toString(),
      );

      isUpdateCartload = false;

      update(['cart${cartApiModel.value.data!.items![index].productId}']);

      update(['cart']);
    }
  }

  @override
  void dispose() {
    selectedTime.value = "";
    selectedDay = 0;
    notesController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    getCart(isLoad: true);
    super.onInit();
  }
}
