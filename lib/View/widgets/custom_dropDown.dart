import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropDown extends StatefulWidget {
  double height;
  double width;
  String title;

  CustomDropDown(this.height, this.width, this.title);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String _dropDownValue;

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<HomeProvieder>(context, listen: false);

    return Container(
        padding: EdgeInsets.only(right: 25),
        height: widget.height,
        width: widget.width,
        child: DropdownButton(
          hint: _dropDownValue == null
              ? Text(
                  widget.title,
                  style: Style.cairo,
                )
              : Text(
                  _dropDownValue,
                  style: Style.cairog,
                ),
          isExpanded: true,
          underline: Container(),
          iconSize: 30.0,
          style: Style.cairog,
          items: cartModel.completeCart.cities.map(
            (val) {
              return DropdownMenuItem(
                value: val.name,
                child: Text(
                  val.name,
                  style: Style.cairog,
                ),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
              () {
                //   this.id = val;
                _dropDownValue = val;
                // cartModel
                //     .cartModel
                //     .cities[val]
                //     .name;
              },
            );
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            color: Colors.white));
  }
}
