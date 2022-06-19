import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_bottom_app_bar.dart';

class NavCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomBottomAppBar(
        onTabSelected: (index) {
          Provider.of<HomeProvieder>(context, listen: false).setNav(index);
        },
        items: [
          CustomAppBarItem(
              icon: "assets/images/icon-store.svg", titel: "الرئيسية"),
          CustomAppBarItem(icon: "assets/images/wallet.svg", titel: "نقاطي"),
          CustomAppBarItem(
              icon: "assets/images/icon-recipes.svg", titel: "العروض"),
          CustomAppBarItem(
              icon: "assets/images/icon-settings.svg", titel: "المزيد"),
        ]);
  }
}
