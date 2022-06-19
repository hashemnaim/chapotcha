import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/list_grid_tocard.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<SalesScreen>
    with TickerProviderStateMixin {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "العروض",
              style: Style.cairo,
            )),
      ),
      // SizedBox(
      //   height: 8,
      // ),
      //  Divider(),
      Expanded(
        child: Stack(
          children: [Bakeground(), ListGridToCart()],
        ),
      )
    ]));
  }
}
