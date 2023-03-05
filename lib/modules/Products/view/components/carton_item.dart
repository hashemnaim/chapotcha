// ignore_for_file: must_be_immutable

import 'package:capotcha/widgets/custom_svg.dart';
import 'package:capotcha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/animate_do.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/shared_preferences_helpar.dart';
import '../../../../widgets/custom_network_image.dart';
import '../../../../utils/colors.dart';
import '../../../Cart/controller/cart_controller.dart';
import '../../controller/product_controller.dart';
import '../details_carton.dart';
import '../../model/cartona_model.dart';

class CartonItem extends GetView<ProductController> {
  CartonItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  CartController cartController = Get.find<CartController>();
  double height = 280;
  final DataCartona product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          //  product.stock == "0"
          //     ? null
          //     :
          () {
        DataCartona dataCartona = controller.cartonaModel.data!
            .firstWhere((element) => element.id == product.id);
        controller.idProduct.value = product.id!;
        Get.to(() => DetailsProduct(data: dataCartona, id: product.id));
      },
      child: Stack(children: [
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
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20.h,
                          left: 0,
                          right: 0,
                          child: CustomNetworkImage(
                            Constants.imgUrl + product.image!,
                            fit: BoxFit.contain,
                            heigth: 140.h,
                            width: Get.width,
                          ),
                        ),
                        Positioned(
                          top: 6.h,
                          right: 6.w,
                          child: Text(
                            product.name!,
                            style: Style.cairo.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                height: 1.h),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            (double.parse(product.price.toString()) +
                                    double.parse(product.discount.toString()))
                                .toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'cairo',
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red[700],
                            )),
                        SizedBox(width: 5.w),
                        Text("${product.price!.toStringAsFixed(1)}",
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
                      height: 4.h,
                    ),
                    Text(
                      "تفاصيل الكرتونة",
                      style: Style.cairog.copyWith(fontSize: 14.sp),
                    ),
                    Divider(),
                    GetBuilder<CartController>(
                      id: 'cart${product.name}',
                      builder: (controller) {
                        return GestureDetector(
                            onTap: () async {
                              if (SHelper.sHelper.getToken() == null) {
                                Get.toNamed(
                                  Routes.SignUpScreen,
                                );
                              } else {
                                await controller.addCartonCart(
                                    product.id!, product.name!);
                              }
                            },
                            child: controller.cartApiModel.data != null
                                ? controller.isUpdateCartload == true
                                    ? Container(
                                        width: 114.w,
                                        child: SpinKitThreeBounce(
                                          color: AppColors.greenColor,
                                          size: 20.0,
                                        ),
                                      )
                                    : controller.cartApiModel.data!.items!
                                                .indexWhere((element) =>
                                                    element.cartonName ==
                                                    product.name) ==
                                            -1
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(" أضف الى السلة",
                                                    style: Style.cairog
                                                        .copyWith(
                                                            fontSize: 16.sp,
                                                            height: 1.3)),
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
                                            duration:
                                                Duration(milliseconds: 200),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () async {
                                                      int index = controller
                                                          .cartApiModel
                                                          .data!
                                                          .items!
                                                          .indexWhere((element) =>
                                                              element
                                                                  .cartonName ==
                                                              product.name);

                                                      await controller
                                                          .IncreaseCartonQuantity(
                                                              index,
                                                              controller
                                                                  .cartApiModel
                                                                  .data!
                                                                  .items![index]
                                                                  .itemId,
                                                              1.0);
                                                    },
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 50.w,
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.green,
                                                        size: 28,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    cartController
                                                        .cartApiModel
                                                        .data!
                                                        .items![cartController
                                                            .cartApiModel
                                                            .data!
                                                            .items!
                                                            .indexWhere((element) =>
                                                                element
                                                                    .cartonName ==
                                                                product.name)]
                                                        .qty!
                                                        .substring(0, 3),
                                                    style: Style.cairog
                                                        .copyWith(
                                                            fontSize: 16.sp),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      int index = controller
                                                          .cartApiModel
                                                          .data!
                                                          .items!
                                                          .indexWhere((element) =>
                                                              element
                                                                  .cartonName ==
                                                              product.name);

                                                      await controller
                                                          .decreaseCartoneQuantity(
                                                              index,
                                                              controller
                                                                  .cartApiModel
                                                                  .data!
                                                                  .items![index]
                                                                  .itemId,
                                                              1.0);
                                                    },
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 50.w,
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            Color(0xff748A9D),
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ]));
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
        // product.stock == "0"
        //     ? Container(
        //         height: height.h,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(20.r),
        //             color: Colors.black.withOpacity(0.7)),
        //         child: Center(
        //             child: Text("نفدت الكمية",
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontFamily: "Cairo",
        //                     fontSize: 18.sp))),
        //       )
        //     : Container()
      ]),
    );
  }
}
