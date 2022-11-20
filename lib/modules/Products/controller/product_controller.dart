import 'package:capotcha/modules/Home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../utils/constants.dart';
import '../model/cartona_model.dart';
import '../model/list_product_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  List<Product> productModel = <Product>[];
  CartonaModel cartonaModel = CartonaModel();
  List<ProductList> productList = <ProductList>[];
  ProductList productListModel = ProductList();
  List<String?> productListname = <String?>[];
  ApiCallStatus productStatus = ApiCallStatus.holding;
  List<Widget> tabs = [];
  int indexTap = 0;
  RxInt idProduct = 0.obs;
  int indexProductList = 0;
  HomeController homeController = Get.find<HomeController>();

  getProduct(String? category, {isLoad = true}) async {
    if (isLoad == true) productStatus = ApiCallStatus.loading;
    await BaseClient.baseClient.post(Constants.productUrl, data: {
      "category": category,
    }, onSuccess: (response) async {
      productListModel = ProductList.fromJson(response.data);

      // productModel = [];
      // productList = [];

      // if (response.data['data'] != null) {
      //   // productModel = [];
      //   response.data['data'].forEach((v) {
      //     productModel.add(Product.fromJson(v));
      //   });
      //   productListname.add(category);
      //   productList.add(
      //       ProductList.fromJson({"name": category, "product": productModel}));
      // }

      productStatus = ApiCallStatus.success;
      update(["product"]);
    });
  }

  getCartona(String category, {IsLoad = true}) async {
    if (IsLoad == true) productStatus = ApiCallStatus.loading;
    await BaseClient.baseClient.post(Constants.cartonsUrl,
        onSuccess: (response) async {
      cartonaModel = CartonaModel.fromJson(response.data);
      // if (response.data['data'] != null) {
      //   productModel = [];
      //   response.data['data'].forEach((v) {
      //     productModel.add(Product.fromJson(v));
      //   });
      //   productListname.add(category);
      //   productList.add(
      //       ProductList.fromJson({"name": category, "product": productModel}));
      // }
      productStatus = ApiCallStatus.success;
      update(["product"]);
    });
  }

  void ChangeTapIndex(int value, {bool isInite = false}) async {
    // if (isInite == true) {
    indexTap = value;
    //   update(["product"]);
    // } else {
    // indexTap = value;
    // if (productList.isEmpty) {
    if (indexTap == 3) {
      await getCartona(
        "Cartona",
      );
    } else {
      await getProduct(
        homeController.homeModel.dataCategory![indexTap].name,
      );
    }
    // } else {
    // ProductListIndex(indexTap);
    // }
    // }
  }

  // void ProductListIndex(
  //   int value,
  // ) async {
  //   if (indexTap == 3) {
  //     if (productList.indexWhere((element) => element.name == "Cartona") ==
  //         -1) {
  //       await getCartona("Cartona", IsLoad: true);
  //     }
  //     indexProductList =
  //         productList.indexWhere((element) => element.name == "Cartona");
  //     update(["product"]);
  //   } else {
  //     if (productList.indexWhere((element) =>
  //             element.name ==
  //             homeController.homeModel.dataCategory![value].name) ==
  //         -1) {
  //       await getProduct(homeController.homeModel.dataCategory![value].name,
  //           isLoad: true);
  //     }
  //     indexProductList = productList.indexWhere((element) =>
  //         element.name == homeController.homeModel.dataCategory![value].name);

  //     update(["product"]);
  //   }
  // }

  getTap() {
    tabs = homeController.homeModel.dataCategory!
        .map((e) => Container(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(e.name!),
            )))
        .toList();
    update(["product"]);
  }

  @override
  void onInit() {
    getTap();
    ChangeTapIndex(
      Get.arguments ?? 0,
    );
    // getProduct(
    //   homeController.homeModel.dataCategory![Get.arguments].name,
    // );
    super.onInit();
  }
}
