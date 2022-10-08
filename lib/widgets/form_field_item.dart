import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

// ignore: must_be_immutable
class FormFieldItem extends StatelessWidget {
  FormFieldItem({
    Key? key,
    this.textInputType,
    this.labelText,
    this.obscureText = false,
    this.suffixIconWidget,
    this.prefixIcon,
    this.validator,
    this.onChange,
    this.editingController,
    this.textInputAction,
    this.type = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final TextInputType? textInputType;
  final String? labelText;
  final bool obscureText;
  final Widget? suffixIconWidget;
  final Widget? prefixIcon;
  final Function? validator;
  Color? backgroundColor = Colors.white;
  final Function? onChange;
  final TextEditingController? editingController;
  final TextInputAction? textInputAction;
  final bool type;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: type,
      controller: editingController,
      cursorColor: AppColors.gryText,
      obscureText: obscureText,
      textInputAction: textInputAction,
      scrollPadding: EdgeInsets.zero,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: (String value) => onChange!(value),
      keyboardType: textInputType,
      validator: (String? value) => validator!(value),
      decoration: InputDecoration(
        suffixIcon: suffixIconWidget,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        // contentPadding: const EdgeInsets.all(10),
        hintText: labelText,
        hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
            color: AppColors.gryText,
            fontWeight: FontWeight.normal,
            fontSize: 12.sp,
            height: 1),
        filled: true,
        fillColor: backgroundColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusColor: Colors.grey,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
