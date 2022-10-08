import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../../utils/valdtion_helper.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/form_field_item.dart';
import '../../../widgets/nav_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../controller/profile_controller.dart';

class ChangePasswordProfileScreen extends GetView<ProfileController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                child: AppBarCustom(
                  isBack: true,
                )),
            body: Container(
              decoration: backgroundImage,
              margin: const EdgeInsets.all(22),
              child: Obx(
                () => Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        "تعديل كلمة المرور",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 20.sp, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 30.h),
                      FormFieldItem(
                        textInputType: TextInputType.text,
                        labelText: 'كلمة المرور الحالية',
                        validator: (value) => ValidationHelper.validationHelper
                            .validatePassword(value),
                        textInputAction: TextInputAction.done,
                        editingController: controller.oldPasswordControlelr,
                        type: false,
                        onChange: (value) {},
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      FormFieldItem(
                        textInputType: TextInputType.text,
                        labelText: 'كلمة المرور الجديدة',
                        validator: (value) => ValidationHelper.validationHelper
                            .validatePassword(value),
                        textInputAction: TextInputAction.done,
                        editingController: controller.passwordControlelr,
                        type: false,
                        onChange: (value) {},
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      FormFieldItem(
                        textInputType: TextInputType.text,
                        labelText: 'تأكيد كلمة المرور',
                        validator: (value) => ValidationHelper.validationHelper
                            .validateConfrmationPassword(
                                value, controller.passwordControlelr.text),
                        textInputAction: TextInputAction.done,
                        editingController: controller.confirmPasswordControlelr,
                        type: false,
                        onChange: (value) {},
                      ),
                      const Spacer(),
                      CustomButton(
                        height: 50.h,
                        width: 219.w,
                        buttonText: "حفط",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            await controller.getChangePasswordProfile();
                          }
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
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
