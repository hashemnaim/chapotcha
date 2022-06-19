import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';

class AppBarCustomer extends StatelessWidget {
 final String title ;
  AppBarCustomer(this.title);
  @override
  Widget build(BuildContext context) {
    return  Container(
          padding: EdgeInsets.only(top: 15),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Center(
              child: Text(
            title,
            style: Style.cairo,
          )),
        );
  }
}