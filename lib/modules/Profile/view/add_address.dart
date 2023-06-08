import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/widgets/custom_button.dart';
import 'package:capotcha/utils/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/location_helper.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/my_widgets_animator.dart';
import '../../../widgets/nav_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../../utils/constants.dart';
import '../../../utils/shimmer_helper.dart';
import '../../Map/controller/address_controller.dart';
import '../../Map/controller/map_controller.dart';
import '../../Map/model/address_model.dart';
import '../../Map/view/enter_location_screen.dart';

// ignore: must_be_immutable
class AddAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBarCustom(isBack: true, title: "إضافة عنوان")),
        body: Container(
            decoration: backgroundImage,
            child: Container(
                decoration: backgroundImage,
                child: GetBuilder<AddressController>(
                    id: "myAddress",
                    builder: (controller) {
                      return Column(children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(children: [
                          MyWidgetsAnimator(
                              apiCallStatus: controller.addressStatus,
                              loadingWidget: () => ShimmerHelper.loadingHome(),
                              successWidget: (() => controller
                                          .addressModel.data!.length ==
                                      0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          SizedBox(height: 80.h),
                                          Bounce(
                                              child: Icon(
                                                  Icons.location_off_outlined,
                                                  color: AppColors.greenColor,
                                                  size: 200.h)),
                                          SizedBox(height: 10.h),
                                          Text(" لا يوجد عناوين مضافة",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontSize: 20.sp,
                                                      color:
                                                          AppColors.bluColor))
                                        ])
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontSize: 16.sp,
                                                      color:
                                                          AppColors.bluColor),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Divider()),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              itemCount: controller
                                                  .addressModel.data!.length,
                                              itemBuilder: (context, index) {
                                                return Column(children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: ListTile(
                                                          title: Text(controller.addressModel.data![index].city! + "_" + controller.addressModel.data![index].area!,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          18.sp,
                                                                      color: controller.addressModel.data![index].isDefault == 1
                                                                          ? AppColors
                                                                              .greenColor
                                                                          : AppColors
                                                                              .bluColor)),
                                                          subtitle: Text(
                                                            " البناية " +
                                                                controller
                                                                    .addressModel
                                                                    .data![
                                                                        index]
                                                                    .building! +
                                                                " - " +
                                                                controller
                                                                    .addressModel
                                                                    .data![
                                                                        index]
                                                                    .apartment!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleLarge!
                                                                .copyWith(
                                                                    fontSize:
                                                                        14.sp,
                                                                    height: 2,
                                                                    color: controller.addressModel.data![index].isDefault ==
                                                                            1
                                                                        ? AppColors
                                                                            .greenColor
                                                                        : AppColors
                                                                            .bluColor),
                                                          ),
                                                          onTap:
                                                              controller.addressModel.data![index].isDefault ==
                                                                      1
                                                                  ? null
                                                                  : () {
                                                                      controller.editAddrees(
                                                                          1,
                                                                          controller
                                                                              .addressModel
                                                                              .data![index]
                                                                              .id);
                                                                    },
                                                          minLeadingWidth: 1,
                                                          leading: Icon(Icons.location_on_outlined,
                                                              size: 29,
                                                              color: controller
                                                                          .addressModel
                                                                          .data![index]
                                                                          .isDefault ==
                                                                      1
                                                                  ? AppColors.greenColor
                                                                  : AppColors.bluColor),
                                                          trailing: IconButton(
                                                              icon: Icon(Icons.delete_outline_outlined, size: 24, color: AppColors.bluColor),
                                                              onPressed: () {
                                                                controller.deleteAddrees(
                                                                    controller
                                                                        .addressModel
                                                                        .data![
                                                                            index]
                                                                        .id);
                                                              })))
                                                ]);
                                              })
                                        ]))))
                        ]),
                        Spacer(),
                        CustomButton(
                            buttonText: "أضف عنوان جديد",
                            icon: Icons.add_location,
                            onPressed: () async {
                              LocationHelper.checkLocationPermission(() async {
                                BotToast.showLoading();
                                DataAddress addressLocation =
                                    await Get.find<MapController>()
                                        .getCurrentLocation(true);
                                BotToast.closeAllLoading();
                                Get.to(() => EnterLocationScreen(
                                    address: DataAddress(
                                        lat: addressLocation.lat,
                                        lng: addressLocation.lng,
                                        area: addressLocation.area),
                                    fromApp: false));
                              });
                            }),
                        SizedBox(height: 40.h)
                      ]);
                    }))),
        floatingActionButton: NavBarFloatCustom(isHome: false),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBottomBarCustom(
          isHome: false,
        ));
  }
}
