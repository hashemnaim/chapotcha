import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/utils/method_helpar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import '../../../utils/lunchers_helper.dart';
import '../../../utils/shimmer_helper.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/my_widgets_animator.dart';
import '../controller/order_controller.dart';
import 'components/custom_status.dart';
import 'components/item_detiles_order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int? index;

  const OrderDetailsScreen({Key? key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get.put(OrderController());
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
                successWidget: (() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            row(
                                context,
                                "رقم الطلب",
                                controller.detailsOrderModel.orders!.code
                                        .toString() +
                                    "#"),
                            SizedBox(height: 8.h),
                            row(
                                context,
                                "موعد الطلب",
                                getPeriod(controller
                                        .detailsOrderModel.orders!.time!) +
                                    " / " +
                                    controller.detailsOrderModel.orders!.date!),
                            SizedBox(height: 8.h),
                            row(
                                context,
                                "العنوان",
                                controller.detailsOrderModel.orders!.address!
                                        .city! +
                                    ' - ' +
                                    controller.detailsOrderModel.orders!
                                        .address!.area!
                                        .toString()),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomDivider(),
                            ),
                            CustomStauts(controller: controller, index: index),
                            SizedBox(height: 8.h),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                          .cartonQuantity);
                                                }),
                                          ],
                                        )
                                ],
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              child: Column(
                                children: [
                                  row(
                                    context,
                                    "مجموع المنتجات",
                                    (controller.detailsOrderModel.orders!
                                                .totalPrice ??
                                            "0.0") +
                                        " " +
                                        Constants.currency,
                                  ),
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
                                    "الخصم",
                                    (controller.detailsOrderModel.orders!
                                                .discount_price ??
                                            "0.0") +
                                        " " +
                                        Constants.currency,
                                  ),
                                  CustomDivider(),
                                  row(
                                      context,
                                      "الإجمالي",
                                      controller
                                              .getTotalPrice()
                                              .toStringAsFixed(1) +
                                          " " +
                                          Constants.currency),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            getAvalipleEdit(
                                        DateTime.parse(controller
                                                .detailsOrderModel
                                                .orders!
                                                .date!)
                                            .day
                                            .toString(),
                                        controller
                                            .detailsOrderModel.orders!.time!) ==
                                    false
                                ? Container()
                                : InkWell(
                                    onTap: (() => LuncherHelper.validationHelper
                                        .launchWhatsApp(
                                            message: " لتعديل طلب رقم " +
                                                controller.detailsOrderModel
                                                    .orders!.orderId
                                                    .toString() +
                                                "")),
                                    child: SizedBox(
                                      height: 50.h,
                                      width: 350.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.greenColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 8),
                                          child: Center(
                                            child: Text(
                                              "تعديل الطلب",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontSize: 16.sp,
                                                      color: Colors.white,
                                                      height: 1.3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ]),
                    )))));
  }

  Padding row(BuildContext context, String titel, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titel,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.bluColor, fontSize: 16.sp, height: 1.8.h),
            ),
          ),
          // Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              price,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.bluColor, fontSize: 16.sp, height: 1.7.h),
            ),
          )
        ],
      ),
    );
  }
}
