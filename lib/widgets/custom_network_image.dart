// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skeleton_text/skeleton_text.dart';
import '../utils/colors.dart';
import 'custom_svg.dart';

class CustomNetworkImage extends StatelessWidget {
  final String urlImage;
  final double width;
  final double heigth;
  final double borderRadius;
  final BoxFit fit;

  // ignore: use_key_in_widget_constructors
  CustomNetworkImage(this.urlImage,
      {this.heigth = 53,
      this.width = 133,
      this.borderRadius = 5,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return urlImage == ""
        ? Center(
            child: CustomPngImage(
            "icon",
            fit: fit,
            heigth: heigth,
            width: width,
          ))
        : ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius.r),
            child: CachedNetworkImage(
              imageUrl: urlImage,
              imageBuilder: (context, imageProvider) => Container(
                width: width.w,
                height: heigth.h,
                decoration: BoxDecoration(
                  shape:
                      borderRadius == 0 ? BoxShape.circle : BoxShape.rectangle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                  ),
                ),
              ),
              placeholder: (context, url) => ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius.r),
                child: heigth == 100.h
                    ? Center(
                        child: SpinKitSpinningLines(
                          color: AppColors.greenColor,
                          size: 60.0,
                          // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                        ),
                      )
                    : SkeletonAnimation(
                        borderRadius: BorderRadius.circular(borderRadius.r),
                        shimmerColor: Colors.grey[400]!,
                        child: Container(
                          width: width.w,
                          height: heigth.h,
                          decoration: BoxDecoration(
                            shape: borderRadius == 0
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
              ),
              errorWidget: (context, url, error) => Center(
                  child: CustomPngImage(
                "icon",
                fit: fit,
                heigth: heigth,
                width: width,
              )),
            ),
          );
  }
}
