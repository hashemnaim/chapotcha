// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {
  final String? text;
  final Color? color;
  final double height;
  final bool isColor;
  final double width;

  const CustomSvgImage(this.text,
      {this.color = Colors.white,
      this.height = 18,
      this.width = 18,
      this.isColor = false});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/svg/$text.svg",
      height: height.h,
      width: width.w,
      color: isColor == false ? null : color,
      fit: BoxFit.contain,
    );
  }
}

class CustomPngImage extends StatelessWidget {
  final String text;
  final Color color;
  final bool isColor;
  final double heigth;
  final double width;
  final BoxFit fit;

  const CustomPngImage(
    this.text, {
    this.color = Colors.white,
    this.isColor = false,
    this.heigth = 200,
    this.width = 200,
    this.fit = BoxFit.cover,
  });
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/$text.png",
      height: heigth,
      width: width,
      fit: fit,
      color: isColor == false ? null : color,
    );
  }
}
