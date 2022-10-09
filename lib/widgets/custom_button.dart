// ignore_for_file: use_key_in_widget_constructors

import 'package:capotcha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String? buttonText;
  final bool transparent;
  final double height;
  final double width;
  final double? fontSize;
  final double radius;
  final Color? color;
  final IconData? icon;
  const CustomButton(
      {this.onPressed,
      this.buttonText,
      this.transparent = false,
      this.width = 327,
      this.height = 56,
      this.color,
      this.fontSize,
      this.radius = 14,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: color ?? AppColors.greenColor,
      minimumSize: Size(width, height),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );

    return Center(
        child: SizedBox(
            width: width.w,
            height: height.h,
            child: TextButton(
              onPressed: () => onPressed!(),
              style: _flatButtonStyle,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                icon == null
                    ? Container()
                    : Icon(
                        icon,
                        color: Colors.white,
                        size: 25,
                      ),
                Text(buttonText!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.button!.copyWith(
                        color: transparent == true
                            ? Theme.of(context).dividerColor.withOpacity(0.2)
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp)),
              ]),
            )));
  }
}
