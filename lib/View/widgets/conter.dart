import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/sql_table.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/home_model.dart';

class CounterWidget extends StatefulWidget {
  final double height;
  final double width;
  final int index;
  final String unit;
  final int stock;

  CounterWidget(
    this.height,
    this.width,
    this.index,
    this.unit, {
    int parse,
    this.stock,
  });
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  double cont = 1.0;
  double cont5 = 1.0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvieder>(context, listen: false);
    List<DataCategory> data =
        Provider.of<HomeProvieder>(context).homeModel.dataCategory;
    return Container(
      height: widget.height,
      width: widget.width,
      padding: EdgeInsets.only(left: 9, right: 9),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[100]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              // if (widget.unit == "كيلو") {
              cont5 += 0.5;
              provider.setquantity(cont5, widget.index);
              // } else {
              //   cont += 1.0;
              //   provider.setquantity(cont, widget.index);
              // }
              setState(() {});
            },
            child: Container(
              height: 30,
              width: 35,
              child: Icon(
                Icons.add,
                color: Colors.green,
                size: 28,
              ),
            ),
          ),
          Center(
            child: Text(
              //  widget.qty.toString(),
              "$cont5",
              style: Style.cairog.copyWith(fontSize: 16),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (cont5 > 0.5) {
                // if (widget.unit == "كيلو") {
                cont5 -= 0.5;

                provider.setquantity(cont5, widget.index);
                // } else {
                //   cont -= 1.0;
                //   provider.setquantity(cont, widget.index);
                // }
                // nu.setquantity(cont,widget.index);
              }

              setState(() {});
            },
            child: Container(
              height: 30,
              width: 35,
              child: Icon(
                Icons.remove,
                color: Color(0xff748A9D),
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
