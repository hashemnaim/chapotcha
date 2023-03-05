import 'package:capotcha/utils/animate_do.dart';
import 'package:capotcha/utils/constants.dart';
import 'package:capotcha/utils/method_helpar.dart';

import 'package:capotcha/utils/styles.dart';
import 'package:capotcha/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/my_widgets_animator.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/shared_preferences_helpar.dart';
import '../../../utils/shimmer_helper.dart';
import '../../../utils/colors.dart';
import '../controller/order_controller.dart';
import 'components/custom_status.dart';
import 'details_order_screen.dart';

class MyOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (SHelper.sHelper.getToken() == null) {
      return InkWell(
          onTap: () => Get.toNamed(Routes.SignUpScreen),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BounceInRight(
                  child: CustomPngImage("login", heigth: 200.h, width: 200.w)),
              SizedBox(height: 20.h),
              Container(
                  child: Center(
                      child: Text(
                " تسجيل الدخول ",
                style: Style.cairogX
                    .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
              ))),
            ],
          ));
    } else {
      return GetBuilder<OrderController>(
          id: "order",
          builder: (controller) {
            return Container(
              decoration: backgroundImage,
              height: double.infinity,
              child: Align(
                alignment: Alignment.topCenter,
                child: MyWidgetsAnimator(
                    apiCallStatus: controller.orderStatus,
                    loadingWidget: () => ShimmerHelper.loadingHome(),
                    successWidget: (() => controller.orderModel.orders != null
                        ? RefreshIndicator(
                            onRefresh: () {
                              return controller.getOrders(true);
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "طلباتي",
                                      style: Style.cairo.copyWith(
                                          fontSize: 22.sp,
                                          color: AppColors.bluColor),
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      padding: EdgeInsets.only(
                                          bottom: 25.h, top: 8.h),
                                      itemCount:
                                          controller.orderModel.orders!.length,
                                      itemBuilder: (context, index) {
                                        controller.orderModel.orders!.sort(
                                            (a, b) => b.id!.compareTo(a.id!));

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 6),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      "طلبك رقم # ${controller.orderModel.orders![index].code}",
                                                      style: Style.cairo
                                                          .copyWith(
                                                              fontSize: 16.sp)),
                                                  subtitle: Text(
                                                    "تاريخ :" +
                                                        controller
                                                            .orderModel
                                                            .orders![index]
                                                            .date! +
                                                        " -\t الفترة :" +
                                                        getPeriod(controller
                                                            .orderModel
                                                            .orders![index]
                                                            .time!),
                                                    style: Style.cairo.copyWith(
                                                        fontSize: 14.sp,
                                                        color: Colors.grey),
                                                  ),
                                                  trailing: InkWell(
                                                    onTap: () async {
                                                      await controller
                                                          .getDetilesOrders(
                                                              controller
                                                                  .orderModel
                                                                  .orders![
                                                                      index]
                                                                  .id);
                                                      Get.to(() =>
                                                          OrderDetailsScreen(
                                                            index: index,
                                                          ));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .greenColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 14,
                                                                vertical: 6),
                                                        child: Text(
                                                          "تفاصيل",
                                                          style: Style.cairo
                                                              .copyWith(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .white,
                                                                  height: 1.3),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  child: Divider(
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                                CustomStauts(
                                                  controller: controller,
                                                  index: index,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 8.h),
                                CustomPngImage("no_order",
                                    heigth: 300.h, width: 300.w),
                                SizedBox(height: 8.h),
                                Text(
                                  "لا يوجد طلبات",
                                  style:
                                      Style.cairogX.copyWith(fontSize: 25.sp),
                                ),
                              ],
                            ),
                          ))),
              ),
            );
          });
    }
  }
}
