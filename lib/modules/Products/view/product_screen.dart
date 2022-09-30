import 'package:capotcha/widgets/nav_bar_custom.dart';

import 'package:capotcha/modules/Products/view/components/product_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../widgets/app_bar_custom.dart';
import '../../../widgets/my_widgets_animator.dart';
import '../../../widgets/nav_float_custom.dart';
import '../../../utils/constants.dart';
import '../../../utils/shimmer_helper.dart';
import 'components/carton_item.dart';
import '../controller/product_controller.dart';

// ignore: must_be_immutable
class ProductScreen extends StatelessWidget {
  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBarCustom(
              isBack: true,
              title: "المنتجات",
            )),
        body: DefaultTabController(
            length: productController.tabs.length,
            initialIndex: Get.arguments ?? 0,
            child: Builder(builder: (context) {
              TabController _tabController = DefaultTabController.of(context)!;
              _tabController.addListener(() async {
                if (!_tabController.indexIsChanging) {
                  productController.ChangeTapIndex(
                    _tabController.index,
                  );
                }
              });

              return Column(children: [
                SizedBox(
                  height: 12.h,
                ),
                TabBar(
                  controller: _tabController,
                  tabs: productController.tabs,
                  isScrollable: true,
                  labelStyle: Theme.of(context).textTheme.headline6,
                  physics: BouncingScrollPhysics(),
                  onTap: (index) async {
                    productController.ChangeTapIndex(
                      index,
                    );
                  },
                  indicatorColor: Color(0xff98B119),
                  unselectedLabelColor: Color(0xff658199),
                  labelColor: Color(0xff98B119),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Expanded(
                  child: Container(
                    decoration: backgroundImage,
                    child: Container(
                      decoration: backgroundImage,
                      child: TabBarView(
                        controller: _tabController,
                        children: productController.tabs.map((Widget tab) {
                          return GetBuilder<ProductController>(
                            initState: (state) {
                              productController.ChangeTapIndex(
                                  productController.tabs.indexOf(tab),
                                  isInite: false);
                            },
                            id: 'product',
                            builder: (_) {
                              return MyWidgetsAnimator(
                                  apiCallStatus: _.productStatus,
                                  loadingWidget: () =>
                                      ShimmerHelper.loadingProduct(),
                                  successWidget: (() => MasonryGridView.count(
                                        padding: EdgeInsets.all(12),
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10.w,
                                        crossAxisSpacing: 15.h,
                                        itemCount: _
                                            .productList[_.indexProductList]
                                            .listProduct!
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return _
                                                      .productList[
                                                          _.indexProductList]
                                                      .name ==
                                                  "Cartona"
                                              ? CartonItem(
                                                  product: _
                                                      .productList[
                                                          _.indexProductList]
                                                      .listProduct![index2])
                                              : ProductItem(
                                                  product: _
                                                      .productList[
                                                          _.indexProductList]
                                                      .listProduct![index2]);
                                        },
                                      )));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              ]);
            })),
        floatingActionButton: NavBarFloatCustom(
          isHome: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBottomBarCustom(
          isHome: false,
        ));
  }
}
