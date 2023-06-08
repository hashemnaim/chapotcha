import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/valdtion_helper.dart';
import '../../../../widgets/form_field_item.dart';

class FormPhone extends StatelessWidget {
  const FormPhone({
    required this.phoneController,
  });

  final TextEditingController phoneController;
  // final ValueChanged<String> codeCountry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "رقم الموبايل",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16.sp,
              ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          // height: 65.h,
          child: FormFieldItem(
            textInputType: TextInputType.phone,
            labelText: "01XXXXXXXXX",
            validator: (value) =>
                ValidationHelper.validationHelper.validatePassword(value),
            textInputAction: TextInputAction.next,
            backgroundColor: Colors.grey[250],
            editingController: phoneController,
            type: false,
            onChange: (vlaue) {},
            // prefixIcon: Padding(
            //   padding: EdgeInsets.only(right: 6.w),
            //   child: CountryPickerDropdown(
            //     initialValue: 'EG',
            //     itemBuilder: _buildDropdownItem,
            //     itemFilter: (c) => [
            //       'EG',
            //     ].contains(c.isoCode),
            //     onValuePicked: (Country country) {
            //       // codeCountry(country.isoCode);
            //     },
            //   ),
            // ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownItem(Country country) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 4.w,
          ),
          SizedBox(child: Text("+${country.phoneCode}")),
        ],
      );
}
