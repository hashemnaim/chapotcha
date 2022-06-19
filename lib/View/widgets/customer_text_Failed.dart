import 'package:capotcha/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomerTextFalied extends StatelessWidget {
  final int typeInput;
  final String label;
  final Function validatorValue;
  final Function onSaveV;
  final IconData iconTextfiled;
  final String prefixText;
  final String hintText;
  final String initalValue;
//bool pass = false;
  final int maxLength;
  CustomerTextFalied(
      {this.label,
      this.validatorValue,
      this.onSaveV,
      this.iconTextfiled,
      this.typeInput,
      this.hintText,
      this.initalValue,
      this.maxLength,
      this.prefixText});
  @override
  Widget build(BuildContext context) {
    return Container(
        //  height: MediaQuery.of(context).size.height * 0.12,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            keyboardType: TextInputType.values[typeInput],
            obscureText: typeInput == 7 ? true : false,
            textAlign: TextAlign.right,
            onSaved: (newValue) => onSaveV(newValue),
            validator: (value) => validatorValue(value),
            obscuringCharacter: "*",
            initialValue: initalValue,
            maxLength: maxLength,
            decoration: InputDecoration(
              //   suffixText: prefixText,
              prefixStyle: TextStyle(color: Colors.grey),
              suffix: Container(
                  child: Icon(
                iconTextfiled,
                size: 16,
                color: Colors.grey,
              )),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
              labelText: label,
              labelStyle: TextStyle(
                  fontSize: 12, fontFamily: "Cairo", color: Color(0xff658199)),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.greenColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.redAccent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ));
  }
}
