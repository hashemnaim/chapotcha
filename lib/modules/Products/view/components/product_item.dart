// ignore_for_file: must_be_immutable

import 'package:capotcha/widgets/custom_svg.dart';
import 'package:capotcha/modules/Products/model/product_model.dart';
import 'package:capotcha/modules/Cart/model/cart_model.dart';
import 'package:capotcha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/animate_do.dart';
import '../../../../utils/constants.dart';

import '../../../../widgets/custom_network_image.dart';
import '../../../../utils/colors.dart';
import '../../../Cart/controller/cart_controller.dart';

class ProductItem extends StatelessWidget {
  ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  CartController cartController = Get.find<CartController>();
  double height = 300;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: height.h,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)],
            borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            Expanded(
              flex: 2,
              child: CustomNetworkImage(
                Constants.imgUrl + product.image!,
                fit: BoxFit.contain,
                // heigth: 110.h,
                width: Get.width,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    product.name!,
                    style: Style.cairo.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.h),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      double.parse(product.oldPrice!).toStringAsFixed(1) != "0.0"
                          ? Text(
                              " ${double.parse(product.oldPrice!).toStringAsFixed(1)} ",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'cairo',
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                              ))
                          : SizedBox.shrink(),
                      Text(" ${double.parse(product.price!).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'cairo',
                            color: Colors.grey[900],
                          )),
                      Text(' ${Constants.currency} ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'cairo',
                            color: Colors.grey[700],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "لل" + "${product.unit}",
                    style: Style.cairog.copyWith(fontSize: 14.sp),
                  ),
                  Spacer(),
                  Divider(),
                  GetBuilder<CartController>(
                    id: 'cart',
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () async {
                          await controller.addProductToCart(
                              CartModel.fromJson(product.toMap()));
                        },
                        child: controller.cartList.indexWhere((element) =>
                                    element.productId == product.id) ==
                                -1
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(" أضف الى السلة",
                                        style: Style.cairog.copyWith(
                                            fontSize: 16.sp, height: 1.3)),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomSvgImage(
                                      "icon-cart",
                                      color: AppColors.greenColor,
                                      isColor: true,
                                      height: 25.h,
                                    ),
                                  ])
                            : FadeInUp(
                                duration: Duration(milliseconds: 200),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                          int index = controller.cartList
                                              .indexWhere((element) =>
                                                  element.productId ==
                                                  product.id);
                                          await controller.IncreaseQuantity(
                                              index,
                                              product.unit == "كيلو"
                                                  ? 0.5
                                                  : 1.0);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 35,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.green,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        cartController
                                            .cartList[cartController.cartList
                                                .indexWhere((element) =>
                                                    element.productId ==
                                                    product.id)]
                                            .quantity
                                            .toString(),
                                        style:
                                            Style.cairog.copyWith(fontSize: 16),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          int index = controller.cartList
                                              .indexWhere((element) =>
                                                  element.productId ==
                                                  product.id);

                                          await controller.decreaseQuantity(
                                              index,
                                              product.unit == "كيلو"
                                                  ? 0.5
                                                  : 1.0);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 35,
                                          child: Icon(
                                            Icons.remove,
                                            color: Color(0xff748A9D),
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      if (product.offer == "1")
        Align(
          alignment: Alignment.topLeft,
          child: CustomPngImage(
            "modal_offer",
            fit: BoxFit.contain,
            heigth: 80.h,
            width: 80.h,
          ),
        ),
      product.state == "0" || product.stock == "0"
          ? Container(
              height: height.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.black.withOpacity(0.7)),
              child: Center(
                  child: Text("نفدت الكمية",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 18.sp))),
            )
          : Container()
    ]);
  }
}
