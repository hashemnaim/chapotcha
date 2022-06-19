import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/item_list.dart';
import 'package:capotcha/View/widgets/slider_item.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: SLiderItem(),
        ),
        Expanded(
          child: Stack(
            children: [
              Bakeground(),
              ItemList(),
            ],
          ),
        ),
      ],
    );
  }
}
