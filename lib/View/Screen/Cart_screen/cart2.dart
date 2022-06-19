import 'dart:convert';
import 'package:capotcha/View/widgets/AppBarcustomer.dart';
import 'package:capotcha/View/widgets/custom_text.dart';
import 'package:capotcha/View/widgets/isload.dart';
import 'package:capotcha/View/widgets/navBottom2.dart';
import 'package:capotcha/View/widgets/navfloat2.dart';

import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/models/complete_cart.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' as init;
import 'package:provider/provider.dart';

import '../maps.dart';
import 'cart3.dart';

class Talapat2 extends StatefulWidget {
  final String point;
  final String tax;
  final String dsicont;
  final String price;

  const Talapat2({Key key, this.point, this.tax, this.dsicont, this.price})
      : super(key: key);
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<Talapat2>
    with SingleTickerProviderStateMixin {
  int lastSelected = 0;
  bool callme = false;
  bool lastbool = false;
  String mobile = "";
  int x = 0;
  String delivery = "0";
  String day;
  String daySelectd;
  String timeSelectd;
  DateTime dateUtc = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  int countdate;
  int counttime;
  String addreesStreet = "";
  String addreesbuilding = "";
  String addreesFloor = "";
  int call = 0;
  String lastLoS = "";
  String _dropDownValue;
  String _dropDownArea;
  int indexCity = 0;
  int idArea = 0;
  int indexArea = 0;
  List<String> listTime = [];
  String notes = "";
  String addrees;
  String dateFormatter(DateTime date, int i) {
    dynamic dayData =
        '{ "1" : "الاثنين", "2" : "الثلاثاء", "3" : "الاربعاء", "4" : "الخميس", "5" : "الجمعة", "6" : "السبت", "7" : "الاحد" }';
    int dat = date.weekday + i;
    return json.decode(dayData)['${(dat > 7 ? dat - 7 : dat)}'];
  }

  @override
  void initState() {
    mobile = Provider.of<HomeProvieder>(context, listen: false)
        .profilemodal
        .user
        .mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sizeh = MediaQuery.of(context).size.height;
    double sizew = MediaQuery.of(context).size.width;

    final cartModel = Provider.of<HomeProvieder>(context, listen: false);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(double.infinity, sizeh * 0.4),
                  child: AppBarCustomer()),
              body: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 12),
                            child: FutureBuilder<CompleteCart>(
                                future: Provider.of<HomeProvieder>(context,
                                        listen: false)
                                    .getCompleteCart(idArea.toString()),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData) {
                                    CompleteCart completeCart = snapshot.data;

                                    return ListView(
                                      padding: EdgeInsets.zero,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(right: 20),
                                            height: sizeh * 0.05,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "تحديد العنوان",
                                                  style: Style.cairo,
                                                )),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey[300])),
                                        SizedBox(
                                          height: sizeh * 0.01,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        right: 25),
                                                    height: sizeh * 0.05,
                                                    width: sizew * 0.43,
                                                    child: DropdownButton(
                                                      hint: _dropDownValue ==
                                                              null
                                                          ? Text(
                                                              'المدينة',
                                                              style:
                                                                  Style.cairo,
                                                            )
                                                          : Text(
                                                              _dropDownValue,
                                                              style:
                                                                  Style.cairog,
                                                            ),
                                                      isExpanded: true,
                                                      underline: Container(),
                                                      iconSize: 30.0,
                                                      style: Style.cairog,
                                                      items: completeCart.cities
                                                          .map(
                                                        (val) {
                                                          return DropdownMenuItem(
                                                            value: val.name,
                                                            child: Text(
                                                              val.name,
                                                              style:
                                                                  Style.cairog,
                                                            ),
                                                          );
                                                        },
                                                      ).toList(),
                                                      onChanged: (val) {
                                                        setState(
                                                          () {
                                                            _dropDownValue =
                                                                val;
                                                            _dropDownArea =
                                                                null;
                                                            listTime = [];
                                                            indexCity = completeCart
                                                                .cities
                                                                .indexWhere((e) =>
                                                                    e.name ==
                                                                    _dropDownValue);
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset: Offset(0,
                                                                1), // changes position of shadow
                                                          ),
                                                        ],
                                                        color: Colors.white)),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CircleAvatar(
                                                      radius: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                    ))
                                              ],
                                            ),
                                            Stack(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        right: 25),
                                                    height: sizeh * 0.05,
                                                    width: sizew * 0.43,
                                                    child: DropdownButton(
                                                      hint: _dropDownArea ==
                                                              null
                                                          ? Text(
                                                              'الحي',
                                                              style:
                                                                  Style.cairo,
                                                            )
                                                          : Text(
                                                              _dropDownArea,
                                                              style:
                                                                  Style.cairog,
                                                            ),
                                                      isExpanded: true,
                                                      underline: Container(),
                                                      iconSize: 30.0,
                                                      style: Style.cairog,
                                                      items: _dropDownValue ==
                                                              null
                                                          ? []
                                                          : completeCart
                                                              .cities[indexCity]
                                                              .areas
                                                              .map(
                                                              (val) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value:
                                                                      val.name,
                                                                  child: Text(
                                                                    val.name,
                                                                    style: Style
                                                                        .cairog,
                                                                  ),
                                                                );
                                                              },
                                                            ).toList(),
                                                      onChanged: (val) {
                                                        setState(
                                                          () {
                                                            _dropDownArea = val;

                                                            indexArea = completeCart
                                                                .cities[
                                                                    indexCity]
                                                                .areas
                                                                .indexWhere((e) =>
                                                                    e.name ==
                                                                    _dropDownArea);
                                                            listTime = completeCart
                                                                .cities[
                                                                    indexCity]
                                                                .areas[
                                                                    indexArea]
                                                                .shippingTimes;
                                                            idArea = completeCart
                                                                .cities[
                                                                    indexCity]
                                                                .areas[
                                                                    indexArea]
                                                                .id;
                                                            delivery = completeCart
                                                                .cities[
                                                                    indexCity]
                                                                .areas[
                                                                    indexArea]
                                                                .shippingCost;
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset: Offset(0,
                                                                1), // changes position of shadow
                                                          ),
                                                        ],
                                                        color: Colors.white)),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CircleAvatar(
                                                      radius: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Container(
                                            padding: EdgeInsets.only(right: 15),
                                            height: sizeh * 0.06,
                                            width: sizew,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "تاريخ التوصيل ",
                                                  style: Style.cairo,
                                                )),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey[300])),
                                        Divider(),
                                        Container(
                                            height: sizeh * 0.1,
                                            child: ListView.builder(
                                              itemCount: 7,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: sizew * 0.24,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        sizew * 0.005),
                                                    child: GestureDetector(
                                                      onTap:
                                                          //  (cartModel
                                                          //                 .cartModel
                                                          //                 .later ??
                                                          //             1) ==
                                                          //         1
                                                          //     ?
                                                          // index == 0
                                                          //     ? null
                                                          //     :
                                                          () {
                                                        countdate = index;
                                                        Provider.of<HomeProvieder>(
                                                                context,
                                                                listen: false)
                                                            .setNameDay(
                                                                dateFormatter(
                                                                    DateTime
                                                                        .now(),
                                                                    countdate),
                                                                init.DateFormat(
                                                                        "MM/dd")
                                                                    .format(dateUtc.add(
                                                                        Duration(
                                                                            days:
                                                                                index))));
                                                        setState(() {});
                                                        // }
                                                        // : () {
                                                        //     countdate = index;
                                                        //     Provider.of<HomeProvieder>(
                                                        //             context,
                                                        //             listen:
                                                        //                 false)
                                                        //         .setNameDay(
                                                        //             dateFormatter(
                                                        //                 DateTime
                                                        //                     .now(),
                                                        //                 countdate),
                                                        //             "${init.DateFormat("MM/dd").format(dateUtc.add(Duration(days: index)))}");

                                                        //     daySelectd =
                                                        //         dateFormatter(
                                                        //             DateTime
                                                        //                 .now(),
                                                        //             index);
                                                        setState(() {});
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 4),
                                                        child: Container(
                                                          width:
                                                              sizew * 0.01 * 29,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                //  cartModel
                                                                //             .cartModel
                                                                //             .later ==
                                                                //         1
                                                                //     ?
                                                                // index == 0
                                                                //     ? Colors
                                                                //         .grey
                                                                //     :
                                                                index ==
                                                                        countdate
                                                                    ? AppColors
                                                                        .greenColor
                                                                    : Colors
                                                                        .white,
                                                            // : index ==
                                                            //         countdate
                                                            //     ? AppColors
                                                            //         .greenColor
                                                            //     : Colors
                                                            //         .white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: <
                                                                BoxShadow>[
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                spreadRadius: 1,
                                                                blurRadius: 7,
                                                                offset: Offset(
                                                                    0, 1),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    dateFormatter(
                                                                        DateTime
                                                                            .now(),
                                                                        index),
                                                                    style: Style
                                                                        .cairo
                                                                        .copyWith(
                                                                      color: index !=
                                                                              countdate
                                                                          ? AppColors
                                                                              .bluColor
                                                                          : Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                  // SizedBox(
                                                                  //   height:
                                                                  //       sizeh *
                                                                  //           0.01,
                                                                  // ),
                                                                  Text(
                                                                    "${init.DateFormat("MM/dd").format(dateUtc.add(Duration(days: index)))}",
                                                                    style: Style
                                                                        .cairo
                                                                        .copyWith(
                                                                      color: index !=
                                                                              countdate
                                                                          ? AppColors
                                                                              .bluColor
                                                                          : Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              scrollDirection: Axis.horizontal,
                                            )),
                                        Divider(),
                                        listTime.length == 0
                                            ? Center(
                                                child: Text(
                                                  "  يجب عليك تحديد المنطقة / الحي",
                                                  style: Style.cairo.copyWith(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height: sizeh * 0.07,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: completeCart
                                                      .cities[indexCity]
                                                      .areas[indexArea]
                                                      .shippingTimes
                                                      .length,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      width: sizew * 0.24,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            sizew * 0.0071),
                                                        child: GestureDetector(
                                                          onTap:
                                                              // countdate ==
                                                              //             0 ||
                                                              //         countdate ==
                                                              //             null
                                                              //     ? null
                                                              //     :
                                                              completeCart
                                                                          .cities[
                                                                              indexCity]
                                                                          .areas[
                                                                              indexArea]
                                                                          .available ==
                                                                      "1"
                                                                  ? () {
                                                                      counttime =
                                                                          index;

                                                                      timeSelectd = completeCart
                                                                          .cities[
                                                                              indexCity]
                                                                          .areas[
                                                                              indexArea]
                                                                          .shippingTimes[index];

                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  : null,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  // countdate ==
                                                                  //             0 ||
                                                                  //         countdate ==
                                                                  //             null
                                                                  //     ? Colors.grey
                                                                  //     :
                                                                  completeCart.cities[indexCity].areas[indexArea].available ==
                                                                          "1"
                                                                      ? index ==
                                                                              counttime
                                                                          ? AppColors
                                                                              .greenColor
                                                                          : Colors
                                                                              .white
                                                                      : Colors
                                                                          .grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              boxShadow: <
                                                                  BoxShadow>[
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  spreadRadius:
                                                                      3,
                                                                  blurRadius: 7,
                                                                  offset: Offset(
                                                                      0,
                                                                      1), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                            child: Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    completeCart
                                                                        .cities[
                                                                            indexCity]
                                                                        .areas[
                                                                            indexArea]
                                                                        .shippingTimes[index],
                                                                    style: Style
                                                                        .cairo
                                                                        .copyWith(
                                                                      color: completeCart.cities[indexCity].areas[indexArea].available ==
                                                                              "1"
                                                                          ? index != counttime
                                                                              ? AppColors.bluColor
                                                                              : Colors.white
                                                                          : AppColors.bluColor,
                                                                    ),
                                                                  ),
                                                                  // // SizedBox(
                                                                  // //   height: 6,
                                                                  // // ),
                                                                  // Text(
                                                                  //   completeCart
                                                                  //       .cities[
                                                                  //           indexCity]
                                                                  //       .areas[
                                                                  //           indexArea]
                                                                  //       .shippingTimes[index],
                                                                  //   style: Style
                                                                  //       .cairo
                                                                  //       .copyWith(
                                                                  //     color: completeCart.cities[indexCity].areas[indexArea].available ==
                                                                  //             "0"
                                                                  //         ? index != counttime
                                                                  //             ? AppColors.bluColor
                                                                  //             : Colors.white
                                                                  //         : AppColors.bluColor,
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                        listTime.length == 0
                                            ? Container()
                                            : Divider(),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, left: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              cartModel.completeCart
                                                          .lastAddress !=
                                                      ""
                                                  ? Container(
                                                      // height: sizeh * 0.13,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: <
                                                              BoxShadow>[
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              spreadRadius: 5,
                                                              blurRadius: 7,
                                                              offset: Offset(0,
                                                                  1), // changes position of shadow
                                                            ),
                                                          ],
                                                          color: Colors.white),
                                                      child: Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 6,
                                                                      top: 2),
                                                              child: Text(
                                                                "أختر عنوانك القديم",
                                                                style: Style
                                                                    .cairoL
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Checkbox(
                                                                    activeColor:
                                                                        AppColors
                                                                            .greenColor,
                                                                    focusColor:
                                                                        AppColors
                                                                            .greenColor,
                                                                    checkColor:
                                                                        Colors
                                                                            .white,
                                                                    value:
                                                                        lastbool,
                                                                    onChanged:
                                                                        (value) {
                                                                      lastbool =
                                                                          value;
                                                                      print(
                                                                          lastbool);
                                                                      if (lastbool ==
                                                                          false) {
                                                                        lastLoS =
                                                                            "";
                                                                        setState(
                                                                            () {});
                                                                      } else {
                                                                        List<String> test = cartModel
                                                                            .completeCart
                                                                            .lastAddress
                                                                            .split(",");

                                                                        Cities indexCity = completeCart
                                                                            .cities
                                                                            .where((e) =>
                                                                                e.name ==
                                                                                test[0])
                                                                            .first;

                                                                        print(
                                                                            indexCity);
                                                                        print(test[
                                                                            1]);
                                                                        // Areas indexArea = completeCart
                                                                        //     .cities[indexCity
                                                                        //         .id]
                                                                        //     .areas
                                                                        //     .where((e) =>
                                                                        //         e.name ==
                                                                        //         test[1])
                                                                        //     .first;
                                                                        // print(
                                                                        //     indexArea);
                                                                        // idArea = completeCart
                                                                        //     .cities[indexCity.id]
                                                                        //     .areas[indexArea.id]
                                                                        //     .id;
                                                                        // listTime = completeCart
                                                                        //     .cities[indexCity.id]
                                                                        //     .areas[indexArea.id]
                                                                        //     .shippingTimes;

                                                                        lastLoS =
                                                                            cartModel.completeCart.lastAddress ??
                                                                                "";

                                                                        setState(
                                                                            () {});
                                                                      }
                                                                    }),
                                                                Text(
                                                                  cartModel
                                                                          .completeCart
                                                                          .lastAddress ??
                                                                      "",
                                                                  style: Style
                                                                      .cairo,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                  : Container(),
                                              SizedBox(
                                                height: sizeh * 0.01,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                          height: sizeh * 0.06,
                                                          width: sizew * 0.43,
                                                          child: TextFormField(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              onChanged:
                                                                  (value) async {
                                                                addreesStreet =
                                                                    value;
                                                              },
                                                              decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  hintText:
                                                                      "الشارع",
                                                                  hintStyle:
                                                                      Style
                                                                          .cairo,
                                                                  border: OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)))),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  boxShadow: <
                                                                      BoxShadow>[
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          5,
                                                                      blurRadius:
                                                                          7,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                  color: Colors
                                                                      .white)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: CircleAvatar(
                                                          radius: 2,
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Container(
                                                          height: sizeh * 0.06,
                                                          width: sizew * 0.43,
                                                          child: TextFormField(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              //  maxLength: 11,
                                                              initialValue:
                                                                  (mobile ?? "")
                                                                      .toString(),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged:
                                                                  (value) async {
                                                                mobile = value;
                                                                setState(() {});
                                                              },
                                                              decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  hintText:
                                                                      "رقم الموبايل",
                                                                  hintStyle:
                                                                      Style
                                                                          .cairo,
                                                                  border: OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)))),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  boxShadow: <
                                                                      BoxShadow>[
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          5,
                                                                      blurRadius:
                                                                          7,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                  color: Colors
                                                                      .white)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: CircleAvatar(
                                                          radius: 2,
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: sizeh * 0.01,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                          height: sizeh * 0.06,
                                                          width: sizew * 0.43,
                                                          child: TextFormField(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              onChanged:
                                                                  (value) async {
                                                                addreesbuilding =
                                                                    value;
                                                              },
                                                              decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  hintText:
                                                                      "رقم العمارة",
                                                                  hintStyle:
                                                                      Style
                                                                          .cairo,
                                                                  border: OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)))),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  boxShadow: <
                                                                      BoxShadow>[
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          5,
                                                                      blurRadius:
                                                                          7,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                  color: Colors
                                                                      .white)),
                                                    ],
                                                  ),
                                                  Container(

                                                      // padding: EdgeInsets.only(right: 20),
                                                      height: sizeh * 0.06,
                                                      width: sizew * 0.43,
                                                      child: TextFormField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          onChanged:
                                                              (value) async {
                                                            addreesFloor =
                                                                value;
                                                          },
                                                          decoration: InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              hintText:
                                                                  "رقم الشقة",
                                                              hintStyle:
                                                                  Style.cairo,
                                                              border: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)))),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: <
                                                              BoxShadow>[
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              spreadRadius: 5,
                                                              blurRadius: 7,
                                                              offset: Offset(0,
                                                                  1), // changes position of shadow
                                                            ),
                                                          ],
                                                          color: Colors.white)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: sizeh * 0.01,
                                              ),
                                              Container(
                                                height: sizeh * 0.06,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: Offset(0,
                                                            1), // changes position of shadow
                                                      ),
                                                    ],
                                                    color: Colors.white),
                                                child: RaisedButton(
                                                    color: Colors.transparent,
                                                    elevation: 0,
                                                    onPressed: () {
                                                      cartModel.setLoction(
                                                          AppColors.greenColor);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  MapsG()));
                                                      setState(() {});
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "حدد مكاني",
                                                          style: Style.cairo,
                                                        ),
                                                        Icon(Icons.location_on,
                                                            color: completeCart
                                                                        .locationlong ==
                                                                    ""
                                                                ? cartModel
                                                                    .locton
                                                                : AppColors
                                                                    .greenColor),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(
                                                height: sizeh * 0.01,
                                              ),
                                              Container(
                                                  height: sizeh * 0.1,
                                                  child: TextFormField(
                                                      textAlign:
                                                          TextAlign.right,
                                                      onChanged: (value) async {
                                                        notes = value;
                                                      },
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          hintText: "ملاحظات ",
                                                          hintStyle:
                                                              Style.cairo,
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)))),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              1), // changes position of shadow
                                                        ),
                                                      ],
                                                      color: Colors.white)),
                                              SizedBox(
                                                height: sizeh * 0.01,
                                              ),
                                              Container(
                                                height: sizeh * 0.06,
                                                width: sizew,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        AppColors.greenColor),
                                                child: RaisedButton(
                                                    color: Colors.transparent,
                                                    elevation: 0,
                                                    onPressed: () async {
                                                      if (countdate != null &&
                                                          counttime != null) {
                                                        if (mobile.length > 9) {
                                                          if (lastbool ==
                                                              false) {
                                                            if (addreesStreet !=
                                                                "") {
                                                              if (_dropDownValue !=
                                                                      null &&
                                                                  _dropDownArea !=
                                                                      null) {
                                                                addrees = _dropDownValue +
                                                                        "," +
                                                                        _dropDownArea ??
                                                                    "" +
                                                                        "," +
                                                                        addreesStreet +
                                                                        "," +
                                                                        addreesbuilding +
                                                                        "," +
                                                                        addreesFloor;

                                                                await Provider.of<
                                                                            HomeProvieder>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .setSend(
                                                                  " ${DateTime.now().weekday + countdate}",
                                                                  "$counttime",
                                                                  " $addrees",
                                                                  "$mobile",
                                                                  " $notes",
                                                                  delivery,
                                                                );

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            Talapat3(
                                                                              delivery: completeCart.cities[indexCity].areas[indexArea].shippingCost,
                                                                              tax: widget.tax,
                                                                              point: widget.point,
                                                                              dsicont: widget.dsicont,
                                                                              timeSelectd: timeSelectd,
                                                                              price: widget.price,
                                                                            )));
                                                              } else {
                                                                await Fluttertoast.showToast(
                                                                    msg:
                                                                        "يرجى ادخال المدينة  / الحي ",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_SHORT,
                                                                    gravity: ToastGravity
                                                                        .BOTTOM,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        16.0);
                                                              }
                                                            } else {
                                                              await Fluttertoast.showToast(
                                                                  msg:
                                                                      "يرجى ادخال العنوان بالكامل ",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                            }
                                                          } else {
                                                            await Provider.of<
                                                                        HomeProvieder>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .setSend(
                                                                    " ${DateTime.now().weekday + countdate}",
                                                                    "$counttime",
                                                                    " $lastLoS",
                                                                    "$mobile",
                                                                    " $notes",
                                                                    delivery);

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Talapat3(
                                                                              delivery: completeCart.cities[indexCity].areas[indexArea].shippingCost,
                                                                              tax: widget.tax,
                                                                              point: widget.point,
                                                                              dsicont: widget.dsicont,
                                                                              timeSelectd: timeSelectd,
                                                                              price: widget.price,
                                                                            )));
                                                          }
                                                        } else {
                                                          await Fluttertoast.showToast(
                                                              msg:
                                                                  "رقم الموبايل غير صحيح ",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0);
                                                        }
                                                      } else {
                                                        // int number = int.parse(mobile);
                                                        await Fluttertoast.showToast(
                                                            msg:
                                                                "يرجى تحديد موعد/تاريخ التوصيل",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                    },
                                                    child: Text(
                                                      "استمرار",
                                                      style: Style.cairoW,
                                                    )),
                                              ),
                                              SizedBox(
                                                height: sizeh * 0.05,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container(
                                        child: Center(child: IsLoad()));
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: NavFloat2(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: NavCustomer2()),
        ));
  }
}
