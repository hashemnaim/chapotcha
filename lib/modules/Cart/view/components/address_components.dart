import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/method_helpar.dart';
import '../../../../utils/styles.dart';
import '../../../Profile/controller/profile_controller.dart';

class AddressComponets extends StatelessWidget {
  const AddressComponets({
    Key? key,
    required this.padding2,
  }) : super(key: key);

  final Padding padding2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              "العنوان",
              style: Style.cairo.copyWith(fontSize: 16.sp),
            ),
          ),
        ),
        padding2,
        GetBuilder<ProfileController>(
          id: "profile",
          builder: (profileController) => profileController
                      .profileModel.address ==
                  null
              ? Container()
              : Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ]),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileController
                                          .profileModel.address!.city! +
                                      "-" +
                                      profileController
                                          .profileModel.address!.area!,
                                  overflow: TextOverflow.ellipsis,
                                  style: Style.cairog.copyWith(
                                      fontSize: 18.sp,
                                      color: AppColors.bluColor),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "البناية " +
                                      profileController
                                          .profileModel.address!.building! +
                                      " - الدور " +
                                      profileController
                                          .profileModel.address!.apartment!,
                                  style: Style.cairog.copyWith(
                                      fontSize: 14.sp,
                                      height: 2,
                                      color: AppColors.bluColor),
                                ),
                              ],
                            ),
                            Spacer(),
                            OutlinedButton(
                                onPressed: () {
                                  changeMyAddress();
                                },
                                style: OutlinedButton.styleFrom(
                                    shadowColor: Colors.grey,
                                    side: BorderSide(
                                        color: AppColors.greenColor)),
                                child: Text(
                                  "تغير",
                                  style: Style.cairo.copyWith(fontSize: 16.sp),
                                ))
                          ],
                        ),
                      ],
                    ),
                  )),
        ),
        Center(
          child: OutlinedButton(
              onPressed: () {
                Get.toNamed(
                  Routes.AddAddressScreen,
                );
              },
              style: OutlinedButton.styleFrom(
                  shadowColor: Colors.grey,
                  side: BorderSide(color: AppColors.greenColor)),
              child: Text(
                "إضافة عنوان جديد",
                style: Style.cairo.copyWith(
                  fontSize: 16.sp,
                ),
              )),
        ),
        padding2,
      ],
    );
  }
}
