import 'package:capotcha/modules/Home/view/components/slider_item.dart';
import 'package:capotcha/modules/Home/controller/home_controller.dart';
import 'package:capotcha/utils/shimmer_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/animate_do.dart';
import '../../../utils/colors.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/my_widgets_animator.dart';
import '../../../utils/constants.dart';
import '../../Offer/offer_controller.dart';
import '../../Products/view/components/offer_item_home.dart';
import 'components/categories_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: "home",
      builder: (controller) {
        return MyWidgetsAnimator(
            apiCallStatus: controller.homeStatus,
            loadingWidget: () => ShimmerHelper.loadingHome(),
            successWidget: (() => Container(
                decoration: backgroundImage,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SLiderItem(slider: controller.homeModel.sliders),
                      AppBarCustom(isHome: true),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.h),
                          child: Text("أقوى العروض",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontSize: 18.sp,
                                      color: AppColors.bluColor,
                                      fontWeight: FontWeight.w600))),
                      SizedBox(height: 4.h),
                      Container(
                          height: 175.h,
                          width: 500.w,
                          child: GetBuilder<OfferController>(
                              id: "offer",
                              builder: (controller) {
                                return MyWidgetsAnimator(
                                    apiCallStatus: controller.offerStatus,
                                    loadingWidget: () => Container(
                                        height: 140.h,
                                        child: ShimmerHelper.loadingProduct()),
                                    successWidget: (() => ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.all(4),
                                        itemCount: controller.offerModel.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: FadeInLeft(
                                                  duration: Duration(
                                                      milliseconds: 50 * index),
                                                  child: controller
                                                              .offerModel[index]
                                                              .state ==
                                                          "0"
                                                      ? Container()
                                                      : Container(
                                                          width: 150.w,
                                                          child: OfferItemHome(
                                                              product: controller
                                                                      .offerModel[
                                                                  index]),
                                                        )));
                                        })));
                              })),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.h),
                          child: Text("الأقسام",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontSize: 18.sp,
                                      color: AppColors.bluColor,
                                      fontWeight: FontWeight.w600))),
                      Expanded(
                          child: CategoriesList(
                              data: controller.homeModel.dataCategory))
                    ]))));
      },
    );
  }
}
