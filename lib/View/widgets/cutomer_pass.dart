import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CustomerText extends StatelessWidget {
 final int typeInput;
 final String label;
 final Function validatorValue;
 final Function onSaveV;
 final IconData iconTextfiled;
 final String prefixText;
 final String hintText;
 final bool pass;
  CustomerText(
      {this.label,
      this.validatorValue,
      this.onSaveV,
      this.iconTextfiled,
      this.typeInput,
      this.hintText,
      this.pass,
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
          obscureText: pass,
          textAlign: TextAlign.right,
          //   style: TextStyle(fontSize: 14,color: Color(0xff658199),),
          onSaved: (newValue) => onSaveV(newValue),
          validator: (value) => validatorValue(value),
          obscuringCharacter: "*",
          decoration: InputDecoration(
            suffixText: prefixText,
            prefixStyle: TextStyle(color: Colors.grey),
            suffix:  Container(height: 15,width: 30,
              child: GestureDetector(child: Icon(iconTextfiled,size: 14,color: Colors.grey,),
              onTap: (){
                Provider.of<HomeProvieder>(context,listen: false).eyes();
              },
              ),
            ) ,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            labelText: label,
            
            labelStyle: TextStyle(
                fontSize: 12,
                fontFamily: "Cairo",
                color: Color(0xff658199)),
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
      
            /* border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10)),*/
          )),
    ));
  }
}
