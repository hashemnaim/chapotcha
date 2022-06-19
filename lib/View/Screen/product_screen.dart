import 'package:capotcha/View/widgets/AppBarcustomer.dart';
import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/list_carton.dart';
import 'package:capotcha/View/widgets/list_grid_catagris.dart';
import 'package:capotcha/View/widgets/navBottom2.dart';
import 'package:capotcha/View/widgets/navfloat2.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/models/home_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final List<DataCategory> data;

  const ProductScreen({Key key, this.data}) : super(key: key);
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<ProductScreen> {
  // List<DataCategory> data =
  //     Provider.of<HomeProvieder>(context).homeModel.dataCategory;
  List<Widget> tabs = [];
  @override
  void initState() {
    tabs = widget.data
        .map((e) => Container(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(e.name),
            )))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        initialIndex: Provider.of<HomeProvieder>(context).index,
        child: Builder(builder: (context) {
          TabController _tabController = DefaultTabController.of(context);
          _tabController.addListener(() {
            if (!_tabController.indexIsChanging) {
              Provider.of<HomeProvieder>(context, listen: false)
                  .setIndex(_tabController.index);
            }
          });
          double sizeh = MediaQuery.of(context).size.height;
          return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: PreferredSize(
                        preferredSize: Size(double.infinity, sizeh * 0.07),
                        child: AppBarCustomer()),
                    body: Column(children: [
                      Divider(),
                      TabBar(
                        controller: _tabController,
                        tabs: tabs,
                        isScrollable: true,
                        physics: BouncingScrollPhysics(),
                        onTap: (index) async {
                          Provider.of<HomeProvieder>(context, listen: false)
                              .setIndex(_tabController.index);
                        },
                        indicatorColor: Color(0xff98B119),
                        unselectedLabelColor: Color(0xff658199),
                        labelColor: Color(0xff98B119),
                      ),
                      // widget.data[_tabController.index].prepare == "1"
                      //     ? Container(
                      //         width: double.infinity,
                      //         height: MediaQuery.of(context).size.height * 0.06,
                      //         color: AppColors.greenColor,
                      //         child: Center(
                      //             child: Text(
                      //                 "علما ان الطلبات المجهزة تصلك في اليوم الثاني من الطلب ",
                      //                 style: Style.cairoPro)),
                      //       )
                      //     : Container(),
                      Expanded(
                        child: Stack(
                          children: [
                            Bakeground(),
                            TabBarView(
                              controller: _tabController,
                              children: tabs.map((Widget tab) {
                                if (widget
                                        .data[_tabController.index].isCarton ==
                                    "1") {
                                  return ListCarton(
                                    data: Provider.of<HomeProvieder>(context)
                                        .cartonModel,
                                  );
                                } else {
                                  return ListGridCatagris(
                                      // data: widget.data,
                                      );
                                }
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                      Hero(
                        tag: "2",
                        child: Container(
                          //color:Colors.amber,
                          height: 1,
                          width: 1,

                          child: Image.asset(
                            "assets/im1.png",
                          ),
                        ),
                      ),
                    ]),
                    floatingActionButton: NavFloat2(),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    bottomNavigationBar: NavCustomer2()),
              ));
        }));
  }
}
