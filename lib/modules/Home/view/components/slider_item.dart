import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
          aspectRatio: 3,
          enlargeCenterPage: true,
          reverse: false,
        ),
        items: slider!
            .map(
              (e) => CustomNetworkImage(
                Constants.imgUrlSlider + e.image!,
                borderRadius: 10,
                heigth: 380,
                width: 450,
                fit: BoxFit.fill,
              ),
            )
            .toList());
  }
}
