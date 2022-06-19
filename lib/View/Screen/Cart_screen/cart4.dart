import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/isload.dart';
import 'package:capotcha/View/widgets/navBottom2.dart';
import 'package:capotcha/View/widgets/navfloat2.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/models/order.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Talapat4 extends StatefulWidget {
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<Talapat4>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double sizeh = MediaQuery.of(context).size.height;
    double sizew = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size(double.infinity, 50),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Center(
                              child: Text(
                                "تتبع الطلب",
                                style: TextStyle(
                                  color: AppColors.bluColor,
                                  fontFamily: 'Cairo',
                                  fontSize: 20.0,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              body: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Bakeground(),
                        FutureBuilder<OrderFollow>(
                          future: Provider.of<HomeProvieder>(context,
                                  listen: false)
                              .getOrder(
                                  "${Provider.of<HomeProvieder>(context).orderId}"),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              OrderFollow date = snapshot.data;

                              return Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Container(
                                        height: sizeh * 0.14,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            StepProgressIndicator(
                                              totalSteps: 20,
                                              padding: 2,
                                              currentStep: 6,
                                              selectedColor:
                                                  date.orders.status ==
                                                          "تم التسليم"
                                                      ? AppColors.greenColor
                                                      : Colors.grey,
                                              unselectedColor:
                                                  AppColors.greenColor,
                                            ),
                                            Positioned(
                                              top: sizeh * 0.035,
                                              left: sizew * 0.2,
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 23,
                                                    backgroundColor:
                                                        AppColors.greenColor,
                                                    child: Icon(Icons.done,
                                                        color: Colors.white),
                                                  ),
                                                  // SizedBox(height: sizeh * 0.01),
                                                  Text(
                                                    "قيد التنفيد",
                                                    style: Style.cairogX,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: sizeh * 0.035,
                                              left: 0,
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 23,
                                                    backgroundColor:
                                                        AppColors.greenColor,
                                                    child: Icon(Icons.done,
                                                        color: Colors.white),
                                                  ),
                                                  //SizedBox(height: sizeh * 0.01),
                                                  Text(
                                                    "اضافة",
                                                    style: Style.cairogX,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: sizeh * 0.035,
                                              right: 0,
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 23,
                                                      backgroundColor: date
                                                                  .orders
                                                                  .status ==
                                                              "تم التسليم"
                                                          ? AppColors.greenColor
                                                          : Colors.grey,
                                                      child: date.orders
                                                                  .status ==
                                                              "تم التسليم"
                                                          ? Icon(Icons.done,
                                                              color:
                                                                  Colors.white)
                                                          : Container()),
                                                  //  SizedBox(height: sizeh * 0.01),
                                                  Text(
                                                    "استلام",
                                                    style: Style.cairogg,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: sizeh * 0.035,
                                              right: sizew * 0.25,
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 23,
                                                      backgroundColor: date
                                                                      .orders
                                                                      .status ==
                                                                  "قيد التوصيل" ||
                                                              date.orders
                                                                      .status ==
                                                                  "تم التسليم"
                                                          ? AppColors.greenColor
                                                          : Colors.grey,
                                                      child: date.orders
                                                                      .status ==
                                                                  "قيد التوصيل" ||
                                                              date.orders
                                                                      .status ==
                                                                  "تم التسليم"
                                                          ? Icon(Icons.done,
                                                              color:
                                                                  Colors.white)
                                                          : Container()),
                                                  //     SizedBox(height: sizeh * 0.01),
                                                  Text(
                                                    "قيد التوصيل",
                                                    style: Style.cairogg,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: sizeh * 0.01,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Container(
                                              // height: 600,
                                              child: Column(
                                                //  mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: sizeh * 0.01,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                      "رقم طلبك  ${date.orders.orderId}",
                                                      style: Style.cairog,
                                                    ),
                                                  ),
                                                  Divider(),
                                                  // SizedBox(
                                                  //   height: sizeh * 0.01,
                                                  // ),
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Container(
                                                        // height: 400,
                                                        child: Column(
                                                          children: [
                                                            date.orders.productsOrder
                                                                        .length ==
                                                                    0
                                                                ? Container()
                                                                : Container(
                                                                    height: date
                                                                            .orders
                                                                            .productsOrder
                                                                            .length *
                                                                        60.0,
                                                                    child: ListView.builder(
                                                                        primary: false,
                                                                        shrinkWrap: true,
                                                                        padding: EdgeInsets.zero,
                                                                        itemCount: date.orders.productsOrder.length,
                                                                        itemBuilder: (context, index) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 10),
                                                                            child:
                                                                                new Container(
                                                                              child: new Row(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(5.0),
                                                                                      child: new Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: <Widget>[
                                                                                          new Container(
                                                                                            child: Text(
                                                                                              date.orders.productsOrder[index].productName,
                                                                                              style: Style.cairo,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(10.0),
                                                                                      child: new Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: <Widget>[
                                                                                          new Container(
                                                                                            child: Text(
                                                                                              "كيلو  ${double.parse(date.orders.productsOrder[index].quantity)}",
                                                                                              style: Style.cairo,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(right: 8),
                                                                                      child: new Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: <Widget>[
                                                                                          new Container(
                                                                                            child: Text(
                                                                                              ""
                                                                                              "${double.parse(date.orders.productsOrder[index].price) * double.parse(date.orders.productsOrder[index].quantity)} جنيه",
                                                                                              style: Style.cairo,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ),
                                                            date.orders.cartons
                                                                        .length ==
                                                                    0
                                                                ? Container()
                                                                : Container(
                                                                    height: date
                                                                            .orders
                                                                            .cartons
                                                                            .length *
                                                                        60.0,
                                                                    child: ListView.builder(
                                                                        primary: false,
                                                                        shrinkWrap: true,
                                                                        padding: EdgeInsets.zero,
                                                                        itemCount: date.orders.cartons.length,
                                                                        itemBuilder: (context, index) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 10),
                                                                            child:
                                                                                new Container(
                                                                              child: new Row(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(5.0),
                                                                                      child: new Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: <Widget>[
                                                                                          new Container(
                                                                                            child: Text(
                                                                                              date.orders.cartons[index].cartonName,
                                                                                              style: Style.cairo,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(10.0),
                                                                                      child: new Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: <Widget>[
                                                                                          new Container(
                                                                                            child: Text(
                                                                                              "كرتونة  ${double.parse(date.orders.cartons[index].cartonQuantity)}",
                                                                                              style: Style.cairo,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(right: 8),
                                                                                      child: new Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: <Widget>[
                                                                                          new Container(
                                                                                            child: Text(
                                                                                              ""
                                                                                              "${double.parse(date.orders.cartons[index].cartonPrice) * double.parse(date.orders.cartons[index].cartonQuantity)} جنيه",
                                                                                              style: Style.cairo,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                child: Center(child: IsLoad()),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              floatingActionButton: NavFloat2(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: NavCustomer2()),
        ));
  }
}
