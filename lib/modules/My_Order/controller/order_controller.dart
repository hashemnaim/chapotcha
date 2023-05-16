import 'dart:developer';

import 'package:get/get.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../../../utils/shared_preferences_helpar.dart';
import '../model/details_order_model.dart';
import '../model/order_model.dart';

class OrderController extends GetxController {
  OrderModel orderModel = OrderModel();
  DetailsOrderModel detailsOrderModel = DetailsOrderModel();
  ApiCallStatus orderStatus = ApiCallStatus.holding;
  ApiCallStatus detailsOrderStatus = ApiCallStatus.holding;
  RxBool edit = false.obs;

  getOrders(isLoad) async {
    if (SHelper.sHelper.getToken() == null) {
    } else {
      orderStatus = ApiCallStatus.loading;
      await BaseClient.baseClient.post(Constants.getOrder,
          onSuccess: (response) {
        orderModel = OrderModel.fromJson(response.data);
        orderStatus = ApiCallStatus.success;
        update(["order"]);
      });
    }
  }

  double getTotalPrice() {
    return double.parse(detailsOrderModel.orders!.totalPrice ?? "0.0") +
        double.parse(detailsOrderModel.orders!.deliveryCost ?? "0.0");
  }

  getDetilesOrders(int? id) async {
    detailsOrderStatus = ApiCallStatus.loading;
    await BaseClient.baseClient.post(Constants.getOrder, data: {"order_id": id},
        onSuccess: (response) {
      detailsOrderModel = DetailsOrderModel.fromJson(response.data);
      detailsOrderStatus = ApiCallStatus.success;
    });
    update(["Detailsorder"]);
  }

  final List<String> listStatus = [
    "استلام",
    "قيد التجهيز",
    "توصيل",
    "تسليم",
  ];
  @override
  void onInit() async {
    getOrders(true);
    super.onInit();
  }
}
