import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/custom_button.dart';

class PermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.add_location_alt_rounded,
                color: Theme.of(context).primaryColor, size: 100),
            SizedBox(height: 12),
            Text(
              'يرجى تفعيل استخدام موقعك لإظهار الخدمات القريبة على الخريطة',
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
                    minimumSize: Size(1, 50),
                  ),
                  child: Text('إلغاء'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                  child: CustomButton(
                      buttonText: 'إعدادات',
                      onPressed: () async {
                        await Geolocator.openAppSettings();
                        Navigator.pop(context);
                      })),
            ]),
          ]),
        ),
      ),
    );
  }
}
