import 'package:capotcha/modules/Products/view/components/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/shimmer_helper.dart';
import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/nav_bar_custom.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../Home/controller/home_controller.dart';
import '../model/product_model.dart';
import '../controller/product_controller.dart';

// ignore: must_be_immutable
class ProductScreen extends StatelessWidget {
  ProductController productController = Get.find();
  // int index = Get.arguments ?? 0;
  HomeController homeController = Get.find();

  Widget fatchApi() {
    return FutureBuilder<List<List<Product>>>(
        future: productController.getProduct(isLoad: true),
        builder: (BuildContext context,
            AsyncSnapshot<List<List<Product>>> snapshot) {
          Widget widget;
          if (snapshot.hasData) {
            widget = fatchCatagri(
              snapshot.data!,
            );
          } else if (snapshot.hasError) {
            widget = Container();
          } else {
            widget = Scaffold(
                appBar: PreferredSize(
                    preferredSize:
                        Size.fromHeight(AppBar().preferredSize.height),
                    child: AppBarCustom(isBack: true, title: "المنتجات")),
                body: ShimmerHelper.loadingProduct());
          }
          return widget;
        });
  }

  Widget fatchCatagri(List<List<Product>>? data) {
    return GetBuilder<ProductController>(
        id: "product",
        builder: (_) => DefaultTabController(
              initialIndex: 0,
              length: data!.length,
              animationDuration: Duration(milliseconds: 500),
              child: Scaffold(
                  appBar: PreferredSize(
                      preferredSize:
                          Size.fromHeight(AppBar().preferredSize.height),
                      child: AppBarCustom(isBack: true, title: "المنتجات")),
                  body: successWidget(data, Get.context),
                  floatingActionButton: NavBarFloatCustom(isHome: false),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar: NavBottomBarCustom(isHome: false)),
            ));
  }

  Widget successWidget(List<List<Product>> data, context) {
    return GetBuilder<ProductController>(
        id: "product",
        builder: (_) => homeController.catogryModel.dataCategory == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: TabBar(
                            automaticIndicatorColorAdjustment: true,
                            tabs: homeController.catogryModel.dataCategory!
                                .map((e) => Tab(text: e.name, height: 33.h))
                                .toList(),
                            isScrollable: true,
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            physics: BouncingScrollPhysics(),
                            indicatorColor: Color(0xff98B119),
                            unselectedLabelColor: Color(0xff658199),
                            labelColor: Colors.white,
                            unselectedLabelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 14.sp, color: AppColors.gryText),
                            indicator: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ))),
                    Expanded(
                      child: TabBarView(
                          children: data
                              .map((tab) => tab.isEmpty
                                  ? Center(
                                      child: Text('لا يوجد منتجات حاليا',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontFamily: 'cairo',
                                              color: Colors.grey[700])),
                                    )
                                  : GridView.builder(
                                      padding: EdgeInsets.only(bottom: 16),
                                      itemCount: tab.length,
                                      itemBuilder: (context, index2) {
                                        if (tab[index2].state == "0") {
                                          return Container();
                                        } else {
                                          return Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ProductItem(
                                                product: tab[index2]),
                                          );
                                        }
                                      },
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.93.h),
                                    ))
                              .toList()),
                    )
                  ],
                ),
              ));
  }

  @override
  Widget build(BuildContext context) {
    return fatchApi();
  }
}
