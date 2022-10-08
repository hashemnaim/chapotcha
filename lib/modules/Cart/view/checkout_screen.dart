import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/constants.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/utils/shared_preferences_helpar.dart';
import 'package:capotcha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/form_field_item.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/method_helpar.dart';
import '../../Profile/controller/profile_controller.dart';
import '../controller/cart_controller.dart';

class CheckoutScreen extends GetView<CartController> {
  CheckoutScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var padding2 = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Divider(height: 1, color: AppColors.gryText[400]),
    );
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBarCustom(
              isBack: true,
              title: "السلة",
            )),
        body: Container(
          decoration: backgroundImage,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      height: 45.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "موعد التوصيل",
                          style: Style.cairo.copyWith(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    padding2,
                    Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            SingleChildScrollView(
                                padding: EdgeInsets.symmetric(horizontal: 7.w),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: List.generate(
                                        5,
                                        (index) => InkWell(
                                            onTap: () {
                                              controller.selectDay(index);
                                              controller.dateDay2.value =
                                                  getDay1(index);
                                              controller.selectTime("0");
                                            },
                                            child: GetBuilder<CartController>(
                                                id: "day",
                                                builder: (controller) =>
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Container(
                                                        width: 110.w,
                                                        height: 60.h,
                                                        decoration: BoxDecoration(
                                                            color: controller
                                                                        .selectedDay ==
                                                                    index
                                                                ? AppColors
                                                                    .greenColor
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .greenColor)),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .days[DateTime.now()
                                                                            .add(Duration(days: index))
                                                                            .weekday -
                                                                        1]
                                                                    .toString(),
                                                                style: Style.cairo.copyWith(
                                                                    color: controller.selectedDay ==
                                                                            index
                                                                        ? Colors
                                                                            .white
                                                                        : AppColors
                                                                            .gryText,
                                                                    fontSize:
                                                                        15.sp,
                                                                    height:
                                                                        1.5.h),
                                                              ),
                                                              Text(
                                                                getDate(index),
                                                                style: Style.cairo.copyWith(
                                                                    color: controller.selectedDay ==
                                                                            index
                                                                        ? Colors
                                                                            .white
                                                                        : AppColors
                                                                            .gryText,
                                                                    fontSize:
                                                                        16.sp,
                                                                    height:
                                                                        1.5.h),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )))))),
                            SizedBox(
                              height: 4.h,
                            ),
                            Container(
                                height: 65.h,
                                child: GetBuilder<ProfileController>(
                                    id: "ShippingTimes",
                                    builder:
                                        (profileController) =>
                                            SingleChildScrollView(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7.w),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child:
                                                    profileController
                                                            .shippingTimesModel
                                                            .cities!
                                                            .shippingTimes!
                                                            .isEmpty
                                                        ? Container()
                                                        : Row(
                                                            children:
                                                                List.generate(
                                                            profileController
                                                                .shippingTimesModel
                                                                .cities!
                                                                .shippingTimes!
                                                                .length,
                                                            (index) {
                                                              return Obx(() => InkWell(
                                                                  onTap: getAvaliple(index, controller.dateDay2.value, profileController.shippingTimesModel.cities!.shippingTimes!) == false
                                                                      ? null
                                                                      : () {
                                                                          controller.selectTime(profileController
                                                                              .shippingTimesModel
                                                                              .cities!
                                                                              .shippingTimes![index]
                                                                              .period!);
                                                                        },
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.all(4.0),
                                                                      child: Container(
                                                                        width:
                                                                            100.w,
                                                                        height:
                                                                            55.h,
                                                                        decoration: BoxDecoration(
                                                                            color: getAvaliple(index, controller.dateDay2.value, profileController.shippingTimesModel.cities!.shippingTimes!) == false
                                                                                ? Colors.grey
                                                                                : controller.selectedTime.value == profileController.shippingTimesModel.cities!.shippingTimes![index].period
                                                                                    ? AppColors.greenColor
                                                                                    : Colors.white,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            border: Border.all(color: AppColors.greenColor)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            getPeriod(profileController.shippingTimesModel.cities!.shippingTimes![index].period!),
                                                                            style: Style.cairo.copyWith(
                                                                                color: getAvaliple(index, controller.dateDay2.value, profileController.shippingTimesModel.cities!.shippingTimes!) == false
                                                                                    ? Colors.white
                                                                                    : controller.selectedTime.value == profileController.shippingTimesModel.cities!.shippingTimes![index].period
                                                                                        ? Colors.white
                                                                                        : AppColors.greenColor,
                                                                                fontSize: 16.sp,
                                                                                height: 1.4.h),
                                                                          ),
                                                                        ),
                                                                      ))));
                                                            },
                                                          ))))),
                          ],
                        )),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: Text(
                          "العنوان",
                          style: Style.cairo.copyWith(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    padding2,
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: GetBuilder<ProfileController>(
                            id: "profile",
                            builder: (profileController) => profileController
                                        .profileModel.address ==
                                    null
                                ? Container()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                profileController.profileModel
                                                        .address!.street ??
                                                    "",
                                                style: Style.cairog.copyWith(
                                                    fontSize: 18.sp,
                                                    color: AppColors.bluColor),
                                              ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              Text(
                                                profileController.profileModel
                                                        .address!.city! +
                                                    "_" +
                                                    profileController
                                                        .profileModel
                                                        .address!
                                                        .area!,
                                                style: Style.cairog.copyWith(
                                                    fontSize: 14.sp,
                                                    color: AppColors.bluColor),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          OutlinedButton(
                                              onPressed: () {
                                                changeMyAddress();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                  shadowColor: Colors.grey,
                                                  side: BorderSide(
                                                      color: AppColors
                                                          .greenColor)),
                                              child: Text(
                                                "تغير",
                                                style: Style.cairo
                                                    .copyWith(fontSize: 16.sp),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                          )),
                    ),
                    Center(
                      child: TextButton(
                          child: Text(
                            "اضافة عنوان جديد",
                            style: Style.cairo.copyWith(
                                fontSize: 16.sp, color: AppColors.greenColor),
                          ),
                          onPressed: () {
                            Get.toNamed(
                              Routes.AddAddressScreen,
                            );
                          }),
                    ),
                    Container(
                      height: 45.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "طريقة الدفع",
                          style: Style.cairo.copyWith(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    padding2,
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                      width: Get.width,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                  shadowColor: Colors.grey,
                                  side:
                                      BorderSide(color: AppColors.greenColor)),
                              child: Text(
                                "كاش",
                                style: Style.cairo.copyWith(
                                    fontSize: 18.sp,
                                    color: AppColors.greenColor,
                                    height: 1.2),
                              ))),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Container(
                      height: 45.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "ملاحظات",
                          style: Style.cairo.copyWith(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                      width: Get.width,
                      child: FormFieldItem(
                        labelText: "اكتب ملاحظاتك هنا",
                        editingController: controller.notesController,
                        onChange: (v) {},
                        textInputAction: TextInputAction.done,
                        minLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Container(
                      height: 45.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "تفاصيل السعر",
                          style: Style.cairo.copyWith(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    padding2,
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,

                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6.h,
                            ),
                            GetBuilder<ProfileController>(
                              id: "ShippingTimes",
                              builder: (profileController) =>
                                  profileController.delivaryCost == "0.0"
                                      ? Container()
                                      : Row(children: [
                                          Text(
                                            "التوصيل",
                                            style: Style.cairo.copyWith(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Spacer(),
                                          Text(
                                              profileController.delivaryCost +
                                                  " " +
                                                  Constants.currency,
                                              style: Style.cairog.copyWith(
                                                fontSize: 16.sp,
                                              )),
                                        ]),
                            ),
                            Row(
                              children: [
                                Text(
                                  "مجموع المنتجات",
                                  style: Style.cairo.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                Spacer(),
                                Text(
                                    controller.totalPrice.toStringAsFixed(1) +
                                        " " +
                                        Constants.currency,
                                    style: Style.cairog.copyWith(
                                      fontSize: 16.sp,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        )
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 6),
                        child: GetBuilder<ProfileController>(
                          id: "profile",
                          builder: (profileConttroller) {
                            return Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      if (SHelper.sHelper.getToken() == null) {
                                        Get.toNamed(Routes.SignInScreen);
                                      }
                                      if (controller.selectedTime == "" ||
                                          controller.selectedTime == "0") {
                                        BotToast.showText(
                                            text: "يجب اختيار فترة التوصيل",
                                            contentColor: Colors.red);
                                        return;
                                      }
                                      if (controller.profileController
                                              .profileModel.address ==
                                          null) {
                                        BotToast.showText(
                                            text: "يجب اختيار عنوان التوصيل",
                                            contentColor: Colors.red);
                                        return;
                                      }
                                      if (controller.profileController
                                                  .profileModel.address!.city ==
                                              "غير ذلك" ||
                                          controller.profileController
                                                  .profileModel.address!.area ==
                                              "غير ذلك") {
                                        BotToast.showText(
                                            text: "منطقتك ليست متوفرة حاليا",
                                            contentColor: Colors.red);
                                        return;
                                      }
                                      await controller.sendOrder(
                                          profileConttroller
                                              .profileModel.address!.id);
                                    },
                                    child: Container(
                                      height: 65.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.greenColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "تأكيد الطلب",
                                          style: Style.cairo.copyWith(
                                              fontSize: 16.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 65.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GetBuilder<ProfileController>(
                                        id: "ShippingTimes",
                                        builder: (_) {
                                          return Text(
                                            (controller.totalPrice +
                                                        double.parse(
                                                            _.delivaryCost))
                                                    .toStringAsFixed(1)
                                                    .toString() +
                                                " " +
                                                Constants.currency,
                                            style: Style.cairo.copyWith(
                                              fontSize: 16.sp,
                                              color: AppColors.greenColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
