import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/method_helpar.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
            child: Text(
              "العنوان",
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 14.sp),
            ),
          ),
        ),
        // padding2,
        GetBuilder<ProfileController>(
          id: "profile",
          builder: (profileController) => profileController
                      .profileModel.address ==
                  null
              ? Center(
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
                        style: Theme.of(Get.context!)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                              fontSize: 14.sp,
                            ),
                      )),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileController.profileModel.address!.city! +
                                    "-" +
                                    profileController
                                        .profileModel.address!.area!,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
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
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
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
                                  side:
                                      BorderSide(color: AppColors.greenColor)),
                              child: Text(
                                "تغير",
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 14.sp),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
        ),

        padding2,
        SizedBox(height: 8.h)
      ],
    );
  }
}
