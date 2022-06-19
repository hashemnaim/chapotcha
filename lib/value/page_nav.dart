/*
*  radii.dart
*  DhabayehAlEmarat
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:capotcha/View/Screen/Cart_screen/cart1.dart';
import 'package:capotcha/View/Screen/Profile_screen/profile_screen.dart';
import 'package:capotcha/View/Screen/home.dart';
import 'package:capotcha/View/Screen/neqat.dart';
import 'package:capotcha/View/Screen/sales_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../animate_do.dart';

class PageNav {
  static const BorderRadiusGeometry k8pxRadius =
      BorderRadius.all(Radius.circular(8));
  static List<Widget> widgetOptions = <Widget>[
    SlideInDown(child: Home()),
    FadeInRight(child: Neqat()),
    FadeInRight(child: SalesScreen()),
    BounceInUp(child: ProfileScreen()),
    BounceInUp(child: Talapat()),
  ];
}
