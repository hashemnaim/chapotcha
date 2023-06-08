import 'package:capotcha/utils/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/my_widgets_animator.dart';
import '../../utils/constants.dart';
import '../../utils/shimmer_helper.dart';
import '../Products/view/components/product_item.dart';
import 'offer_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class OffersScreen extends StatelessWidget {
  OfferController offerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundImage,
      child: RefreshIndicator(
        onRefresh: () async {
          await offerController.getOffer(IsLoad: false);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "العروض",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18.sp, color: AppColors.bluColor),
                ),
              ),
              GetBuilder<OfferController>(
                id: "offer",
                // initState: (state) async => await offerController.getOffer(
                //     IsLoad: offerController.offerModel.length == 0),
                builder: (controller) {
                  return MyWidgetsAnimator(
                      apiCallStatus: controller.offerStatus,
                      loadingWidget: () => ShimmerHelper.loadingProduct(),
                      successWidget: (() => controller.offerModel.isEmpty
                          ? Center(
                              child: Text('لا يوجد عروض حاليا',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'cairo',
                                    color: Colors.grey[700],
                                  )),
                            )
                          : MasonryGridView.count(
                              padding: EdgeInsets.only(
                                  bottom: 25.h,
                                  top: 8.h,
                                  left: 8.w,
                                  right: 8.w),
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.w,
                              crossAxisSpacing: 10.h,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: controller.offerModel.length,
                              itemBuilder: (context, index) {
                                return controller.offerModel[index].state == "0"
                                    ? Container()
                                    : FadeInLeft(
                                        duration:
                                            Duration(milliseconds: 50 * index),
                                        child: ProductItem(
                                            product:
                                                controller.offerModel[index]),
                                      );
                              },
                            )));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
