import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:capotcha/View/widgets/AppBarcustomer.dart';
import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/navBottom2.dart';
import 'package:capotcha/View/widgets/navfloat2.dart';
import 'package:capotcha/animate_do.dart';

import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/api_client.dart';
import 'package:capotcha/features/repository/sql_table.dart';
import 'package:capotcha/models/cart_modal.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as init;

import '../home_screen.dart';
import 'cart4.dart';

class Talapat3 extends StatefulWidget {
  final String daySelectd;
  final String timeSelectd;
  final String point;
  final String tax;
  final String dsicont;
  final String delivery;
  final String note;
  final String price;

  const Talapat3(
      {Key key,
      this.delivery,
      this.daySelectd,
      this.timeSelectd,
      this.point,
      this.tax,
      this.dsicont,
      this.price,
      this.note})
      : super(key: key);
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<Talapat3>
    with SingleTickerProviderStateMixin {
  int lastSelected = 0;
  bool pointChek = false;
  int x = 0;
  String point = "0";
  TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController =
        TextEditingController(text: widget.point.toString());

    super.initState();
  }

  DateTime dateUtc = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // void _selectedTab(int index) {
  //   setState(() {
  //     lastSelected = index;
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double sizeh = MediaQuery.of(context).size.height;
    double sizew = MediaQuery.of(context).size.width;
    final order = Provider.of<HomeProvieder>(context, listen: false);
    CartModel cartModel;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size(double.infinity, 70),
                  child: AppBarCustomer()),
              body: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Bakeground(),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: ListView(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "الطلب في مرحلة التجهيز",
                              //       style: Style.cairo,
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: MediaQuery.of(context).size.height*0.01,
                              // ),
                              // Divider(),
                              // SizedBox(
                              //   height: MediaQuery.of(context).size.height*0.01,
                              // ),
                              Column(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "  موعد الوصول ",
                                    style: Style.cairo,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "  اليوم : ",
                                        style: Style.cairo,
                                      ),
                                      Text(
                                        "${order.nameDay} ",
                                        style: Style.cairog,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "  التاريخ : ",
                                        style: Style.cairo,
                                      ),
                                      Text(
                                        "${order.tim}",
                                        //  " ${DateTime.now().day} / ${DateTime.now().month}",
                                        style: Style.cairog,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "  التوقيت : ",
                                        style: Style.cairo,
                                      ),
                                      Text(
                                        " ${widget.timeSelectd} ",
                                        style: Style.cairog,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "السعر",
                                    style: Style.cairo,
                                  ),
                                  Text(
                                    "${double.parse(widget.price)} جنيه ",
                                    style: Style.cairo,
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "نقاطي",
                              //       style: Style.cairo,
                              //     ),
                              //     Spacer(),
                              //     Text(
                              //       "${widget.point} جنيه ",
                              //       style: Style.cairo,
                              //     ),
                              //   ],
                              // ),
                              Row(
                                children: [
                                  Text(
                                    "الضريبة",
                                    style: Style.cairo,
                                  ),
                                  Spacer(),
                                  Text(
                                    // "${widget.tax}  جنيه",
                                    "${(order.getPriceCart() * double.parse(widget.tax ?? "0")).toDouble()} جنيه ",
                                    style: Style.cairo,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "الخصم",
                                    style: Style.cairo,
                                  ),
                                  Spacer(),
                                  Text(
                                    "${widget.dsicont} جنيه ",
                                    style: Style.cairo,
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    "التوصيل",
                                    style: Style.cairo,
                                  ),
                                  Spacer(),
                                  Text(
                                    "${widget.delivery} جنيه ",
                                    // "${cartModel.delavery} جنيه ",
                                    style: Style.cairo,
                                  ),
                                ],
                              ),
                              Divider(),

                              Row(
                                children: [
                                  Text(
                                    "اجمالي ",
                                    style: Style.cairo,
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      pointChek == true
                                          ? Text(
                                              "${order.getTotalAfter(widget.tax, widget.delivery, widget.dsicont, point).toDouble()} جنيه ",
                                              style: Style.cairog.copyWith(
                                                  color: AppColors.greenColor),
                                            )
                                          : Container(),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${order.getTotalPrice(widget.tax, widget.delivery, widget.dsicont, "0").toDouble()} جنيه ",
                                        style: pointChek != true
                                            ? Style.cairog
                                            : Style.cairog.copyWith(
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationThickness: 1,
                                                decorationColor: Colors.red,
                                                decorationStyle:
                                                    TextDecorationStyle.wavy,
                                              ),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      activeColor: AppColors.greenColor,
                                      focusColor: AppColors.greenColor,
                                      checkColor: Colors.white,
                                      value: pointChek,
                                      onChanged: (value) async {
                                        pointChek = value;

                                        if (pointChek == false) {
                                          point = "0";
                                          pointChek = value;
                                                                                    setState(() {});

                                        } else {
                                          if (double.parse(widget.point) < 50) {
                                            await Fluttertoast.showToast(
                                                msg: "الرصيد اقل من 50 جنيه",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.TOP,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else if (double.parse(widget.point) >=
                                              order.getTotalPrice(
                                                      widget.tax,
                                                      widget.delivery,
                                                      widget.dsicont,
                                                      "0").toDouble()) {
                                            point = order
                                                .getTotalPrice(
                                                    widget.tax,
                                                    widget.delivery,
                                                    widget.dsicont,
                                                    "0")
                                                .toString();
                                            pointChek = value;
                                                                                 setState(() {});

                                          } else {
                                            point = widget.point;
                                            pointChek = value;
                                                                                      setState(() {});

                                          }
                                        }
                                      }),
                                  Text(
                                    "خصم من المحفظة",
                                    style: Style.cairo.copyWith(fontSize: 16),
                                  ),
                                  Spacer(),
                                  // widget.point
                                  // pointChek == false
                                  //     ? Container()
                                  //     : FadeInDown(
                                  //         duration: Duration(milliseconds: 500),
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 4),
                                  //           child: Container(
                                  //               height: sizeh * 0.06,
                                  //               width: sizew * 0.20,
                                  //               child: Center(
                                  //                 child: TextFormField(
                                  //                     keyboardType:
                                  //                         TextInputType.number,
                                  //                     controller:
                                  //                         textEditingController,
                                  //                     textAlign:
                                  //                         TextAlign.center,
                                  //                     // initialValue:widget.point ?? "0",
                                  //                     onChanged: (value) async {
                                  //                       textEditingController
                                  //                           .text = value;
                                  //                       setState(() {});
                                  //                     },
                                  //                     decoration: InputDecoration(
                                  //                         contentPadding:
                                  //                             EdgeInsets.only(
                                  //                                 top: 10),
                                  //                         filled: true,
                                  //                         fillColor:
                                  //                             Colors.white,
                                  //                         hintText: "",
                                  //                         hintStyle: Style.cairo
                                  //                             .copyWith(
                                  //                                 color: AppColors
                                  //                                     .bluColor
                                  //                                     .withOpacity(
                                  //                                         0.5)),
                                  //                         border: OutlineInputBorder(
                                  //                             borderSide:
                                  //                                 BorderSide
                                  //                                     .none,
                                  //                             borderRadius:
                                  //                                 BorderRadius
                                  //                                     .circular(
                                  //                                         10)))),
                                  //               ),
                                  //               decoration: BoxDecoration(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           10),
                                  //                   boxShadow: <BoxShadow>[
                                  //                     BoxShadow(
                                  //                       color: Colors.grey
                                  //                           .withOpacity(0.2),
                                  //                       spreadRadius: 5,
                                  //                       blurRadius: 7,
                                  //                       offset: Offset(0, 1),
                                  //                     ),
                                  //                   ],
                                  //                   color: Colors.white)),
                                  //         ),
                                  //       ),

                                  Spacer(),

                                  // pointChek == false
                                  //     ? Container()
                                  //     : FadeInDown(
                                  //         duration: Duration(milliseconds: 500),
                                  //         child: Container(
                                  //           decoration: BoxDecoration(
                                  //               borderRadius:
                                  //                   BorderRadius.circular(10),
                                  //               color: AppColors.greenColor),
                                  //           child: RaisedButton(
                                  //               color: Colors.transparent,
                                  //               elevation: 0,
                                  //               onPressed: () async {
                                  //                 if (double.parse(
                                  //                         widget.point) >=
                                  //                     50) {
                                  //                   if (double.parse(point) <
                                  //                       double.parse(
                                  //                           widget.point)) {
                                  //                   } else {
                                  //                     await Fluttertoast.showToast(
                                  //                         msg:
                                  //                             "المبلغ اكبر من  رصيدك الحالي",
                                  //                         toastLength: Toast
                                  //                             .LENGTH_SHORT,
                                  //                         gravity: ToastGravity
                                  //                             .BOTTOM,
                                  //                         timeInSecForIosWeb: 1,
                                  //                         backgroundColor:
                                  //                             Colors.red,
                                  //                         textColor:
                                  //                             Colors.white,
                                  //                         fontSize: 16.0);
                                  //                   }
                                  //                 } else {
                                  //                   await Fluttertoast.showToast(
                                  //                       msg:
                                  //                           "رصيدك اقل من 50 جنيه",
                                  //                       toastLength:
                                  //                           Toast.LENGTH_SHORT,
                                  //                       gravity:
                                  //                           ToastGravity.BOTTOM,
                                  //                       timeInSecForIosWeb: 1,
                                  //                       backgroundColor:
                                  //                           Colors.red,
                                  //                       textColor: Colors.white,
                                  //                       fontSize: 16.0);
                                  //                 }
                                  //               },
                                  //               child: Text(
                                  //                 "تسديد",
                                  //                 style: Style.cairoW,
                                  //               )),
                                  //         ),
                                  //       ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              Text(
                                "طريقة الدفع ",
                                style: Style.cairo,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(

                                      // padding: EdgeInsets.only(right: 20),
                                      height: 50,
                                      width: 100,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "كاش",
                                            style: Style.cairoW,
                                          )),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                          color: AppColors.greenColor)),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 3, color: Color(0xfff658199)),
                                ),
                                child: RaisedButton(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  HomePage()));
                                    },
                                    child: Text(
                                      "تعديل الطلب",
                                      style: Style.cairo,
                                    )),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.greenColor),
                                child: RaisedButton(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    onPressed: () async {
                                      print(point);

                                      double lo = order.lo == null
                                          ? order.completeCart.locationlong
                                          : order.lo;
                                      double la = order.la == null
                                          ? order.completeCart.locationlong
                                          : order.la;
                                      Provider.of<HomeProvieder>(context,
                                              listen: false)
                                          .changeModelhan(true);

                                      await order.setSendOrder(
                                          await DBClint.dbClint.getProductDB(),
                                          await DBClint.dbClint
                                              .getProductCartonDB(),
                                          order.nameDay,
                                          "${order.time}",
                                          order.address,
                                          order.notes,
                                          "$lo",
                                          "$la",
                                          order.mobileSendCart,
                                          point);
                                      if (order.sendOrder.status == true) {
                                        Provider.of<HomeProvieder>(context,
                                                listen: false)
                                            .changeModelhan(false);
                                        AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.SUCCES,
                                            animType: AnimType.TOPSLIDE,
                                            title: order.sendOrder.message,
                                            desc: '',
                                            // btnCancelText: "لا",
                                            btnOkText: "تم",
                                            btnOkColor: AppColors.greenColor,
                                            btnCancelColor: AppColors.bluColor,
                                            btnOkOnPress: () async {
                                              await Provider.of<HomeProvieder>(
                                                      context,
                                                      listen: false)
                                                  .getCartDB();
                                              await Provider.of<HomeProvieder>(
                                                      context,
                                                      listen: false)
                                                  .getCartonDB();
                                              await Provider.of<HomeProvieder>(
                                                      context,
                                                      listen: false)
                                                  .getProfile();
                                              point = "0";
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Talapat4()));
                                            })
                                          ..show();

                                        await order.setOrderId(
                                            order.sendOrder.orderId);
                                        await DBClint.dbClint
                                            .deleteproductAll();
                                      } else {
                                        await Fluttertoast.showToast(
                                            msg: "فشل العملية",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Provider.of<HomeProvieder>(context,
                                                listen: false)
                                            .changeModelhan(false);
                                      }
                                    },
                                    child: Provider.of<HomeProvieder>(
                                              context,
                                            ).isLoad ==
                                            true
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.amber,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      AppColors.greenColor),
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Text(
                                            "تأكيد الطلب",
                                            style: Style.cairoW,
                                          )),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
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
