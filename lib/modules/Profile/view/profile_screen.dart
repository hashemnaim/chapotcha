import 'package:capotcha/utils/animate_do.dart';
import 'package:capotcha/utils/lunchers_helper.dart';
import 'package:capotcha/utils/shared_preferences_helpar.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/helper/db_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';
import 'about_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  getTo(Widget screen) {
    if (SHelper.sHelper.getToken() == null) {
      Get.toNamed(Routes.SignInScreen);
    } else {
      Get.to(() => FadeOut(child: screen));
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 16.h);
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20.h),
      decoration: backgroundImage,
      child: Column(
        children: <Widget>[
          SHelper.sHelper.getToken() == null
              ? Container()
              : listTile(
                  context,
                  Icons.person,
                  "حسابي",
                  () => getTo(EditProfileScreen()),
                ),
          sizedBox,
          SHelper.sHelper.getToken() == null
              ? Container()
              : listTile(
                  context,
                  Icons.location_on_outlined,
                  "العنوان",
                  () => Get.toNamed(
                        Routes.AddAddressScreen,
                      )),
          sizedBox,
          listTile(
            context,
            Icons.support_agent_outlined,
            "خدمة العملاء",
            () =>
                LuncherHelper.validationHelper.launchWhatsApp(message: "اريد"),
          ),
          sizedBox,
          listTile(
            context,
            Icons.info,
            "عن كابوتشا",
            () => getTo(AboutScreeen()),
          ),
          sizedBox,
          listTile(
              context,
              Icons.rate_review,
              "تقييم التطبيق",
              () => LuncherHelper.validationHelper.launchURL(
                  'https://play.google.com/store/apps/details?id=com.capotcha.capotcha')),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3, color: AppColors.greenColor),
            ),
            child: InkWell(
              onTap: () async {
                await SHelper.sHelper.clearSp();
                await DBHelper.dbHelper.deleteproductAll();

                Get.toNamed(Routes.SignInScreen);
              },
              child: Center(
                child: ListTile(
                    title: SHelper.sHelper.getToken() == null
                        ? Center(
                            child: Text("تسجيل دخول",
                                style: Theme.of(context).textTheme.titleLarge!))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.exit_to_app,
                                size: 30,
                                color: AppColors.greenColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "تسجيل خروج",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: AppColors.btnColor,
                                        fontSize: 20),
                              ),
                            ],
                          )),
              ),
            ),
          ),
          sizedBox,
          sizedBox,
          sizedBox,
        ],
      ),
    );
  }

  Container listTile(
      BuildContext context, IconData icon, String title, Function onTap) {
    return Container(
      alignment: Alignment.center,
      height: 90.h,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 10)],
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: ListTile(
          leading: Icon(icon, size: 30),
          title: Text(title, style: Theme.of(context).textTheme.titleLarge!),
          trailing: Container(
            alignment: Alignment.centerLeft,
            height: double.infinity,
            width: MediaQuery.of(context).size.width * 0.1,
            //color: Colors.amber,
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
    );
  }
}
