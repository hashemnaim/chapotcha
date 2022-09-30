import 'package:capotcha/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/form_field_item.dart';
import '../../../utils/valdtion_helper.dart';
import '../../../widgets/custom_svg.dart';
import '../controller/auth_controller.dart';

class ForgetPasswordScreen extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Stack(
              children: [
                CustomPngImage(
                  "login-Background",
                  width: Get.width,
                  fit: BoxFit.contain,
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Form(
                        key: _formKey,
                        child: SizedBox(
                          height: 65.h,
                          child: FormFieldItem(
                            textInputType: TextInputType.emailAddress,
                            labelText: "ادخل البريد الكتروني",
                            validator: (value) => ValidationHelper
                                .validationHelper
                                .validateEmail(value),
                            onChange: (v) {},
                            backgroundColor: Colors.grey[250],
                            textInputAction: TextInputAction.send,
                            editingController: controller.emailController,
                            type: false,
                          ),
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
                      buttonText: "ارسال",
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
