// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownString extends StatelessWidget {
  final String value;
  final List<String>? itemsList;
  final Color dropdownColor, hintColor;
  final String? hint;
  final Function(String?)? onChanged;
  final double height;
  final double fontSize;
  final Color? backgroundColor, fontColor, borderColor, iconColor;

  const CustomDropDownString({
    this.value = "",
    this.itemsList,
    this.hint = "",
    this.dropdownColor = Colors.white,
    this.onChanged,
    this.height = 55,
    this.fontSize = 10,
    this.backgroundColor = Colors.white,
    this.fontColor = Colors.black,
    this.borderColor = Colors.grey,
    this.hintColor = Colors.black,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
        color: backgroundColor,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButton(
        underline: Container(),
        isExpanded: true,
        iconSize: 25.r,
        hint: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            hint!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: hintColor, fontSize: 14.sp, height: 1),
          ),
        ),
        style: Theme.of(context).textTheme.headlineSmall,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: iconColor,
            size: 22.r,
          ),
        ),
        dropdownColor: dropdownColor,
        // value: itemsList[getIndex()],
        items: itemsList!
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black, fontSize: 14.sp),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
