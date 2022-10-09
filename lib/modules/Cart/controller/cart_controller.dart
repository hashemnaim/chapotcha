import 'dart:convert';
import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/modules/Cart/model/cart_model.dart';
import 'package:capotcha/modules/My_Order/controller/order_controller.dart';
import 'package:capotcha/modules/Profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helper/db_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../../../utils/method_helpar.dart';
import '../../Main/main_controller.dart';

class CartController extends GetxController {
  List<CartModel> _cartList = [];
  List<CartModel> get cartList => _cartList;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  ProfileController profileController = Get.find();
  int selectedDay = 0;
  String dateDay = getDate(0);
  RxString dateDay2 = getDay1(0).obs;
  RxString selectedTime = "".obs;
  TextEditingController notesController = TextEditingController();

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
    notesController.clear();
    cartList.clear();

    DBHelper.dbHelper.deleteproductAll();
    update(['cart']);
  }

  sendOrder(int? idAddress) async {
    List<CartModel> listProduct =
        cartList.where((element) => element.unit != "كرتونة").toList();

    List<CartModel> listCartona =
        cartList.where((element) => element.unit == "كرتونة").toList();

    List mapCartona = listCartona.map((e) => e.toMapCartona()).toList();
    List mapProduct = listProduct.map((e) => e.toMapProduct()).toList();

    String productList = jsonEncode(mapProduct);
    String cartonaList = jsonEncode(mapCartona);

    BotToast.showLoading();
    log("productList: $productList");
    log("productList: $cartonaList");
    log(idAddress.toString());
    log(notesController.value.text);
    log(profileController.shippingTimesModel.cities!.shippingCost.toString());
    await BaseClient.baseClient.post(Constants.sendOrder, data: {
      "product_list": productList,
      "carton_list": cartonaList,
      "day": dateDay.toString(),
      "time": selectedTime.value.toString(),
      "address_id": idAddress.toString(),
      "delivery_cost":
          profileController.shippingTimesModel.cities!.shippingCost.toString(),
      "notes": notesController.value.text
    }, onSuccess: (response) {
      log(response.data.toString());
      if (response.data['status'] == true) {
        BotToast.closeAllLoading();
        BotToast.showText(text: "تم ارسال الطلب بنجاح");
        clear();
        Get.find<MainController>().selectedPageIndex = 1;
        selectedTime.value = "";
        Get.find<OrderController>().getOrders(true);
        Get.offNamed(Routes.MAIN);
        update(["cart"]);
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

  addProductToCart(CartModel cartModel) async {
    // for (var element in _cartList) {
    //   if (element.productId == cartModel.productId) {
    //     BotToast.showText(text: "هذا المنتج موجود بالفعل");
    //     return;
    //   }
    // }
    await DBHelper.dbHelper.insert(cartModel);
    getAllProduct();
    BotToast.showText(text: "تمت الاضافة بنجاح");
  }

  getAllProduct() async {
    _cartList = await DBHelper.dbHelper.getAllProduct();
    getTotalPrice();
    update(['cart']);
  }

  getTotalPrice() async {
    _totalPrice = 0.0;
    for (var element in _cartList) {
      _totalPrice = _totalPrice +
          double.parse(element.price!) * double.parse(element.quantity!);
    }
    update(['cart']);
  }

  String getTotalAll() {
    update(['cart', 'ShippingTimes']);

    return (totalPrice +
            double.parse(
                profileController.shippingTimesModel.cities!.shippingCost!))
        .toStringAsFixed(1)
        .toString();
  }

  deleteProductFromCart(CartModel cartModel) async {
    await DBHelper.dbHelper.delate(cartModel);
    getAllProduct();
    BotToast.showText(text: "تم الحذف بنجاح");
    update(['cart']);
  }

  IncreaseQuantity(int index, double quantity) async {
    if (double.parse(_cartList[index].stock!) <=
        double.parse(_cartList[index].quantity!)) {
      BotToast.showText(text: "لا يوجد كمية كافية");
    } else {
      if (double.parse(_cartList[index].maxQty!) <=
          double.parse(_cartList[index].quantity!)) {
        BotToast.showText(
          text: "لا يمكن اضافة اكثر من هذه الكمية",
        );
      } else {
        _cartList[index].quantity =
            (double.parse(_cartList[index].quantity!) + quantity)
                .toStringAsFixed(1);
        await DBHelper.dbHelper.update(_cartList[index]);
        getTotalPrice();

        update(['cart']);
      }
    }
  }

  decreaseQuantity(int index, double quantity) async {
    if (double.parse(_cartList[index].quantity!) <= quantity) {
      deleteProductFromCart(_cartList[index]);
    } else {
      _cartList[index].quantity =
          (double.parse(_cartList[index].quantity!) - quantity)
              .toStringAsFixed(1);
      getTotalPrice();

      await DBHelper.dbHelper.update(_cartList[index]);
    }
    update(['cart']);
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
    getAllProduct();
    super.onInit();
  }
}
