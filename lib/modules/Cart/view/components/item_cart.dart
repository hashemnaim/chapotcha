import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                                Constants.imgUrl +
                                    controller.cartList[index].image!,
                                heigth: 80.h,
                                width: 60.w,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.cartList[index].productName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: AppColors.bluColor,
                                            height: 1.4),
                                  ),
                                  Spacer(),
                                  CustomConter(controller, context),
                                ],
                              ),
                              Spacer(),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      (double.parse(controller
                                                      .cartList[index].price!) *
                                                  double.parse(controller
                                                      .cartList[index]
                                                      .quantity!))
                                              .toStringAsFixed(1) +
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
                                            controller.cartList[index]);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
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
                  controller.cartList[index].available == false
                      ? Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.12,
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
                      : Container()
                ],
              ),
              controller.cartList[index].unit == "كرتونة"
                  ? Container()
                  : controller.cartList[index].stock == "0"
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

  Container CustomConter(CartController controller, BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
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
              controller.IncreaseQuantity(
                  index, controller.cartList[index].unit == "كيلو" ? 0.5 : 1);
            },
          ),
          Center(
            child: Text(
              controller.cartList[index].quantity.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: AppColors.bluColor, fontSize: 16.sp),
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
                  index, controller.cartList[index].unit == "كيلو" ? 0.5 : 1);
            },
          ),
        ],
      ),
    );
  }
}
