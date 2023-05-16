import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../../controller/order_controller.dart';

class CustomStauts extends StatelessWidget {
  const CustomStauts({
    Key? key,
    this.controller,
    this.index,
  }) : super(key: key);
  final int? index;
  final OrderController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        controller!.listStatus.length,
        (index2) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 8.r,
              backgroundColor: int.parse(
                          controller!.orderModel.orders![index!].statusCode!) >=
                      index2
                  ? AppColors.greenColor
                  : Colors.grey,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              controller!.listStatus[index2],
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: int.parse(controller!
                              .orderModel.orders![index!].statusCode!) >=
                          index2
                      ? AppColors.greenColor
                      : AppColors.bluColor),
            ),
          ],
        ),
      ),
    );
  }
}
