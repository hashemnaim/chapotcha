import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/widgets/custom_drop_down_string.dart';
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
  bool addLocation = false;
  @override
  void initState() {
    super.initState();
    addLocation = false;
    getAddressAndMoveCamera();
  }

  getAddressAndMoveCamera() async {
    mapController.getLocation(await controllerMap.future);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(addLocation == false ? Get.height : 300.h),
          child: GetBuilder<MapController>(
            id: "gps",
            builder: (controller) => Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: addLocation == false ? Get.height - 30.h : 270,
                      child: GoogleMap(
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
                    GetBuilder<MapController>(
                        id: "gps",
                        builder: (controller) => Positioned(
                              top: addLocation == true
                                  ? ((270 / 2) - 32).h
                                  : ((Get.height / 2) - 8).h,
                              left: 0,
                              right: 0,
                              child: controller.loadAddress
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
                    addLocation == true
                        ? Container()
                        : Positioned(
                            bottom: 40.h,
                            right: 0,
                            left: 0,
                            child: SizedBox(
                              height: 60.h,
                              child: CustomButton(
                                buttonText: "اضافة موقعك",
                                onPressed: () async {
                                  await getAddressAndMoveCamera();
                                  if (controller.position.latitude ==
                                      29.944785) {
                                    BotToast.showText(
                                        text:
                                            "الرجاء تحديد موقعك على الخريطة بشكل صحيح");
                                  } else {
                                    addLocation = true;
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: AnimatedCrossFade(
          crossFadeState: CrossFadeState.values[addLocation == false ? 0 : 1],
          firstChild: SizedBox(
            height: 1.h,
          ),
          secondCurve: Curves.easeIn,
          alignment: Alignment.topCenter,
          duration: Duration(milliseconds: 500),
          secondChild: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GetBuilder<MapController>(
                      id: "gps",
                      builder: (controller) {
                        return Form(
                          key: formKey,
                          child: Column(children: [
                            SizedBox(height: 8.h),
                            Center(
                              child: Container(
                                height: 4.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(10.r)),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                                height: 110.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("المدينة",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: AppColors.bluColor,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.sp)),
                                          SizedBox(height: 4.h),
                                          SizedBox(
                                            child: CustomDropDown(
                                              itemsList:
                                                  serviceLoctionController
                                                          .citiesModel
                                                          .value
                                                          .item ??
                                                      [],
                                              hint: serviceLoctionController
                                                  .city.value.name,
                                              hintColor: Colors.black,
                                              iconColor: Colors.black,
                                              backgroundColor: Colors.grey[200],
                                              onChanged: (value) async {
                                                serviceLoctionController
                                                    .city.value = value!;

                                                setState(() {});
                                                await serviceLoctionController
                                                    .getArea("${value.id}");
                                                serviceLoctionController
                                                        .area.value =
                                                    Item(
                                                        id: 0,
                                                        name: "اختر المنطقة");
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    Expanded(
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text("العنوان بالتفصيل",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              color: AppColors.bluColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.sp)),
                                ),
                                SizedBox(height: 6.h),
                                SizedBox(
                                  child: FormFieldItem(
                                    textInputType: TextInputType.text,
                                    labelText: 'المنطقة - الشارع ـ اقرب معلم',
                                    obscureText: false,
                                    validator: (v) => ValidationHelper
                                        .validationHelper
                                        .validateNonAdress(
                                            v,
                                            serviceLoctionController
                                                .area.value.name!),
                                    backgroundColor: Colors.grey[200],
                                    textInputAction: TextInputAction.done,
                                    editingController:
                                        controller.addressControlelr,
                                    type: false,
                                    onChange: (v) {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: serviceLoctionController
                                                  .city.value.name ==
                                              "حدائق الاهرام"
                                          ? 2
                                          : 1,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                            color: AppColors
                                                                .bluColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 16.sp)),
                                                SizedBox(height: 8.h),
                                                SizedBox(
                                                  child: FormFieldItem(
                                                    textInputType:
                                                        TextInputType.number,
                                                    labelText: '1-2',
                                                    obscureText: false,
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    editingController:
                                                        controller
                                                            .noBuildControlelr,
                                                    type: false,
                                                    validator: (v) =>
                                                        ValidationHelper
                                                            .validationHelper
                                                            .validateNull(
                                                      v,
                                                    ),
                                                    onChange: (v) {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          serviceLoctionController
                                                      .city.value.name ==
                                                  "حدائق الاهرام"
                                              ? Column(
                                                  children: [
                                                    Text("الحرف",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bluColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize:
                                                                    16.sp)),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 12.h,
                                                          right: 2.w),
                                                      child: Center(
                                                        child: SizedBox(
                                                          width: 65.w,
                                                          height: 50.w,
                                                          child: Center(
                                                            child: Obx(() =>
                                                                CustomDropDownString(
                                                                  itemsList:
                                                                      serviceLoctionController
                                                                          .wordBuild,
                                                                  hint: serviceLoctionController
                                                                      .wordBuildValue
                                                                      .value,
                                                                  hintColor:
                                                                      Colors
                                                                          .black,
                                                                  iconColor:
                                                                      Colors
                                                                          .black,
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          200],
                                                                  onChanged:
                                                                      (value) async {
                                                                    serviceLoctionController
                                                                        .wordBuildValue
                                                                        .value = value!;
                                                                  },
                                                                )),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  width: 1,
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("رقم الدور",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: AppColors.bluColor,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.sp)),
                                          SizedBox(height: 8.h),
                                          SizedBox(
                                            child: FormFieldItem(
                                              textInputType:
                                                  TextInputType.number,
                                              labelText: '1',
                                              obscureText: false,
                                              backgroundColor: Colors.grey[200],
                                              textInputAction:
                                                  TextInputAction.done,
                                              editingController:
                                                  controller.noFloorControlelr,
                                              type: false,
                                              validator: (v) => ValidationHelper
                                                  .validationHelper
                                                  .validateNull(
                                                v,
                                              ),
                                              onChange: (v) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
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
                                                      color: AppColors.bluColor,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.sp)),
                                          SizedBox(height: 8.h),
                                          SizedBox(
                                            child: FormFieldItem(
                                              textInputType:
                                                  TextInputType.number,
                                              labelText: '3',
                                              obscureText: false,
                                              validator: (v) => ValidationHelper
                                                  .validationHelper
                                                  .validateNull(
                                                v,
                                              ),
                                              backgroundColor: Colors.grey[200],
                                              textInputAction:
                                                  TextInputAction.done,
                                              editingController:
                                                  controller.noFlatControlelr,
                                              type: false,
                                              onChange: (v) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
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
                                                color: AppColors.btnColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18.sp)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            CustomButton(
                              buttonText: "حفظ",
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  KeyboardUtil.hideKeyboard(Get.context!);
                                  if (serviceLoctionController.city.value.id ==
                                      0) {
                                    BotToast.showText(
                                        text: "من فضلك اختر المدينة",
                                        contentColor: Colors.red);
                                  } else if (serviceLoctionController
                                          .area.value.id ==
                                      0) {
                                    BotToast.showText(
                                        text: "من فضلك اختر المنطقة",
                                        contentColor: Colors.red);
                                  } else {
                                    if (serviceLoctionController
                                                .city.value.name ==
                                            "حدائق الاهرام" &&
                                        serviceLoctionController
                                                .wordBuildValue.value ==
                                            "") {
                                      BotToast.showText(
                                          text: "من فضلك اختر الحرف",
                                          contentColor: Colors.red);
                                    } else {
                                      await serviceLoctionController.addAddrees(
                                          serviceLoctionController
                                              .isDefulte.value,
                                          profileController
                                              .profileModel.user!.mobile);
                                    }
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 8.h),
                          ]),
                        );
                      }))),
        ));
  }
}
