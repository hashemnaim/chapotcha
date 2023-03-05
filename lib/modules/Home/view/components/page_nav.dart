/*
*  radii.dart
*  DhabayehAlEmarat
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:capotcha/modules/Profile/view/profile_screen.dart';
// import 'package:capotcha/View/Screen/home.dart';
import 'package:capotcha/modules/Offer/offers_screen.dart';

import 'package:flutter/material.dart';

import '../../../../utils/animate_do.dart';
import '../../../Cart/view/cart_screen.dart';
import '../../../My_Order/view/my_order_screen.dart';
import '../home_screen.dart';

class PageNav {
  static List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    FadeInRight(child: MyOrderScreen()),
    CartScreen(),
    FadeInRight(child: OffersScreen()),
    BounceInUp(child: ProfileScreen()),
  ];
}
