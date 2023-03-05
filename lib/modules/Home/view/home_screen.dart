import 'package:capotcha/modules/Home/view/components/slider_item.dart';
import 'package:capotcha/modules/Home/controller/home_controller.dart';
import 'package:capotcha/utils/shimmer_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/my_widgets_animator.dart';
import '../../../utils/constants.dart';
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
                    children: <Widget>[
                      SizedBox(height: 8.h),
                      SLiderItem(slider: controller.homeModel.sliders),
                      Expanded(
                        child: CategoriesList(
                          data: controller.homeModel.dataCategory,
                        ),
                      ),
                    ],
                  ),
                )));
      },
    );
  }
}
