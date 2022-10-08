import 'package:capotcha/utils/constants.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/nav_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../../utils/animate_do.dart';
import '../../Cart/model/cart_model.dart';
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
            child: AppBarCustom(
              isBack: true,
              // title: "تفاصيل المنتج",
            )),
        body: SingleChildScrollView(
          child: Container(
            decoration: backgroundImage,
            child: Column(
              children: [
                Hero(
                  tag: "1",
                  child: Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: CustomNetworkImage(
                      Constants.imgUrl + widget.data!.image!,
                      heigth: 150.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(widget.data!.name!,
                    style: Style.cairog.copyWith(
                        fontSize: 20.sp,
                        height: 1.4,
                        color: AppColors.bluColor)),
                SizedBox(
                  height: 10.h,
                ),
                Text(widget.data!.price.toString() + " " + Constants.currency,
                    style: Style.cairog.copyWith(
                        fontSize: 22.sp,
                        height: 1.4,
                        color: AppColors.bluColor)),
                SizedBox(
                  height: 10.h,
                ),
                GetBuilder<CartController>(
                  id: 'cart',
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () async {
                        await controller.addProductToCart(
                          CartModel(
                            productId: widget.data!.id,
                            productName: widget.data!.name,
                            price: widget.data!.price.toString(),
                            image: widget.data!.image,
                            unit: "كرتونة",
                            quantity: "1.0",
                            maxQty: widget.data!.maxQty.toString(),
                            stock: widget.data!.maxQty.toString(),
                          ),
                        );
                      },
                      child: controller.cartList.indexWhere((element) =>
                                  element.productId == widget.data!.id) ==
                              -1
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(" أضف الى السلة",
                                      style: Style.cairog.copyWith(
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
                                ])
                          : FadeInUp(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                          int index = controller.cartList
                                              .indexWhere((element) =>
                                                  element.productId ==
                                                  widget.id);
                                          await controller.IncreaseQuantity(
                                              index, 1);
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
                                            .cartList[cartController.cartList
                                                .indexWhere((element) =>
                                                    element.productId ==
                                                    widget.id)]
                                            .quantity
                                            .toString(),
                                        style:
                                            Style.cairog.copyWith(fontSize: 16),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          int index = controller.cartList
                                              .indexWhere((element) =>
                                                  element.productId ==
                                                  widget.id);

                                          await controller.decreaseQuantity(
                                              index, 1);
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
                            ),
                    );
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.data!.products!.length,
                  itemBuilder: (context, index2) {
                    return ListTile(
                      // tileColor: AppColors.bluColor,
                      leading: CustomNetworkImage(
                        Constants.imgUrl +
                            widget.data!.products![index2].image!,
                        heigth: 50.h,
                        width: 50.w,
                        fit: BoxFit.fill,
                      ),

                      title: Text(
                        widget.data!.products![index2].name!,
                        style: Style.cairo.copyWith(
                            fontSize: 16.sp,
                            height: 1.4,
                            color: AppColors.greenColor),
                      ),
                      trailing: Text(
                        widget.data!.products![index2].quantity! +
                            " " +
                            widget.data!.products![index2].unit!,
                        style: Style.cairo.copyWith(
                            fontSize: 14.sp,
                            height: 1.4,
                            color: AppColors.bluColor),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: NavBarFloatCustom(
          isHome: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBottomBarCustom(
          isHome: false,
        ));
  }
}
