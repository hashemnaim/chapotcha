import 'package:capotcha/modules/Auth/view/components/form_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/valdtion_helper.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg.dart';

import '../../../widgets/form_field_item.dart';
import '../../../config/theme/light_theme_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/animate_do.dart';

import '../controller/auth_controller.dart';
import 'components/form_password.dart';

class SignUpScreen extends GetView<AuthController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Container(
        height: Get.height,
        decoration: backgroundImage,
        child: SingleChildScrollView(
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
                          Get.offAndToNamed(Routes.MAIN);
                        },
                        child: CustomSvgImage(
                          "back",
                          height: 60.h,
                          width: 60.w,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: FadeInRight(
                        duration: Duration(milliseconds: 2000),
                        child: Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/im3.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text("أنشئ حساب",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.2.h,
                            )),
                    SizedBox(height: 18.h),
                    Text(
                      "هيا ننشئ حساب معاً",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: LightThemeColors.greyTextColor,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 12.h),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Text(
                            "الاسم بالكامل",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontSize: 16.sp,
                                    ),
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            child: FormFieldItem(
                              textInputType: TextInputType.text,
                              labelText: "ادخل الاسم بالكامل",
                              validator: (value) => ValidationHelper
                                  .validationHelper
                                  .validateUserName(value),
                              onChange: (v) {},
                              backgroundColor: Colors.grey[250],
                              textInputAction: TextInputAction.next,
                              editingController: controller.nameController,
                              type: false,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          FormPhone(
                              // <== This is the call to the snippet
                              phoneController: controller.mobileController
                              // codeCountry: (value) {
                              //   controller.codeCountry.value = value;
                              // },
                              ),
                          SizedBox(height: 18.h),
                          Obx(() => FormPassword(
                                // <== This is the call to the snippet
                                passwordController:
                                    controller.passwordController,
                                obscure: (value) {
                                  controller.obscureText.value = value;
                                },
                                isobscure: controller.obscureText.value,
                              )),
                          SizedBox(height: 30.h),
                          CustomButton(
                              buttonText: "التسجيل",
                              onPressed: () => controller.singUp(formKey)),
                          SizedBox(height: 18.h),
                          InkWell(
                            onTap: () {
                              Get.offNamed(Routes.SignInScreen);
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  text: ' لديك حساب بالفعل؟ ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: LightThemeColors.greyTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.sp),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'تسجيل الدخول',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
