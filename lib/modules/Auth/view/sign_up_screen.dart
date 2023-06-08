import 'package:capotcha/modules/Auth/view/components/form_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/valdtion_helper.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';

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
          appBar: AppBar(),
          body: Container(
            decoration: backgroundImage,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: FadeInRight(
                        duration: Duration(seconds: 2),
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            )),
                    SizedBox(height: 18.h),
                    Text(
                      "هيا ننشئ حساب معاً",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
                                      .titleLarge!
                                      .copyWith(
                                          color: LightThemeColors.greyTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.sp),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'تسجيل الدخول',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
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
            ),
          )),
    );
  }
}
