import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/constants.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/utils/shared_preferences_helpar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../utils/keyboard.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/form_field_item.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/method_helpar.dart';
import '../../Profile/controller/profile_controller.dart';
import '../controller/cart_controller.dart';
import 'components/address_components.dart';
import 'components/payment_components.dart';

class CheckoutScreen extends GetView<CartController> {
  CheckoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var padding2 = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Divider(height: 1, color: AppColors.gryText[400]),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: AppBarCustom(isBack: true, title: "إجراء الطلب")),
      body: Container(
        decoration: backgroundImage,
        child: Container(
            decoration: backgroundImage,
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 30.h,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text("إختر  موعد التوصيل",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontSize: 14.sp)))),
                        SizedBox(height: 4.h),
                        // padding2,
                        Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4.h),
                                  dateOrder(),
                                  SizedBox(height: 4.h),
                                  controller.isload.value == true
                                      ? Center(
                                          child: Container(
                                            width: 200.w,
                                            height: 50.h,
                                            child: SpinKitThreeBounce(
                                              color: AppColors.greenColor,
                                              size: 30.0,
                                            ),
                                          ),
                                        )
                                      : profileController
                                                  .shippingTimesModel.cities !=
                                              null
                                          ? ShippingTimes()
                                          : Center(
                                              child: Container(
                                                  child: Text(
                                                      "يجب إضافة عنوان لإظهار الفترات المتاحة",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.red))))
                                ]))
                      ]),
                  SizedBox(height: 12.h),
                  padding2,
                  AddressComponets(padding2: padding2),
                  SizedBox(height: 4.h),
                  PaymentComponents(padding2: padding2),
                  padding2,
                  Container(
                      height: 50.h,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text("ملاحظات",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 14.sp)))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: Get.width,
                          child: FormFieldItem(
                              labelText: "اكتب ملاحظاتك هنا",
                              editingController: controller.notesController,
                              onChange: (v) {},
                              textInputAction: TextInputAction.done,
                              minLines: 1))),
                  Obx(() => Row(
                        children: [
                          Expanded(
                              child: Obx(() => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: controller.cartApiModel.value.data!
                                              .coupon_id ==
                                          null
                                      ? Container()
                                      : controller.cartApiModel.value.data!
                                                  .coupon_id!
                                                  .toString() !=
                                              "0"
                                          ? FormFieldItem(
                                              textInputType: TextInputType.text,
                                              labelText: "كود الخصم",
                                              textInputAction:
                                                  TextInputAction.done,
                                              editingController:
                                                  TextEditingController.fromValue(
                                                      TextEditingValue(
                                                          text: controller
                                                              .cartApiModel
                                                              .value
                                                              .data!
                                                              .coupon_code!)),
                                              type: true,
                                              validator: (v) {},
                                              onChange: (v) {})
                                          : FormFieldItem(
                                              textInputType: TextInputType.text,
                                              labelText: "كود الخصم",
                                              textInputAction:
                                                  TextInputAction.done,
                                              editingController: controller
                                                  .promocCodeController!.value,
                                              type: false,
                                              validator: (v) {},
                                              onChange: (v) {})))),
                          controller.cartApiModel.value.data!.coupon_id == null
                              ? Container()
                              : CustomButton(
                                  width: 80.w,
                                  buttonText: controller.cartApiModel.value
                                              .data!.coupon_id!
                                              .toString() !=
                                          "0"
                                      ? "إلغاء التفعيل"
                                      : "تفعيل",
                                  color: controller.cartApiModel.value.data!
                                              .coupon_id!
                                              .toString() !=
                                          "0"
                                      ? Colors.red
                                      : AppColors.greenColor,
                                  onPressed: () async {
                                    KeyboardUtil.hideKeyboard(context);
                                    await controller.applyCoupon(controller
                                                .cartApiModel
                                                .value
                                                .data!
                                                .coupon_id!
                                                .toString() !=
                                            "0"
                                        ? controller.cartApiModel.value.data!
                                            .coupon_code
                                        : controller
                                            .promocCodeController!.value.text);
                                  }),
                          SizedBox(width: 8.w)
                        ],
                      )),
                  SizedBox(height: 6.h),
                  Container(
                      height: 40.h,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text("تفاصيل السعر",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 14.sp)))),
                  padding2,
//  Spacer(),
                  Obx(
                    () => Container(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 6.h),
                                  Row(
                                    children: [
                                      Text(
                                        "مجموع المنتجات",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      Spacer(),
                                      Text(
                                          controller.cartApiModel.value.data!
                                                  .subTotal!
                                                  .toStringAsFixed(1) +
                                              " " +
                                              Constants.currency,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontSize: 14.sp)),
                                    ],
                                  ),
                                  controller.cartApiModel.value.data!
                                              .coupon_id ==
                                          null
                                      ? Container()
                                      : controller.cartApiModel.value.data!
                                                  .couponDiscount !=
                                              0
                                          ? Row(
                                              children: [
                                                Text(
                                                  "خصم الكوبون",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                                Spacer(),
                                                Text(
                                                    controller
                                                            .cartApiModel
                                                            .value
                                                            .data!
                                                            .couponDiscount!
                                                            .toStringAsFixed(
                                                                1) +
                                                        " " +
                                                        Constants.currency,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                            fontSize: 14.sp)),
                                              ],
                                            )
                                          : SizedBox.shrink(),
                                  controller.cartApiModel.value.data!
                                              .discount_price_cart !=
                                          0
                                      ? Row(
                                          children: [
                                            Text("الخصم",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                            Spacer(),
                                            Text(
                                                controller
                                                        .cartApiModel
                                                        .value
                                                        .data!
                                                        .discount_price_cart!
                                                        .toStringAsFixed(1) +
                                                    " " +
                                                    Constants.currency,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontSize: 14.sp,
                                                    )),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  GetBuilder<ProfileController>(
                                      id: "ShippingTimes",
                                      builder: (profileController) =>
                                          profileController.shippingTimesModel
                                                      .cities ==
                                                  null
                                              ? Container()
                                              : profileController
                                                          .shippingTimesModel
                                                          .cities!
                                                          .shippingCost ==
                                                      "0.0"
                                                  ? Container()
                                                  : Row(children: [
                                                      Text(
                                                        "التوصيل",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                          profileController
                                                                  .shippingTimesModel
                                                                  .cities!
                                                                  .shippingCost! +
                                                              " " +
                                                              Constants
                                                                  .currency,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleLarge!
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.sp))
                                                    ]))
                                ]))),
                  ),
                  SizedBox(height: 30.h),
                  // Spacer(),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                      child: GetBuilder<ProfileController>(
                          id: "profile",
                          builder: (profileController) {
                            return profileController
                                        .shippingTimesModel.cities ==
                                    null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                            "يجب إضافة عنوان لإكمال الطلب",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontSize: 16.sp,
                                                    color: Colors.red))))
                                : Row(children: [
                                    Expanded(
                                        child: InkWell(
                                            onTap: () async {
                                              if (SHelper.sHelper.getToken() ==
                                                  null) {
                                                Get.toNamed(
                                                    Routes.SignInScreen);
                                              }
                                              if (controller.selectedTime ==
                                                      "" ||
                                                  controller.selectedTime ==
                                                      "0") {
                                                BotToast.showText(
                                                    text:
                                                        "يجب اختيار فترة التوصيل",
                                                    contentColor: Colors.red);
                                                return;
                                              }
                                              if (controller.profileController
                                                      .profileModel.address ==
                                                  null) {
                                                BotToast.showText(
                                                    text:
                                                        "يجب اختيار عنوان التوصيل",
                                                    contentColor: Colors.red);
                                                return;
                                              }
                                              if (controller
                                                      .profileController
                                                      .profileModel
                                                      .address!
                                                      .area ==
                                                  "غير ذلك") {
                                                BotToast.showText(
                                                    text:
                                                        "منطقتك ليست متوفرة حاليا",
                                                    contentColor: Colors.red);
                                                return;
                                              }
                                              await controller.sendOrder(
                                                  profileController
                                                      .profileModel.address!.id,
                                                  controller.cartApiModel.value
                                                              .data!.coupon_id!
                                                              .toString() !=
                                                          "0"
                                                      ? controller
                                                          .cartApiModel
                                                          .value
                                                          .data!
                                                          .coupon_code!
                                                      : "0");
                                            },
                                            child: Container(
                                                height: 65.h,
                                                decoration: BoxDecoration(
                                                  color: AppColors.greenColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6),
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Text("تأكيد الطلب",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .white)))))),
                                    Container(
                                        height: 65.h,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                bottomLeft:
                                                    Radius.circular(6))),
                                        child: Center(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GetBuilder<
                                                        ProfileController>(
                                                    id: "ShippingTimes",
                                                    builder: (_) {
                                                      return _
                                                                  .shippingTimesModel
                                                                  .cities!
                                                                  .shippingCost ==
                                                              ""
                                                          ? Text("المنطقة غير متوفرة حاليا",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .copyWith())
                                                          : Obx(() => Text(
                                                              (controller.cartApiModel.value.data!.total! + double.parse(_.shippingTimesModel.cities!.shippingCost!)).toStringAsFixed(1) +
                                                                  " " +
                                                                  Constants
                                                                      .currency,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16.sp,
                                                                      color: AppColors.greenColor)));
                                                    }))))
                                  ]);
                          }))
                ])))),
      ),
      // floatingActionButton: NavBarFloatCustom(isHome: false),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: NavBottomBarCustom(isHome: false),
    );
  }

  SingleChildScrollView dateOrder() {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(
                3,
                (index) => InkWell(
                    onTap: () async {
                      controller.selectDay(index);
                      controller.dateDay2.value = getDay1(index);
                      controller.selectTime("0");
                      controller.getCountOrder(
                          controller.dateDay2.value, index);
                    },
                    child: GetBuilder<CartController>(
                        id: "day",
                        builder: (controller) => Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                                width: 105.w,
                                height: 55.h,
                                decoration: BoxDecoration(
                                    color: controller.selectedDay == index
                                        ? AppColors.greenColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: AppColors.greenColor)),
                                child: Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Text(
                                        controller.days[DateTime.now()
                                                    .add(Duration(days: index))
                                                    .weekday -
                                                1]
                                            .toString(),
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: controller.selectedDay ==
                                                        index
                                                    ? Colors.white
                                                    : AppColors.gryText,
                                                fontSize: 15.sp,
                                                height: 1.4.h),
                                      ),
                                      Text(getDate(index),
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color:
                                                      controller.selectedDay ==
                                                              index
                                                          ? Colors.white
                                                          : AppColors.gryText,
                                                  fontSize: 16.sp,
                                                  height: 1.4.h))
                                    ])))))))));
  }

  Widget ShippingTimes() {
    return Container(
        height: 60.h,
        child: GetBuilder<ProfileController>(
            id: "ShippingTimes",
            builder: (profileController) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                scrollDirection: Axis.horizontal,
                child: profileController.shippingTimesModel.cities == null
                    ? Container()
                    : Row(
                        children: List.generate(
                        profileController
                            .shippingTimesModel.cities!.shippingTimes!.length,
                        (index) {
                          return Obx(() => controller.profileController.listCount.length ==
                                  0
                              ? Container()
                              : InkWell(
                                  onTap: getAvaliple(
                                              index,
                                              profileController
                                                  .shippingTimesModel
                                                  .cities!
                                                  .shippingTimes![index]
                                                  .before_close!,
                                              controller
                                                  .profileController.listCount,
                                              controller.dateDay2.value,
                                              profileController
                                                  .shippingTimesModel
                                                  .cities!
                                                  .shippingTimes!) ==
                                          false
                                      ? null
                                      : () {
                                          controller.selectTime(
                                              profileController
                                                  .shippingTimesModel
                                                  .cities!
                                                  .shippingTimes![index]
                                                  .period!);
                                        },
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                          width: 80.w,
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                              color: getAvaliple(
                                                          index,
                                                          profileController
                                                              .shippingTimesModel
                                                              .cities!
                                                              .shippingTimes![index]
                                                              .before_close!,
                                                          controller.profileController.listCount,
                                                          controller.dateDay2.value,
                                                          profileController.shippingTimesModel.cities!.shippingTimes!) ==
                                                      false
                                                  ? Colors.grey
                                                  : controller.selectedTime.value == profileController.shippingTimesModel.cities!.shippingTimes![index].period
                                                      ? AppColors.greenColor
                                                      : Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: AppColors.greenColor)),
                                          child: Center(
                                              child: Text(getPeriod(profileController.shippingTimesModel.cities!.shippingTimes![index].period!),
                                                  style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
                                                      color: getAvaliple(index, profileController.shippingTimesModel.cities!.shippingTimes![index].before_close!, controller.profileController.listCount, controller.dateDay2.value, profileController.shippingTimesModel.cities!.shippingTimes!) == false
                                                          ? Colors.white
                                                          : controller.selectedTime.value == profileController.shippingTimesModel.cities!.shippingTimes![index].period
                                                              ? Colors.white
                                                              : AppColors.greenColor,
                                                      fontSize: 16.sp,
                                                      height: 1.4.h)))))));
                        },
                      )))));
  }
}
