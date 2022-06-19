import 'package:capotcha/View/Screen/Cart_screen/cart1.dart';
import 'package:capotcha/value/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';

class FloatingButtonAnimated extends StatefulWidget {
  @override
  _FloatingButtonAnimatedState createState() => _FloatingButtonAnimatedState();
}

class _FloatingButtonAnimatedState extends State<FloatingButtonAnimated>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => Talapat()));
    if (!isOpened) {
      _animationController.forward();
      Navigator.push(context, MaterialPageRoute(builder: (_) => Talapat()));
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.greenColor,
      onPressed: animate,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform(
              transform:
                  Matrix4.rotationY(_animationController.value * 2 * math.pi),
              alignment: FractionalOffset.center,
              child: SvgPicture.asset(
                "assets/images/icon-cart.svg",
              ));
        },
      ),
    );
  }
}
