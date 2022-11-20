import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../../utils/valdtion_helper.dart';
import '../../../../widgets/custom_svg.dart';
import '../../../../widgets/form_field_item.dart';

class FormPassword extends StatelessWidget {
  const FormPassword({
    required this.passwordController,
    required this.obscure,
    required this.isobscure,
  });
  final TextEditingController passwordController;
  final ValueChanged<bool> obscure;
  final bool isobscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'كلمة المرور',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontSize: 16.sp,
              ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          // height: 65.h,
          child: FormFieldItem(
            textInputType: TextInputType.text,
            labelText: '* * * * * * *',
            validator: (value) =>
                ValidationHelper.validationHelper.validatePassword(value),
            textInputAction: TextInputAction.done,
            obscureText: isobscure,
            backgroundColor: Colors.grey[250],
            onChange: (vlaue) {},
            suffixIconWidget: InkWell(
              onTap: () {
                obscure(!isobscure);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: isobscure == false
                    ? const Icon(Icons.remove_red_eye_outlined,
                        color: LightThemeColors.body2TextColor)
                    : const CustomSvgImage(
                        "hide_eye",
                      ),
              ),
            ),
            editingController: passwordController,
            type: false,
          ),
        ),
      ],
    );
  }
}
