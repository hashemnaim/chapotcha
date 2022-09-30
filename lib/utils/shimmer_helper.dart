import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ShimmerHelper {
  static Widget loadingWidget() => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        child: Wrap(spacing: 8, children: [
          ...List.generate(4, (index) {
            return SkeletonAnimation(
              shimmerColor: Colors.grey[300]!,
              child: Container(
                width: 79.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          })
        ]),
      );

  static Widget loadingerticalWidget() => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ...List.generate(3, (index) {
            return SkeletonAnimation(
              shimmerColor: Colors.grey[300]!,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 151.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          })
        ]),
      );

  static Widget loadingHome() => ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(6.0),
            child: SkeletonAnimation(
                shimmerColor: Colors.grey[300]!,
                child: Container(
                  width: Get.width,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
          ));

  static Widget loadingProduct() => MasonryGridView.count(
      padding: EdgeInsets.all(8),
      crossAxisCount: 2,
      mainAxisSpacing: 10.w,
      crossAxisSpacing: 10.h,
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
      itemBuilder: (context, index) => SkeletonAnimation(
          shimmerColor: Colors.grey[300]!,
          child: Container(
            width: Get.width,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          )));
}
