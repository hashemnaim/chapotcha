import 'package:cached_network_image/cached_network_image.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/models/home_model.dart';
import 'package:capotcha/value/shadows.dart';
import 'package:capotcha/value/string.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SLiderItem extends StatefulWidget {
  @override
  _SLiderItemState createState() => _SLiderItemState();
}

class _SLiderItemState extends State<SLiderItem> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<HomeProvieder>(context, listen: false).homeModel.sliders !=
        null) {
      List<Sliders> slider = Provider.of<HomeProvieder>(
        context,
      ).homeModel.sliders;
      return Container(
        // height: MediaQuery.of(context).size.height*0.180,
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 3,
                enlargeCenterPage: true,
                reverse: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    current = index;
                  });
                }),
            items: slider
                .map((e) => Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,

                        boxShadow: <BoxShadow>[Shadows.primaryShadow],
                        //  color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                        // color: Colors.grey,
                        image: DecorationImage(
                            image: e.image != null
                                ? CachedNetworkImageProvider(
                                    imgUrlSlider + e.image,
                                  )
                                : Container(),
                            fit: BoxFit.contain),
                      ),
                    ))
                .toList()),
      );
    } else {
      return Center(child: Text('لا يوجد بيانات'));
    }
  }
}
