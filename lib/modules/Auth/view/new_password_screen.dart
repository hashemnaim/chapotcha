import 'package:capotcha/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/form_field_item.dart';
import '../../../../utils/valdtion_helper.dart';
import '../../../../widgets/custom_svg.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../controller/auth_controller.dart';

class NewPasswordScreen extends GetView<AuthController> {
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
                      "كلمة المرور الجديدة",
                      style: TextStyle(
                        color: AppColors.greenColor,
                        fontFamily: 'Cairo',
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Form(
                        key: _formKey,
                        child: SizedBox(
                          height: 65.h,
                          child: FormFieldItem(
                            textInputType: TextInputType.visiblePassword,
                            labelText: "ادخل كلمة المرور الجديدة",
                            validator: (value) => ValidationHelper
                                .validationHelper
                                .validatePassword(value),
                            onChange: (v) {},
                            backgroundColor: Colors.grey[250],
                            textInputAction: TextInputAction.send,
                            editingController: controller.newPasswordController,
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
                        controller.newPassword(_formKey);
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
