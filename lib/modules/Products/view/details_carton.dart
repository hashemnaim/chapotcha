import 'dart:developer';

import 'package:capotcha/utils/constants.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/shared_preferences_helpar.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/nav_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../../utils/animate_do.dart';
import '../../Cart/controller/cart_controller.dart';
import '../model/cartona_model.dart';

class DetailsProduct extends StatefulWidget {
  final DataCartona? data;
  final int? id;

  const DetailsProduct({Key? key, this.data, this.id}) : super(key: key);
  @override
  _DetailsProductState createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBarCustom(isBack: true)),
        body: SingleChildScrollView(
          child: Container(
            decoration: backgroundImage,
            child: Column(children: [
              Hero(
                tag: "1",
                child: Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: CustomNetworkImage(
                    Constants.imgUrl + widget.data!.image!,
                    fit: BoxFit.contain,
                    heigth: 110.h,
                    width: Get.width,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(widget.data!.name!,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20.sp, height: 1.4, color: AppColors.bluColor)),
              SizedBox(height: 10.h),
              Text(
                  widget.data!.price!.toStringAsFixed(2) +
                      " " +
                      Constants.currency,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 22.sp, height: 1.4, color: AppColors.bluColor)),
              SizedBox(height: 10.h),
              GetBuilder<CartController>(
                  id: 'cart${widget.data!.name}',
                  builder: (controller) {
                    if (controller.cartApiModel.data != null) {
                      if (controller.isUpdateCartload == true) {
                        return Container(
                          width: 114.w,
                          child: SpinKitThreeBounce(
                            color: AppColors.greenColor,
                            size: 20.0,
                          ),
                        );
                      } else {
                        if (controller.cartApiModel.data!.items!.indexWhere(
                                (element) =>
                                    element.cartonName == widget.data!.name) ==
                            -1) {
                          return GestureDetector(
                            onTap: () async {
                              log(SHelper.sHelper.getToken().toString());
                              if (SHelper.sHelper.getToken() == null) {
                                Get.toNamed(Routes.SignUpScreen);
                              } else {
                                await controller.addCartonCart(
                                    widget.data!.id!, widget.data!.name!);
                              }
                            },
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(" أضف الى السلة",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontSize: 16.sp, height: 1.3)),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  CustomSvgImage(
                                    "icon-cart",
                                    color: AppColors.greenColor,
                                    isColor: true,
                                    height: 25.h,
                                  ),
                                ]),
                          );
                        } else {
                          return FadeInUp(
                            duration: Duration(milliseconds: 200),
                            child: Container(
                              width: 150.w,
                              decoration: BoxDecoration(
                                color: AppColors.bluColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        int index = controller
                                            .cartApiModel.data!.items!
                                            .indexWhere((element) =>
                                                element.cartonName ==
                                                widget.data!.name);
                                        await controller.IncreaseCartonQuantity(
                                            index,
                                            controller.cartApiModel.data!
                                                .items![index].itemId,
                                            1);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 35,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.green,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      cartController
                                          .cartApiModel
                                          .data!
                                          .items![controller
                                              .cartApiModel.data!.items!
                                              .indexWhere((element) =>
                                                  element.cartonName ==
                                                  widget.data!.name)]
                                          .qty!
                                          .substring(0, 3),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        int index = controller
                                            .cartApiModel.data!.items!
                                            .indexWhere((element) =>
                                                element.cartonName ==
                                                widget.data!.name);

                                        await controller
                                            .decreaseCartoneQuantity(
                                                index,
                                                controller.cartApiModel.data!
                                                    .items![index].itemId,
                                                1);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 35,
                                        child: Icon(
                                          Icons.remove,
                                          color: Color(0xff748A9D),
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      return InkWell(
                          onTap: () async {
                            if (SHelper.sHelper.getToken() == null) {
                              Get.toNamed(Routes.SignUpScreen);
                            } else {
                              await controller.addCartonCart(
                                  widget.data!.id!, widget.data!.name!);
                            }
                          },
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(" أضف الى السلة",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontSize: 16.sp, height: 1.3)),
                                SizedBox(width: 5.w),
                                CustomSvgImage(
                                  "icon-cart",
                                  color: AppColors.greenColor,
                                  isColor: true,
                                  height: 25.h,
                                ),
                              ]));
                    }
                  }),
              SizedBox(height: 10.h),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: widget.data!.products!.length,
                itemBuilder: (context, index2) {
                  return ListTile(
                    leading: CustomNetworkImage(
                      Constants.imgUrl + widget.data!.products![index2].image!,
                      heigth: 50.h,
                      width: 50.w,
                      fit: BoxFit.fill,
                    ),
                    title: Text(
                      widget.data!.products![index2].name!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16.sp,
                          height: 1.4,
                          color: AppColors.greenColor),
                    ),
                    trailing: Text(
                        widget.data!.products![index2].quantity! +
                            " " +
                            widget.data!.products![index2].unit!,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 14.sp,
                            height: 1.4,
                            color: AppColors.bluColor)),
                  );
                },
              ),
              SizedBox(height: 10.h)
            ]),
          ),
        ),
        floatingActionButton: NavBarFloatCustom(isHome: false),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBottomBarCustom(isHome: false));
  }
}
