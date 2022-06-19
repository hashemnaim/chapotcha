import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomerImageNetwork extends StatelessWidget {
  final String urlImage;
  final double width;
  final double heigth;
  final double borderRadius;
  final bool circle;
  final Color borderColor;
  final double radius;
  CustomerImageNetwork(
    this.urlImage, {
    this.borderRadius = 5,
    this.circle = false,
    this.borderColor = Colors.amber,
    this.heigth = 60,
    this.width = 60,
    this.radius = 8,
  });
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          // border: Border.all(color: borderColor),
        ),
        child: circle
            ? CircleAvatar(
                radius: radius,
                backgroundColor: Colors.transparent,
                backgroundImage: CachedNetworkImageProvider(urlImage),
              )
            : Container(
                width: width,
                height: heigth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
      ),
      placeholder: (context, url) => Center(
          child:
              //  circle
              //     ?
              CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: ExactAssetImage('assets/images/shamer.gif'),
        maxRadius: radius,
      )
          // : Container(
          //     width: width.w,
          //     height: heigth.h,
          //     decoration:
          //         BoxDecoration(borderRadius: BorderRadius.circular(50.r)),
          //     child: Image.asset('assets/gif/loading.gif'))
          ),
      errorWidget: (context, url, error) => Center(
          child: Icon(
        Icons.error,
        size: 10,
      )),
    );
  }
}
