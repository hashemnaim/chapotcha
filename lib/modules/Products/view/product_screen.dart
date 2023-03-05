import 'package:capotcha/widgets/nav_bar_custom.dart';
import 'package:capotcha/modules/Products/view/components/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../../utils/shimmer_helper.dart';
import '../../Home/controller/home_controller.dart';
import '../model/product_model.dart';
import '../controller/product_controller.dart';
import 'components/carton_item.dart';

// ignore: must_be_immutable
class ProductScreen extends StatelessWidget {
  ProductController productController = Get.find();
  int index = Get.arguments ?? 0;
  HomeController homeController = Get.find();

  Widget fatchApi() {
    return FutureBuilder<List<List<Product>>>(
        future: productController.getProduct(isLoad: true),
        builder: (BuildContext context,
            AsyncSnapshot<List<List<Product>>> snapshot) {
          Widget widget;
          if (snapshot.hasData) {
            widget = successWidget(snapshot.data!, context);
          } else if (snapshot.hasError) {
            widget = Container();
          } else {
            widget = ShimmerHelper.loadingProduct();
          }
          return widget;
        });
  }

  Widget fatchCatagri() {
    return FutureBuilder<List<List<Product>>>(
        future: productController.getProduct(isLoad: true),
        builder: (BuildContext context,
            AsyncSnapshot<List<List<Product>>> snapshot) {
          Widget widget;
          if (snapshot.hasData) {
            widget = successWidget(snapshot.data!, context);
          } else if (snapshot.hasError) {
            widget = Container();
          } else {
            widget = Center(child: ShimmerHelper.loadingProduct());
          }
          return widget;
        });
  }

  Widget successWidget(List<List<Product>> data, context) {
    return GetBuilder<ProductController>(
        id: "product",
        builder: (_) => Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: TabBar(
                      automaticIndicatorColorAdjustment: true,
                      tabs: homeController.homeModel.dataCategory!
                          .map((e) => Tab(
                                text: e.name,
                                height: 33,
                              ))
                          .toList(),
                      isScrollable: true,
                      labelStyle: Theme.of(context).textTheme.headline6,
                      physics: BouncingScrollPhysics(),
                      indicatorColor: Color(0xff98B119),
                      unselectedLabelColor: Color(0xff658199),
                      labelColor: Colors.white,
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14.sp, color: AppColors.gryText),
                      indicator: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ),
                // index == 1
                //     ? Container(
                //         height: 30,
                //         color: AppColors.greenColor,
                //         width: Get.width,
                //         child: Center(
                //           child: Text(
                //               "ملاحظة : الطلب من قسم اللحوم يبدا من الساعة ٣ عصرا",
                //               textAlign: TextAlign.center,
                //               style: Style.cairog.copyWith(
                //                   fontSize: 14.sp,
                //                   height: 1.3,
                //                   color: Colors.white)),
                //         ),
                //       )
                //     : SizedBox.shrink(),

                Expanded(
                  child: TabBarView(
                      children: data
                          .map((tab) => tab.length == 0
                              ? _.cartonaModel.data == null
                                  ? Container()
                                  : MasonryGridView.count(
                                      padding: EdgeInsets.all(8),
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10.w,
                                      crossAxisSpacing: 15.h,
                                      itemCount: _.cartonaModel.data!.length,
                                      itemBuilder: (context, index2) {
                                        return CartonItem(
                                            product:
                                                _.cartonaModel.data![index2]);
                                      })
                              : MasonryGridView.count(
                                  padding: EdgeInsets.all(8),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.w,
                                  crossAxisSpacing: 15.h,
                                  itemCount: tab.length,
                                  itemBuilder: (context, index2) {
                                    return ProductItem(product: tab[index2]);
                                  },
                                ))
                          .toList()),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: index,
      length: homeController.homeModel.dataCategory!.length,
      animationDuration: Duration(milliseconds: 500),
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: AppBarCustom(isBack: true, title: "المنتجات")),
          body: fatchApi(),
          floatingActionButton: NavBarFloatCustom(isHome: false),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: NavBottomBarCustom(isHome: false)),
    );
  }
}
