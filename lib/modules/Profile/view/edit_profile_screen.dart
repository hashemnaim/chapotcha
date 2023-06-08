import 'package:capotcha/modules/Profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/keyboard.dart';

import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/form_field_item.dart';
import '../../../widgets/nav_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../../config/theme/light_theme_colors.dart';
import '../../../utils/animate_do.dart';
import '../../../utils/constants.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                child: AppBarCustom(
                  isBack: true,
                  title: "تعديل البيانات الشخصية",
                )),
            body: Container(
              decoration: backgroundImage,
              margin: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: FadeInRight(
                          duration: Duration(milliseconds: 2000),
                          child: Container(
                            height: 80,
                            width: 220,
                            padding: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/im3.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        controller.profileModel.user!.name ?? "",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            controller.edit.value = !controller.edit.value;
                            // controller.changeEditStatus();
                          },
                          child: Text(
                            "تعديل",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: controller.edit.value != false
                                        ? LightThemeColors.primaryColor
                                        : LightThemeColors.greyTextColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      FormFieldItem(
                        textInputType: TextInputType.text,
                        labelText: 'الاسم بالكامل',
                        obscureText: false,
                        validator: (v) {},
                        textInputAction: TextInputAction.done,
                        editingController:
                            TextEditingController.fromValue(TextEditingValue(
                          text: controller.profileModel.user!.name!,
                        )),
                        type: controller.edit.value,
                        onChange: (v) {
                          controller.profileModel.user!.name = v;
                        },
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      FormFieldItem(
                        textInputType: TextInputType.number,
                        labelText: 'رقم الهاتف',
                        // obscureText: false,
                        validator: (v) {},
                        textInputAction: TextInputAction.done,
                        editingController:
                            TextEditingController.fromValue(TextEditingValue(
                          text: controller.profileModel.user!.mobile!,
                        )),
                        // type: true,
                        onChange: (v) {
                          controller.profileModel.user!.mobile = v;
                        },
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      FormFieldItem(
                        textInputType: TextInputType.emailAddress,
                        labelText: 'البريد الالكتروني',
                        obscureText: false,
                        validator: (v) {},
                        // ValidationHelper.validationHelper.validateEmail(v!),
                        textInputAction: TextInputAction.done,
                        editingController:
                            TextEditingController.fromValue(TextEditingValue(
                          text: controller.profileModel.user!.email ?? "",
                        )),
                        type: controller.edit.value,
                        onChange: (v) {
                          controller.profileModel.user!.email = v;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      // if (controller.edit.value == true)
                      //   const SizedBox.shrink()
                      // else
                      InkWell(
                        onTap: () async {
                          Get.defaultDialog(
                              title: "هل تريد حدف الحساب بالفعل؟",
                              middleText: "علما انه سيتم حدف الحساب بشكل نهائي",
                              textConfirm: "نعم",
                              textCancel: "لا",
                              titleStyle: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.red),
                              middleTextStyle: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.black),
                              confirmTextColor: Colors.white,
                              onConfirm: () async {
                                await controller.removeUser();
                              },
                              onCancel: () {
                                Get.back();
                              });
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "حدف الحساب",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.red, fontSize: 18.sp),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                      if (controller.edit.value == false)
                        CustomButton(
                          height: 50.h,
                          width: 219.w,
                          buttonText: "حفط",
                          onPressed: () async {
                            // if (formKey.currentState.validate()) {
                            //   formKey.currentState.save();
                            KeyboardUtil.hideKeyboard(context);

                            controller.edit.value = true;

                            await controller.getUpdateProfile();
                            // }
                          },
                        )
                      else
                        const SizedBox.shrink(),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: NavBarFloatCustom(
              isHome: false,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: NavBottomBarCustom(
              isHome: false,
            )));
  }
}
