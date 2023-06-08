import 'package:capotcha/modules/Auth/view/components/form_password.dart';
import 'package:capotcha/modules/Auth/view/components/form_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import '../controller/auth_controller.dart';
import 'forget_password_screen.dart';
import '../../../widgets/custom_button.dart';
import '../../../config/theme/light_theme_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/animate_do.dart';

class SignInScreen extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: FadeInRight(
                        duration: Duration(milliseconds: 2000),
                        child: Container(
                          height: 80.h,
                          width: 220.w,
                          padding: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/im3.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FormPhone(
                              phoneController: controller.mobileController,
                            ),
                            SizedBox(height: 16.h),
                            Obx(() => FormPassword(
                                  passwordController:
                                      controller.passwordController,
                                  obscure: (value) {
                                    controller.obscureText.value = value;
                                  },
                                  isobscure: controller.obscureText.value,
                                )),
                            SizedBox(height: 14.h),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ForgetPasswordScreen());
                              },
                              child: Text(
                                "هل نسيت كلمة المرور؟",
                                style: TextStyle(
                                    color: Color(0xff658199),
                                    fontFamily: 'Cairo',
                                    fontSize: 14.0.sp),
                              ),
                            ),
                            SizedBox(height: 50.h),
                            CustomButton(
                                buttonText: "الدخول",
                                onPressed: () => controller.singIn(_formKey)),
                            SizedBox(height: 20.h),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.SignUpScreen);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'ليس لديك حساب؟ ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color:
                                                LightThemeColors.greyTextColor,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14.sp),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'انشئ حساب',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp,
                                                  color: LightThemeColors
                                                      .primaryColor))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
