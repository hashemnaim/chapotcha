import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_network_image.dart';
import '../../../../widgets/custom_svg.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/colors.dart';
import '../../controller/cart_controller.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        id: "cart",
        builder: (controller) {
          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 6)
                            ],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CustomNetworkImage(
                                controller.cartApiModel.data!.items![index]
                                            .productType ==
                                        "كرتونة"
                                    ? controller.cartApiModel.data!
                                        .items![index].cartonImage!
                                    : controller.cartApiModel.data!
                                        .items![index].productImage!,
                                heigth: 80.h,
                                width: 50.w,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.cartApiModel.data!.items![index]
                                                .productType ==
                                            "كرتونة"
                                        ? controller.cartApiModel.data!
                                            .items![index].cartonName!
                                        : controller.cartApiModel.data!
                                            .items![index].productName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: AppColors.bluColor,
                                            height: 1.4,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      CustomConter(
                                          context,
                                          controller.cartApiModel.data!
                                              .items![index].productId!),
                                      SizedBox(width: 8.w),
                                      Text(
                                        controller.cartApiModel.data!
                                            .items![index].productType!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: AppColors.bluColor,
                                                height: 1.4),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      controller.cartApiModel.data!
                                              .items![index].total!
                                              .toString() +
                                          " " +
                                          Constants.currency,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              color: AppColors.bluColor,
                                              fontSize: 16.sp),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        controller.deleteProductFromCart(
                                            controller.cartApiModel.data!
                                                .items![index].itemId!,
                                            controller.cartApiModel.data!
                                                .items![index].productId!);
                                      },
                                      child: Container(
                                        height: 30.h,
                                        width: 30.w,
                                        child: Center(
                                          child: CustomSvgImage(
                                            "delete",
                                            isColor: true,
                                            height: 25,
                                            width: 25,
                                            color: Color(0xff98B119),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              controller.cartApiModel.data!.items![index].productType ==
                      "كرتونة"
                  ? Container()
                  : controller.cartApiModel.data!.items![index].productStatus ==
                          0
                      ? Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.7)),
                            child: Center(
                                child: Text("غير متوفر",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Cairo",
                                        fontSize: 18))),
                          ),
                        )
                      : Container(),
              controller.cartApiModel.data!.items![index].productType ==
                      "كرتونة"
                  ? Container()
                  : controller.cartApiModel.data!.items![index].productStok ==
                          "0"
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.black.withOpacity(0.7)),
                            child: Center(
                                child: Text("نفدت الكمية",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Cairo",
                                        fontSize: 18.sp))),
                          ),
                        )
                      : Container()
            ],
          );
        });
  }

  GetBuilder CustomConter(BuildContext context, int productId) {
    return GetBuilder<CartController>(
      id: 'cart$productId',
      builder: (controller) {
        return Container(
          height: 40.h,
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: controller.isUpdateCartload == true
              ? Container(
                  width: 114.w,
                  child: SpinKitThreeBounce(
                    color: AppColors.greenColor,
                    size: 20.0,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 25,
                      ),
                      splashColor: Colors.green,
                      onPressed: () {
                        controller.cartApiModel.data!.items![index]
                                    .productType ==
                                "كرتونة"
                            ? controller.IncreaseCartonQuantity(
                                index,
                                controller
                                    .cartApiModel.data!.items![index].itemId,
                                controller.cartApiModel.data!.items![index]
                                            .productType ==
                                        "كيلو"
                                    ? 0.5
                                    : 1.0)
                            : controller.IncreaseQuantity(
                                index,
                                controller
                                    .cartApiModel.data!.items![index].itemId,
                                controller.cartApiModel.data!.items![index]
                                            .productType ==
                                        "كيلو"
                                    ? 0.5
                                    : 1.0);
                      },
                    ),
                    Center(
                      child: Text(
                        controller.cartApiModel.data!.items![index].qty!
                            .substring(0, 3),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: AppColors.bluColor, fontSize: 16.sp),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Color(0xff748A9D),
                        size: 25,
                      ),
                      splashColor: Colors.red,
                      onPressed: () {
                        controller.decreaseQuantity(
                            index,
                            controller.cartApiModel.data!.items![index].itemId,
                            controller.cartApiModel.data!.items![index]
                                        .productType ==
                                    "كيلو"
                                ? 0.5
                                : 1.0);
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }
}
