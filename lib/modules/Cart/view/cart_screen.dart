import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/shared_preferences_helpar.dart';
import 'package:capotcha/widgets/custom_button.dart';
import 'package:capotcha/utils/constants.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_svg.dart';
import '../../../routes/app_pages.dart';
import '../controller/cart_controller.dart';
import 'checkout_screen.dart';
import 'components/item_cart.dart';

class Cart1Screen extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
        ),
      ),
      child: GetBuilder<CartController>(
          id: "cart",
          builder: (controller) =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (controller.cartList.isEmpty)
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
                              itemCount: controller.cartList.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                    key: UniqueKey(),
                                    onDismissed:
                                        (DismissDirection direction) async {
                                      direction = DismissDirection.endToStart;
                                      controller.deleteProductFromCart(
                                          controller.cartList[index]);
                                    },
                                    background: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 26,
                                                width: 26,
                                                child: CustomSvgImage(
                                                  "delete",
                                                  isColor: true,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: ItemCart(index: index));
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        addNew(),
                      ],
                    ),
                  ),
                // Spacer(),

                Center(
                  child: Column(
                    children: [
                      controller.cartList.isEmpty
                          ? SizedBox.shrink()
                          : Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "الإجمالي",
                                        style: Style.cairo.copyWith(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Text(
                                        controller.totalPrice
                                                .toStringAsFixed(1)
                                                .toString() +
                                            " " +
                                            Constants.currency,
                                        style: Style.cairo.copyWith(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                CustomButton(
                                    buttonText: "إستمرار",
                                    onPressed: () {
                                      if (SHelper.sHelper.getToken() == null) {
                                        Get.toNamed(Routes.SignInScreen);
                                      } else {
                                        if (controller.totalPrice < 50) {
                                          BotToast.showText(
                                              text:
                                                  "يجب أن يكون الطلب أكبر من 50 جنيه",
                                              contentColor: Colors.red);
                                        } else {
                                          Get.to(() => CheckoutScreen());
                                        }
                                      }
                                    }),
                                SizedBox(height: 40.h)
                              ],
                            ),
                    ],
                  ),
                ),
              ])),
    );
  }

  InkWell addNew() {
    return InkWell(
      onTap: () async {
        Get.toNamed(Routes.ProductScreen, arguments: 0);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "إضافة عنصر جديد ",
            style: Style.cairo.copyWith(
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
    );
  }
}
// }
