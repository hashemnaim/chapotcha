import 'package:capotcha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import '../../../utils/shimmer_helper.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/my_widgets_animator.dart';

import '../controller/order_controller.dart';
import 'components/custom_status.dart';
import 'components/item_detiles_order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int? index;

  const OrderDetailsScreen({Key? key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBarCustom(
              isBack: true,
              title: "تفاصيل الطلب",
            )),
        body: GetBuilder<OrderController>(
            id: "Detailsorder",
            builder: (controller) => MyWidgetsAnimator(
                apiCallStatus: controller.detailsOrderStatus,
                loadingWidget: () => ShimmerHelper.loadingHome(),
                successWidget: (() => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomStauts(
                            controller: controller,
                            index: index,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.detailsOrderModel.orders!.products!
                                        .isEmpty
                                    ? SizedBox.shrink()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              "منتجات",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              padding: EdgeInsets.zero,
                                              itemCount: controller
                                                  .detailsOrderModel
                                                  .orders!
                                                  .products!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return ItemDetilsOrder(
                                                  name: controller
                                                      .detailsOrderModel
                                                      .orders!
                                                      .products![index]
                                                      .name,
                                                  price: controller
                                                      .detailsOrderModel
                                                      .orders!
                                                      .products![index]
                                                      .price,
                                                  image: controller
                                                      .detailsOrderModel
                                                      .orders!
                                                      .products![index]
                                                      .image,
                                                  qty: controller
                                                      .detailsOrderModel
                                                      .orders!
                                                      .products![index]
                                                      .quantity,
                                                );
                                              }),
                                        ],
                                      ),
                                controller.detailsOrderModel.orders!.cartons!
                                        .isEmpty
                                    ? SizedBox.shrink()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              "كراتين",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              padding: EdgeInsets.zero,
                                              itemCount: controller
                                                  .detailsOrderModel
                                                  .orders!
                                                  .cartons!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return ItemDetilsOrder(
                                                  name: controller
                                                      .detailsOrderModel
                                                      .orders!
                                                      .cartons![index]
                                                      .cartonName,
                                                  price: controller
                                                      .detailsOrderModel
                                                      .orders!
                                                      .cartons![index]
                                                      .cartonPrice,
                                                  image: controller
                                                      .detailsOrderModel
                                                      .orders!
                                                      .cartons![index]
                                                      .image,
                                                  qty: controller
                                                      .detailsOrderModel
                                                      .orders!
                                                      .cartons![index]
                                                      .cartonQuantity,
                                                );
                                              }),
                                        ],
                                      )
                              ],
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Container(
                                height: 220.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200]!,
                                          blurRadius: 6)
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    row(
                                        context,
                                        "رقم الطلب",
                                        "# " +
                                            controller.detailsOrderModel.orders!
                                                .orderId
                                                .toString()),
                                    row(
                                        context,
                                        "تاريخ الطلب",
                                        controller
                                            .detailsOrderModel.orders!.date
                                            .toString()),
                                    row(
                                        context,
                                        "العنوان",
                                        controller.detailsOrderModel.orders!
                                            .address!.street
                                            .toString()),
                                    row(
                                      context,
                                      "التوصيل",
                                      (controller.detailsOrderModel.orders!
                                                  .deliveryCost ??
                                              "0.0") +
                                          " " +
                                          Constants.currency,
                                    ),
                                    row(
                                        context,
                                        "المجموع",
                                        controller.detailsOrderModel.orders!
                                                    .products!.length ==
                                                0
                                            ? controller
                                                .getTotalPrice()
                                                .toString()
                                            : (controller.getTotalPrice() +
                                                        controller
                                                            .detailsOrderModel
                                                            .orders!
                                                            .cartons!
                                                            .map((e) =>
                                                                double.parse(e
                                                                    .totalPrice!))
                                                            .reduce((value,
                                                                    element) =>
                                                                value +
                                                                element))
                                                    .toStringAsFixed(1) +
                                                Constants.currency),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ])))));
    // floatingActionButton: NavBarFloatCustom(
    //   isHome: false,
    // ),
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    // bottomNavigationBar: NavBottomBarCustom(
    //   isHome: false,
    // ));
  }

  Padding row(BuildContext context, String titel, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 8.w),
          Column(
            children: [
              Text(
                titel,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.bluColor, height: 1.4),
              ),
              // Spacer(),
              // CustomConter(controller, context),
            ],
          ),
          Spacer(),
          Column(children: <Widget>[
            Text(
              price,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: AppColors.bluColor, fontSize: 16.sp),
            ),
          ])
        ],
      ),
    );
  }
}
