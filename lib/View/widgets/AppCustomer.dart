import 'package:capotcha/value/colors.dart';
import 'package:flutter/material.dart';

class AppCustomer extends StatelessWidget {
  final String title;
  AppCustomer(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
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
      child: ListTile(
        title: Container(
          margin: EdgeInsets.only(left: 50),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.bluColor,
              fontFamily: 'Cairo',
              fontSize: 20.0,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.bluColor,
          ),
        ),
      ),
    );
  }
}
