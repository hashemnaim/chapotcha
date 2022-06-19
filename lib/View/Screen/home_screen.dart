import 'package:capotcha/View/widgets/appmaincastomer.dart';
import 'package:capotcha/View/widgets/navbottomcostomer.dart';
import 'package:capotcha/View/widgets/navfloat.dart';
import 'package:capotcha/animate_do.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/value/page_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(double.infinity, sizeH * 0.09),
                  child: AppBarMaimCustomer()),
              body: FadeInRight(
                child: PageNav
                    .widgetOptions[Provider.of<HomeProvieder>(context).indexN],
              ),
              floatingActionButton: NavFloat(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: NavCustomer()),
        ));
  }
}
