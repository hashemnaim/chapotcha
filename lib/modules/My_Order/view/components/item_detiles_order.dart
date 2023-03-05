import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/custom_network_image.dart';

class ItemDetilsOrder extends StatelessWidget {
  const ItemDetilsOrder({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.qty,
  }) : super(key: key);
  final String? name, price, image, qty;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
          height: 60.h,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 6)],
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
              title: Row(
                children: [
                  CustomNetworkImage(
                    Constants.imgUrl + image!,
                    heigth: 80.h,
                    width: 40.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    name!,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: AppColors.bluColor, height: 1.4),
                  ),
                ],
              ),
              minLeadingWidth: 10,
              leading: Text(
                "X ${double.parse(qty!).toStringAsFixed(1)}",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.bluColor, fontSize: 16.sp),
              ),
              trailing: Text(
                (double.parse(qty!) * double.parse(price!)).toStringAsFixed(1) +
                    " " +
                    Constants.currency,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.bluColor, fontSize: 16.sp),
              ))),
    );
  }
}
