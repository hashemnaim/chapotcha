import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/shared_preferences_helpar.dart';
import 'package:capotcha/widgets/custom_button.dart';
import 'package:capotcha/utils/constants.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/location_helper.dart';
import '../../../utils/method_helpar.dart';
import '../../../widgets/custom_svg.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/my_widgets_animator.dart';
import '../../Map/controller/map_controller.dart';
import '../../Map/model/address_model.dart';
import '../../Map/view/enter_location_screen.dart';
import '../../Profile/controller/profile_controller.dart';
import '../controller/cart_controller.dart';
import 'checkout_screen.dart';
import 'components/item_cart.dart';

// ignore: must_be_immutable
class CartScreen extends GetView<CartController> {
  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundImage,
      child: SHelper.sHelper.getToken() == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPngImage(
                  "empty_cart",
                  heigth: 300.h,
                  width: 300.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10.h),
                Singin(),
              ],
            )
          : GetBuilder<CartController>(
              id: "cart",
              builder: (controller) => MyWidgetsAnimator(
                    apiCallStatus: controller.cartStatus,
                    loadingWidget: () => Center(child: CustomLoading()),
                    successWidget: (() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (controller.cartApiModel.data!.items!.isEmpty)
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomPngImage(
                                        "empty_cart",
                                        heigth: 300.h,
                                        width: 300.w,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(height: 10.h),
                                      addNew(),
                                    ],
                                  ),
                                )
                              else
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: controller.cartApiModel
                                                .data!.items!.length,
                                            itemBuilder: (context, index) {
                                              return Dismissible(
                                                  key: UniqueKey(),
                                                  direction: DismissDirection
                                                      .startToEnd,
                                                  onDismissed: (DismissDirection
                                                      direction) async {
                                                    controller
                                                        .deleteProductFromCart(
                                                            controller
                                                                .cartApiModel
                                                                .data!
                                                                .items![index]
                                                                .itemId!,
                                                            controller
                                                                .cartApiModel
                                                                .data!
                                                                .items![index]
                                                                .productId!);
                                                  },
                                                  background: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          height: 200,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height: 26,
                                                              width: 26,
                                                              child:
                                                                  CustomSvgImage(
                                                                "delete",
                                                                isColor: true,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  child:
                                                      ItemCart(index: index));
                                            }),
                                      ),
                                      SizedBox(height: 6.h),
                                      addNew(),
                                    ],
                                  ),
                                ),
                              Center(
                                child: Column(
                                  children: [
                                    controller.cartApiModel.data!.items!.isEmpty
                                        ? SizedBox.shrink()
                                        : Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "الإجمالي",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            fontSize: 16.sp,
                                                          ),
                                                    ),
                                                    Text(
                                                      controller.cartApiModel
                                                              .data!.total!
                                                              .toStringAsFixed(
                                                                  1) +
                                                          " " +
                                                          Constants.currency,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            fontSize: 16.sp,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                              GetBuilder<ProfileController>(
                                                id: "profile",
                                                builder: (_) {
                                                  return CustomButton(
                                                      buttonText: "إستمرار",
                                                      onPressed: () {
                                                        if (SHelper.sHelper
                                                                .getToken() ==
                                                            null) {
                                                          Get.toNamed(Routes
                                                              .SignInScreen);
                                                        } else {
                                                          if (_.profileModel
                                                                  .address ==
                                                              null) {
                                                            Get.defaultDialog(
                                                                title: "عنوانك",
                                                                titleStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleLarge!
                                                                    .copyWith(
                                                                        fontSize: 18
                                                                            .sp),
                                                                content: Column(
                                                                    children: [
                                                                      Text(
                                                                          ".يجب إضافة عنوان , لاكمال العملية",
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .titleLarge!
                                                                              .copyWith(fontSize: 16.sp)),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      CustomButton(
                                                                          buttonText:
                                                                              "إضافة عنوان",
                                                                          onPressed:
                                                                              () async {
                                                                            Get.back();
                                                                            LocationHelper.checkLocationPermission(() async {
                                                                              BotToast.showLoading();
                                                                              DataAddress addressLocation = await Get.find<MapController>().getCurrentLocation(true);
                                                                              BotToast.closeAllLoading();
                                                                              Get.to(() => EnterLocationScreen(address: DataAddress(lat: addressLocation.lat, lng: addressLocation.lng, area: addressLocation.area), fromApp: false));
                                                                            });
                                                                          })
                                                                    ]));
                                                          } else {
                                                            if (controller
                                                                    .cartApiModel
                                                                    .data!
                                                                    .total! <
                                                                70) {
                                                              BotToast.showText(
                                                                  text:
                                                                      "يجب أن يكون الطلب أكبر من 70 جنيه",
                                                                  contentColor:
                                                                      Colors
                                                                          .red);
                                                            } else {
                                                              controller
                                                                  .selectedDay = 0;
                                                              controller
                                                                      .dateDay2
                                                                      .value =
                                                                  dateUtc
                                                                      .add(Duration(
                                                                          days:
                                                                              0))
                                                                      .day
                                                                      .toString();

                                                              profileController
                                                                  .getShippingTimes();
                                                              controller
                                                                  .getCountOrder(
                                                                      controller
                                                                          .dateDay2
                                                                          .value,
                                                                      0);
                                                              Get.to(() =>
                                                                  CheckoutScreen());
                                                            }
                                                          }
                                                        }
                                                      });
                                                },
                                              ),
                                              SizedBox(height: 40.h)
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ])),
                  )),
    );
  }

  Center addNew() {
    return Center(
        child: Container(
      width: 200.w,
      height: 50.h,
      child: InkWell(
        onTap: () async {
          Get.toNamed(Routes.ProductScreen, arguments: 0);
        },
        child: Container(
          width: 200.w,
          height: 50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "إضافة عنصر جديد ",
                style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
                    color: AppColors.bluColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
              CircleAvatar(
                radius: 15.r,
                backgroundColor: AppColors.greenColor,
                child: Icon(Icons.add, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    ));
  }

  InkWell Singin() {
    return InkWell(
      onTap: () async {
        Get.toNamed(
          Routes.SignUpScreen,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.greenColor,
            child:
                Center(child: Icon(Icons.login, size: 20, color: Colors.white)),
          ),
          SizedBox(width: 10.w),
          Text(
            "تسجيل الدخول ",
            style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
                color: AppColors.bluColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
