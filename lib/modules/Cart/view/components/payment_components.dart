import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

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
          height: 45.h,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "طريقة الدفع",
              style: Style.cairo.copyWith(fontSize: 16.sp),
            ),
          ),
        ),
        padding2,
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
          width: Get.width,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      shadowColor: Colors.grey,
                      side: BorderSide(color: AppColors.greenColor)),
                  child: Text(
                    "كاش",
                    style: Style.cairo.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.greenColor,
                        height: 1.2),
                  ))),
        ),
      ],
    );
  }
}
