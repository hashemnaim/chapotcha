import 'package:capotcha/modules/Profile/controller/profile_controller.dart';
import 'package:capotcha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/nav_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../../utils/animate_do.dart';
import '../../../utils/constants.dart';
import '../../../utils/keyboard.dart';

// ignore: must_be_immutable
class SupportScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBarCustom(
              isBack: true,
              title: "الدعم الفني",
            )),
        body: Container(
          decoration: backgroundImage,
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40.h),
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
                  SizedBox(height: 40.h),
                  GetBuilder<ProfileController>(
                    id: "support",
                    builder: (_) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                                textAlign: TextAlign.right,
                                minLines: 2,
                                maxLines: 5,
                                controller: _.titleController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "عنوان الموضوع",
                                    hintStyle: Style.cairo,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                                textAlign: TextAlign.right,
                                minLines: 7,
                                maxLines: 8,
                                controller: _.bodyController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: " وصف المشكلة",
                                    hintStyle: Style.cairo,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 60.h),
                  CustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        KeyboardUtil.hideKeyboard(context);
                        await controller.sendSupport();
                      }
                    },
                    buttonText: 'ارسال',
                  ),
                ],
              )),
        ),
        floatingActionButton: NavBarFloatCustom(
          isHome: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBottomBarCustom(
          isHome: false,
        ));
  }
}
