import 'package:capotcha/modules/Profile/view/support_screen.dart';
import 'package:capotcha/utils/animate_do.dart';
import 'package:capotcha/utils/lunchers_helper.dart';
import 'package:capotcha/utils/shared_preferences_helpar.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/utils/styles.dart';
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
      Get.to(
        () => FadeOut(child: screen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // var tokenProvider = Provider.of<HomeProvieder>(context);
    var sizedBox = SizedBox(
      height: 16.h,
    );
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
          // listTile(
          //   context,
          //   Icons.history,
          //   "سجل الطلبات",
          //   () => getTo(HistoryScreen()),
          // ),
          listTile(
            context,
            Icons.support_agent_outlined,
            "خدمة العملاء",
            () => getTo(SupportScreen()),
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

                Get.offNamed(Routes.SignInScreen);
              },
              child: Center(
                child: ListTile(
                    title: SHelper.sHelper.getToken() == null
                        ? Center(child: Text("تسجيل دخول", style: Style.cairog))
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
                              Text("تسجيل خروج", style: Style.cairo),
                            ],
                          )),
              ),
            ),
          ),
          sizedBox,
          sizedBox,
          sizedBox,

          // SHelper.sHelper.getToken() == null
          //     ? Container()
          //     : Column(
          //         children: [
          //           Divider(),
          //           Align(
          //               alignment: Alignment.centerRight,
          //               child: Text(
          //                 "ادخال كود الخصم ",
          //                 style: Style.cairo,
          //               )),
          //           SizedBox(
          //             height: MediaQuery.of(context).size.height * 0.02,
          //           ),
          //           Container(
          //               height: MediaQuery.of(context).size.height * 0.08,
          //               width: MediaQuery.of(context).size.width,
          //               child: Stack(
          //                 children: [
          //                   TextFormField(
          //                       // enabled: false,
          //                       textAlign: TextAlign.right,
          //                       onChanged: (value) async {
          //                         promo = value;
          //                       },
          //                       decoration: InputDecoration(
          //                           filled: true,
          //                           fillColor: Colors.grey[300],
          //                           hintText: "كود الخصم",
          //                           hintStyle: Style.cairo,
          //                           border: OutlineInputBorder(
          //                               borderSide: BorderSide.none,
          //                               borderRadius:
          //                                   BorderRadius.circular(10)))),
          //                   Padding(
          //                     padding:
          //                         const EdgeInsets.symmetric(horizontal: 30),
          //                     child: Align(
          //                       alignment: Alignment.centerLeft,
          //                       child: GestureDetector(
          //                         onTap: () async {
          //                           promoBool = true;
          //                           await Provider.of<HomeProvieder>(context,
          //                                   listen: false)
          //                               .setPromoCode(promo);
          //                           if (Provider.of<HomeProvieder>(context,
          //                                       listen: false)
          //                                   .promoCode
          //                                   .status ==
          //                               true) {
          //                             promoBool = false;

          //                             await Fluttertoast.showToast(
          //                                 msg: Provider.of<HomeProvieder>(
          //                                         context,
          //                                         listen: false)
          //                                     .promoCode
          //                                     .message,
          //                                 toastLength: Toast.LENGTH_SHORT,
          //                                 gravity: ToastGravity.BOTTOM,
          //                                 timeInSecForIosWeb: 1,
          //                                 backgroundColor:
          //                                     AppColors.greenColor,
          //                                 textColor: Colors.white,
          //                                 fontSize: 16.0);
          //                           } else {
          //                             promoBool = false;

          //                             await Fluttertoast.showToast(
          //                                 msg: Provider.of<HomeProvieder>(
          //                                         context,
          //                                         listen: false)
          //                                     .promoCode
          //                                     .message,
          //                                 toastLength: Toast.LENGTH_SHORT,
          //                                 gravity: ToastGravity.BOTTOM,
          //                                 timeInSecForIosWeb: 1,
          //                                 backgroundColor: Colors.red,
          //                                 textColor: Colors.white,
          //                                 fontSize: 16.0);
          //                           }
          //                           setState(() {});
          //                         },
          //                         child: Container(
          //                           height: 50,
          //                           width: 60,
          //                           child: Center(
          //                             child: Text(
          //                               "تفعيل",
          //                               style: Style.cairog,
          //                               textAlign: TextAlign.center,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10),
          //                   boxShadow: <BoxShadow>[
          //                     BoxShadow(
          //                       color: Colors.grey.withOpacity(0.2),
          //                       spreadRadius: 5,
          //                       blurRadius: 7,
          //                       offset: Offset(
          //                           0, 1), // changes position of shadow
          //                     ),
          //                   ],
          //                   color: Colors.grey[200])),
          //           SizedBox(
          //             height: MediaQuery.of(context).size.height * 0.1,
          //           ),
          //         ],
          //       )
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
          leading: Icon(
            icon,
            size: 30,
          ),
          title: Text(title, style: Style.cairo),
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
