
import 'package:flutter/material.dart';

class CustomerButton extends StatelessWidget {
  String number;
  String password;
  String label;
  Route screen;
  Function submitFrom;
  Function navigatorScreen;

  CustomerButton(
      {this.label,  this.submitFrom, this.navigatorScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width * 0.7,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          submitFrom();
        },
        color: Color(0xff98B119),
        child: Text(
          label,
          style:
              TextStyle(color: Colors.white, fontFamily: "Cairo", fontSize: 18),
        ),
      ),
    );
  }
}
