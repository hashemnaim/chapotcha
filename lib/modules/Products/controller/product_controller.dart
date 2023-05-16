import 'dart:developer';

import 'package:capotcha/modules/Home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../../../utils/shared_preferences_helpar.dart';
import '../model/cartona_model.dart';
import '../model/list_product_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  CartonaModel cartonaModel = CartonaModel();
  ProductList productListModel = ProductList();
  List<String?> productListname = <String?>[];
  List<List<Product>> productListData = [];
  List<Product> productList = [];
  ApiCallStatus productStatus = ApiCallStatus.holding;
  List<Widget> tabs = [];
  int indexTap = 0;
  RxInt idProduct = 0.obs;
  int indexProductList = 0;
  HomeController homeController = Get.find<HomeController>();

  Future<List<List<Product>>> getProduct({isLoad = true}) async {
    if (isLoad == true) productStatus = ApiCallStatus.loading;
    getCartona();
    log(SHelper.sHelper.getIdAddress() ?? "");
    await BaseClient.baseClient.post(
        Constants.newProductUrl +
            "?city_id=${SHelper.sHelper.getAddress().city_id ?? ""}",
        onSuccess: (response) async {
      productListModel = ProductList.fromJson(response.data);
      productListData = [];
      productList = [];

      for (var element in homeController.homeModel.dataCategory!) {
        productList = productListModel.listProduct!
            .where((e) => e.categoryId == element.name!)
            .toList();
        productListData.add(productList);
      }
      productStatus = ApiCallStatus.success;
      update(["product"]);
    });

    return productListData;
  }

  Future<CartonaModel>? getCartona({IsLoad = true}) async {
    await BaseClient.baseClient.post(
        Constants.cartonsUrl +
            "?city_id=${SHelper.sHelper.getAddress().city_id ?? ""}",
        onSuccess: (response) async {
      cartonaModel = CartonaModel.fromJson(response.data);

      update(["product"]);
    });
    return cartonaModel;
  }
}
