import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/widgets/form_field_item.dart';
import 'package:capotcha/modules/Map/controller/address_controller.dart';
import 'package:capotcha/modules/Profile/controller/profile_controller.dart';
import 'package:capotcha/utils/animate_do.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/custom_svg.dart';
import '../../../utils/keyboard.dart';
import '../../../utils/valdtion_helper.dart';
import '../controller/map_controller.dart';

class EnterLocationScreen extends StatefulWidget {
  @override
  State<EnterLocationScreen> createState() => _EnterLocationPageState();
}

class _EnterLocationPageState extends State<EnterLocationScreen> {
  final Completer<GoogleMapController> controllerMap = Completer();

  MapController mapController = Get.find();
  AddressController serviceLoctionController = Get.find();
  ProfileController profileController = Get.find();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getAddressAndMoveCamera();
  }

  getAddressAndMoveCamera() async {
    mapController.getLocation(await controllerMap.future);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(300.h),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 270,
                    child: GetBuilder<MapController>(
                      init: mapController,
                      id: "gps",
                      builder: (controller) => GoogleMap(
                        myLocationEnabled: true,
                        onCameraMove: (position) {
                          mapController.setNewLatLong(position.target.latitude,
                              position.target.longitude);
                        },
                        onCameraIdle: () {
                          mapController.setAddress(controller.position);
                        },
                        initialCameraPosition: controller.myLocation,
                        onMapCreated: (GoogleMapController controller2) {
                          controllerMap.complete(controller2);
                        },
                      ),
                    ),
                  ),
                  Obx(() => Positioned(
                        top: 270 / 2 - 48,
                        left: 0,
                        right: 0,
                        child: mapController.loadAddress.value
                            ? const CustomLoading()
                            : Bounce(
                                duration: Duration(milliseconds: 500),
                                child: const CustomPngImage(
                                  "marker",
                                  fit: BoxFit.contain,
                                  heigth: 50,
                                  color: AppColors.greenColor,
                                  width: 50,
                                  isColor: true,
                                ),
                              ),
                      )),
                  Positioned(
                    top: 80.h,
                    right: 12.w,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CustomSvgImage(
                        "back",
                        height: 60.h,
                        width: 60.w,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GetBuilder<MapController>(builder: (controller) {
                  return Form(
                    key: formKey,
                    child: Column(children: [
                      SizedBox(height: 10.h),
                      Center(
                        child: Container(
                          height: 4.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10.r)),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                                serviceLoctionController.city.value.name ==
                                            "غير ذلك" ||
                                        serviceLoctionController
                                                .area.value.name ==
                                            "غير ذلك"
                                    ? "إقترح عنوان"
                                    : "العنوان بالكامل",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: AppColors.bluColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.sp)),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            // width: 300.w,
                            child: FormFieldItem(
                              textInputType: TextInputType.text,
                              labelText: 'العنوان',
                              obscureText: false,
                              validator: (v) => ValidationHelper
                                  .validationHelper
                                  .validateNull(v),
                              backgroundColor: Colors.grey[200],
                              textInputAction: TextInputAction.done,
                              editingController: controller.addressControlelr,
                              type: false,
                              onChange: (v) {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Container(
                          height: 110.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("المدينة",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: AppColors.bluColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16.sp)),
                                    SizedBox(height: 4.h),
                                    SizedBox(
                                      child: CustomDropDown(
                                        itemsList: serviceLoctionController
                                                .citiesModel.value.item ??
                                            [],
                                        hint: serviceLoctionController
                                            .city.value.name,
                                        hintColor: Colors.black,
                                        iconColor: Colors.black,
                                        backgroundColor: Colors.grey[200],
                                        onChanged: (value) async {
                                          serviceLoctionController.city.value =
                                              value!;

                                          setState(() {});
                                          await serviceLoctionController
                                              .getArea("${value.id}");
                                          serviceLoctionController.area.value =
                                              Item(id: 0, name: "اختر المنطقة");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20.w),
                              serviceLoctionController.city.value.name ==
                                      "غير ذلك"
                                  ? Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("إقترح المدينة/المنطقة",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: AppColors.gryText,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.sp)),
                                          SizedBox(height: 8.h),
                                          SizedBox(
                                            height: 60.h,
                                            child: FormFieldItem(
                                              textInputType: TextInputType.text,
                                              labelText:
                                                  "إقترح المدينة/المنطقة",
                                              obscureText: false,
                                              validator: (v) {},
                                              backgroundColor: Colors.grey[200],
                                              textInputAction:
                                                  TextInputAction.done,
                                              editingController:
                                                  controller.areaControlelr,
                                              type: false,
                                              onChange: (v) {
                                                serviceLoctionController
                                                    .area.value.name = v;
                                                serviceLoctionController
                                                    .area.value.id = 100;

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: Obx(
                                        () => serviceLoctionController
                                                    .isLoad.value ==
                                                true
                                            ? CustomLoading()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("المنطفة",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .bluColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 16.sp)),
                                                  SizedBox(height: 4.h),
                                                  SizedBox(
                                                    child: CustomDropDown(
                                                      itemsList:
                                                          serviceLoctionController
                                                                  .areaModel
                                                                  .value
                                                                  .item ??
                                                              [],
                                                      hint:
                                                          serviceLoctionController
                                                              .area.value.name,
                                                      hintColor: Colors.black,
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      iconColor: Colors.black,
                                                      onChanged: (value) {
                                                        serviceLoctionController
                                                            .area
                                                            .value = value!;

                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    )
                            ],
                          )),
                      SizedBox(height: 10.h),
                      serviceLoctionController.city.value.name == "غير ذلك" ||
                              serviceLoctionController.area.value.name ==
                                  "غير ذلك"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 50.h),
                                Text("منطقتك غير متوفرة في الخدمة",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: AppColors.bluColor,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18.sp)),
                                SizedBox(height: 8.h),
                                Text("نتمنى إضافة المنطقة ليتم  خدمتها قريبا",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: AppColors.bluColor,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16.sp)),
                                SizedBox(height: 60.h),
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("رقم البناية",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: AppColors.gryText,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.sp)),
                                          SizedBox(height: 8.h),
                                          SizedBox(
                                            child: FormFieldItem(
                                              textInputType:
                                                  TextInputType.number,
                                              labelText: '1-2',
                                              obscureText: false,
                                              validator: (v) {},
                                              backgroundColor: Colors.grey[200],
                                              textInputAction:
                                                  TextInputAction.done,
                                              editingController:
                                                  controller.noBuildControlelr,
                                              type: false,
                                              onChange: (v) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("رقم الشقة",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: AppColors.gryText,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.sp)),
                                          SizedBox(height: 8.h),
                                          SizedBox(
                                            child: FormFieldItem(
                                              textInputType:
                                                  TextInputType.number,
                                              labelText: '123',
                                              obscureText: false,
                                              validator: (v) {},
                                              backgroundColor: Colors.grey[200],
                                              textInputAction:
                                                  TextInputAction.done,
                                              editingController:
                                                  controller.noFloorControlelr,
                                              type: false,
                                              onChange: (v) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("رقم التواصل",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: AppColors.gryText,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16.sp)),
                                    SizedBox(height: 8.h),
                                    SizedBox(
                                      // height: 60.h,
                                      // width: 300.w,
                                      child: FormFieldItem(
                                        textInputType: TextInputType.number,
                                        labelText: '0569434234',
                                        obscureText: false,
                                        validator: (v) => ValidationHelper
                                            .validationHelper
                                            .validateMobile(v),
                                        backgroundColor: Colors.grey[200],
                                        textInputAction: TextInputAction.done,
                                        editingController:
                                            TextEditingController.fromValue(
                                          TextEditingValue(
                                            text: profileController.profileModel
                                                    .user!.mobile ??
                                                "",
                                          ),
                                        ),
                                        type: false,
                                        onChange: (v) {
                                          profileController
                                              .profileModel.user!.mobile = v;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.r)),
                                      onChanged: (v) {
                                        v == false
                                            ? serviceLoctionController
                                                .isDefulte.value = 0
                                            : serviceLoctionController
                                                .isDefulte.value = 1;
                                      },
                                      value: serviceLoctionController
                                                  .isDefulte.value ==
                                              0
                                          ? false
                                          : true,
                                    ),
                                    Text('عنوانك الافتراضي',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: AppColors.gryText,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14.sp)),
                                  ],
                                ),
                              ],
                            ),
                      SizedBox(height: 4.h),
                      CustomButton(
                        buttonText: "حفظ",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            KeyboardUtil.hideKeyboard(Get.context!);

                            if (serviceLoctionController.city.value.id == 0 ||
                                serviceLoctionController.area.value.id == 0) {
                              BotToast.showText(
                                  text:
                                      serviceLoctionController.city.value.id ==
                                              0
                                          ? "يجب اختيار المدينة"
                                          : "يجب اختيار المنطقة",
                                  contentColor: Colors.red);
                            } else {
                              await serviceLoctionController.addAddrees(
                                  serviceLoctionController.isDefulte.value,
                                  profileController.profileModel.user!.mobile);
                              // Get.toNamed(Routes.MAINProvider);
                            }
                          }
                        },
                      ),
                      SizedBox(height: 8.h),
                    ]),
                  );
                }))));
  }
}
