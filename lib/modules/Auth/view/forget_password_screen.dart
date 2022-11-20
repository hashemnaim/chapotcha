import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../../widgets/form_field_item.dart';
import '../../../utils/valdtion_helper.dart';
import '../../../widgets/custom_svg.dart';
import '../controller/auth_controller.dart';

class ForgetPasswordScreen extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: backgroundImage,
        child: Column(
          children: [
            Stack(
              children: [
                CustomPngImage(
                  "login-Background",
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 20.w,
                  top: 50.h,
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CustomSvgImage(
                        "back",
                        height: 60.h,
                        width: 60.w,
                      )),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "تحقق من رقم الهاتف",
                      style: TextStyle(
                        color: AppColors.greenColor,
                        fontFamily: 'Cairo',
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Form(
                        key: _formKey,
                        child: FormFieldItem(
                          textInputType: TextInputType.number,
                          labelText: "ادخل رقم الهاتف",
                          validator: (value) => ValidationHelper
                              .validationHelper
                              .validateMobile(value),
                          onChange: (v) {},
                          backgroundColor: Colors.grey[550],
                          textInputAction: TextInputAction.send,
                          editingController: controller.mobileController,
                          type: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    CustomButton(
                      onPressed: () async {
                        controller.resentPassword(_formKey);
                      },
                      buttonText: "تحقق",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
