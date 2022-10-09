import 'package:capotcha/widgets/custom_button.dart';
import 'package:capotcha/utils/animate_do.dart';
import 'package:capotcha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/my_widgets_animator.dart';
import '../../../widgets/nav_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';
import '../../../utils/shimmer_helper.dart';
import '../../Map/controller/address_controller.dart';

// ignore: must_be_immutable
class AddAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBarCustom(
              isBack: true,
              title: "اضافة عنوان",
            )),
        body: Container(
          decoration: backgroundImage,
          child: Container(
            decoration: backgroundImage,
            child: GetBuilder<AddressController>(
                id: "myAddress",
                builder: (controller) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          MyWidgetsAnimator(
                            apiCallStatus: controller.addressStatus,
                            loadingWidget: () => ShimmerHelper.loadingHome(),
                            successWidget: (() => controller
                                        .addressModel.data!.length ==
                                    0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 80.h,
                                      ),
                                      Bounce(
                                        child: Icon(
                                          Icons.location_off_outlined,
                                          color: AppColors.greenColor,
                                          size: 200.h,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        " لا يوجد عناوين مضافة",
                                        style: Style.cairog.copyWith(
                                            fontSize: 20.sp,
                                            color: AppColors.bluColor),
                                      ),
                                    ],
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            "العنوانين المضافة",
                                            style: Style.cairog.copyWith(
                                                fontSize: 16.sp,
                                                color: AppColors.bluColor),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Divider(),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: controller
                                                .addressModel.data!.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: ListTile(
                                                        title: Text(
                                                          controller
                                                                  .addressModel
                                                                  .data![index]
                                                                  .street ??
                                                              "",
                                                          style: Style.cairog.copyWith(
                                                              fontSize: 18.sp,
                                                              color: controller
                                                                          .addressModel
                                                                          .data![
                                                                              index]
                                                                          .isDefault ==
                                                                      1
                                                                  ? AppColors
                                                                      .greenColor
                                                                  : AppColors
                                                                      .bluColor),
                                                        ),
                                                        subtitle: Text(
                                                          controller
                                                                  .addressModel
                                                                  .data![index]
                                                                  .city! +
                                                              "_" +
                                                              controller
                                                                  .addressModel
                                                                  .data![index]
                                                                  .area!,
                                                          style: Style.cairog.copyWith(
                                                              fontSize: 14.sp,
                                                              height: 2,
                                                              color: controller
                                                                          .addressModel
                                                                          .data![
                                                                              index]
                                                                          .isDefault ==
                                                                      1
                                                                  ? AppColors
                                                                      .greenColor
                                                                  : AppColors
                                                                      .bluColor),
                                                        ),
                                                        onTap: controller
                                                                    .addressModel
                                                                    .data![
                                                                        index]
                                                                    .isDefault ==
                                                                1
                                                            ? null
                                                            : () {
                                                                controller.editAddrees(
                                                                    1,
                                                                    controller
                                                                        .addressModel
                                                                        .data![
                                                                            index]
                                                                        .id);
                                                              },
                                                        minLeadingWidth: 1,
                                                        leading: Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            size: 29,
                                                            color: controller
                                                                        .addressModel
                                                                        .data![
                                                                            index]
                                                                        .isDefault ==
                                                                    1
                                                                ? AppColors
                                                                    .greenColor
                                                                : AppColors
                                                                    .bluColor),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                              Icons
                                                                  .delete_outline_outlined,
                                                              size: 24,
                                                              color: AppColors
                                                                  .bluColor),
                                                          onPressed: () {
                                                            controller.deleteAddrees(
                                                                controller
                                                                    .addressModel
                                                                    .data![
                                                                        index]
                                                                    .id);
                                                          },
                                                        )),
                                                  ),
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.symmetric(
                                                  //           horizontal: 20),
                                                  //   child: Divider(),
                                                  // )
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  )),
                          ),
                        ],
                      ),
                      Spacer(),
                      CustomButton(
                        buttonText: "أضف عنوان جديد",
                        icon: Icons.add_location,
                        onPressed: () {
                          Get.toNamed(Routes.EnterLocationScreen);
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  );
                }),
          ),
        ),
        // floatingActionButton: SizedBox(
        //   height: 110.h,
        //   width: 110.h,
        //   child: IconButton(
        //     icon: Column(
        //       children: [
        //         Icon(
        //           Icons.add_circle,
        //           color: AppColors.greenColor,
        //           size: 55,
        //         ),
        //         SizedBox(
        //           height: 5.h,
        //         ),
        //         Text(
        //           "أضف عنوان",
        //           style: Style.cairog
        //               .copyWith(fontSize: 15.sp, color: AppColors.bluColor),
        //         ),
        //       ],
        //     ),
        //     onPressed: () {

        //     },
        //   ),
        // ),

        floatingActionButton: NavBarFloatCustom(
          isHome: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBottomBarCustom(
          isHome: false,
        ));
  }
}
