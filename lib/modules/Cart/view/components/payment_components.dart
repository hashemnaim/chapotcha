import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';

class PaymentComponents extends StatelessWidget {
  const PaymentComponents({
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
          height: 35.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "طريقة الدفع",
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 14.sp),
            ),
          ),
        ),
        // padding2,
        Container(
          width: Get.width,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4.h),
              child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      shadowColor: Colors.grey,
                      side: BorderSide(color: AppColors.greenColor)),
                  child: Text(
                    "كاش",
                    style: Theme.of(Get.context!)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                            fontSize: 16.sp,
                            color: AppColors.greenColor,
                            height: 1.2.h),
                  ))),
        ),
      ],
    );
  }
}
