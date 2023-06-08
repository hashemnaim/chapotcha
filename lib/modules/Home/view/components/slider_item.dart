import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_network_image.dart';
import '../../../../utils/constants.dart';
import '../../model/slider_model.dart';

class SLiderItem extends StatelessWidget {
  final List<Sliders>? slider;

  const SLiderItem({Key? key, this.slider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          height: 220.h,
          viewportFraction: 1.0,
          enlargeCenterPage: true,
          reverse: false,
        ),
        items: slider!
            .map((e) => CustomNetworkImage(Constants.imgUrlSlider + e.image!,
                borderRadius: 6.r,
                width: Get.width,
                heigth: 220.h,
                fit: BoxFit.contain))
            .toList());
  }
}
