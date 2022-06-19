import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:capotcha/View/Screen/Auth_screen/login_screen.dart';
import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/isload.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/s_helpar.dart';
import 'package:capotcha/models/cart_modal.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/constaint.dart';
import 'package:capotcha/value/string.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../product_screen.dart';
import 'cart2.dart';

class Talapat extends StatefulWidget {
  @override
  _TalapatState createState() => _TalapatState();
}

class _TalapatState extends State<Talapat> {
  setToken() async {
    await Provider.of<HomeProvieder>(context, listen: false).getToken();
  }

  @override
  void initState() {
    setToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProveder = Provider.of<HomeProvieder>(context);
    double sizeH = MediaQuery.of(context).size.height;
    double sizew = MediaQuery.of(context).size.width;

    return Stack(
      fit: StackFit.expand,
      children: [
        Bakeground(),
        Container(
          width: sizew,
          child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: FutureBuilder<CartModel>(
                future: Provider.of<HomeProvieder>(
                  context,
                  listen: false,
                ).setCart(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    CartModel cartModel = snapshot.data;

                    List<DataCart> dataCart = cartModel.dataCart;
                    if (dataCart.length > 0) {
                      return ListView(children: [
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: dataCart.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.startToEnd,
                                    onDismissed:
                                        (DismissDirection direction) async {
                                      direction = DismissDirection.endToStart;
                                      // print(dataCart[index].unit);
                                      dataCart[index].unit == "carton"
                                          ? await Provider.of<HomeProvieder>(
                                                  context,
                                                  listen: false)
                                              .getCartondelet(
                                                  (dataCart[index].productId))
                                          : await Provider.of<HomeProvieder>(
                                                  context,
                                                  listen: false)
                                              .getdelet((dataCart[index]));

                                      dataCart.removeAt(index);
                                      Provider.of<HomeProvieder>(context,
                                              listen: false)
                                          .setCart();

                                      cartProveder.setDataDiscount();
                                    },
                                    background: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 200,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 26,
                                                    width: 26,
                                                    child: SvgPicture.asset(
                                                      "assets/images/delete.svg",
                                                      color: Color(0xFFD9DAD6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.12,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 6)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: sizew * 0.02,
                                                  ),
                                                  dataCart[index].image != null
                                                      ? Container(
                                                          height: sizeH * 0.1,
                                                          width: sizew * 0.2,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    colorFilter: dataCart[index].available ==
                                                                            true
                                                                        ? ColorFilter.mode(
                                                                            Colors.white.withOpacity(
                                                                                0.3),
                                                                            BlendMode
                                                                                .color)
                                                                        : ColorFilter.mode(
                                                                            Colors.black.withOpacity(0.3),
                                                                            BlendMode.darken),
                                                                    image: CachedNetworkImageProvider(
                                                                        imgUrl +
                                                                            dataCart[index].image),
                                                                  )))
                                                      : Container(
                                                          height: sizeH * 0.1,
                                                          width: sizew * 0.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: Colors
                                                                  .grey[100]),
                                                        ),
                                                  SizedBox(
                                                    width: sizew * 0.02,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                          dataCart[index]
                                                              .productName,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .bluColor,
                                                            fontFamily: 'Cairo',
                                                            fontSize: 12.0,
                                                            height: 1.2,
                                                          )),
                                                      Container(
                                                        height: sizeH * 0.051,
                                                        width: sizew * 0.25,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            GestureDetector(
                                                              onTap: cartProveder
                                                                          .maxCleck ==
                                                                      false
                                                                  ? null
                                                                  : () async {
                                                                      await cartProveder.getConter(
                                                                          1,
                                                                          dataCart[index]
                                                                              .productId,
                                                                          dataCart[index]
                                                                              .quantity
                                                                              .toDouble(),
                                                                          dataCart[
                                                                              index],
                                                                          1,
                                                                          dataCart[index]
                                                                              .unit,
                                                                          double.parse(dataCart[index]
                                                                              .maxQty),
                                                                          double.parse(
                                                                              dataCart[index].stock),
                                                                          context);
                                                                    },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: cartProveder
                                                                            .maxCleck ==
                                                                        false
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .green,
                                                                size: 25,
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                cartModel.dataCart[index]
                                                                            .unit ==
                                                                        "كيلو"
                                                                    ? '${cartModel.dataCart[index].quantity.toDouble()}'
                                                                    : '${cartModel.dataCart[index].quantity.toInt()}',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff748A9D),
                                                                    fontFamily:
                                                                        'Cairo'),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                cartProveder
                                                                        .maxCleck =
                                                                    true;
                                                                await cartProveder.getConter(
                                                                    0,
                                                                    dataCart[
                                                                            index]
                                                                        .productId,
                                                                    dataCart[
                                                                            index]
                                                                        .quantity
                                                                        .toDouble(),
                                                                    dataCart[
                                                                        index],
                                                                    0,
                                                                    dataCart[
                                                                            index]
                                                                        .unit,
                                                                    double.parse(
                                                                        dataCart[index]
                                                                            .maxQty),
                                                                    double.parse(
                                                                        dataCart[index]
                                                                            .maxQty),
                                                                    context);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xff748A9D),
                                                                size: 25,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: sizew * 0.23,
                                                  ),
                                                  Expanded(
                                                    child: Column(children: <
                                                        Widget>[
                                                      SizedBox(
                                                        height: sizeH * 0.03,
                                                      ),
                                                      Text(
                                                          "${cartProveder.getPrice(index)} جنيه",
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .bluColor,
                                                            fontFamily: 'Cairo',
                                                            fontSize: 12.0,
                                                            height: 1.2,
                                                          )),
                                                      SizedBox(
                                                        height: sizeH * 0.01,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          await Provider.of<
                                                                      HomeProvieder>(
                                                                  context,
                                                                  listen: false)
                                                              .getdelet(
                                                                  dataCart[
                                                                      index]);
                                                        },
                                                        child: Container(
                                                          height: 26,
                                                          width: 26,
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/delete.svg",
                                                            color: Color(
                                                                0xff98B119),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  )
                                                ],
                                              )),
                                        ),
                                        dataCart[index].available == false
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.12,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                  child: Center(
                                                      child: Text("غير متوفر",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Cairo",
                                                              fontSize: 18))),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ));
                                // );
                              }),
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                Provider.of<HomeProvieder>(context,
                                        listen: false)
                                    .setIndex(0);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ProductScreen(
                                          data: Provider.of<HomeProvieder>(
                                                  context)
                                              .homeModel
                                              .dataCategory,
                                        )));
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                  ),
                                  Text(
                                    "أضافة عنصر جديد ",
                                    style: Style.cairo,
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.greenColor,
                                    child: Icon(Icons.add, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "السعر",
                                  style: Style.cairo,
                                ),
                                Text(
                                  "${cartProveder.getPriceCart()} جنيه ",
                                  style: Style.cairo,
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "نقاطي",
                            //       style: Style.cairo,
                            //     ),
                            //     Text(
                            //       "${double.parse(cartModel.balance)} جنيه ",
                            //       style: Style.cairo,
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "الضريبة",
                            //       style: Style.cairo,
                            //     ),
                            //     Text(
                            //       "${(cartProveder.getPriceCart() * double.parse(cartProveder.setTax())).floor()} جنيه ",
                            //       style: Style.cairo,
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "الخصم",
                            //       style: Style.cairo,
                            //     ),
                            //     Text(
                            //       "${cartProveder.getPriceCart() * double.parse(cartModel.discount)} جنيه ",
                            //       style: Style.cairo,
                            //     ),
                            //   ],
                            // ),

                            Divider(),

                            SizedBox(
                              height: sizeH * 0.01,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: sizew,
                                height: sizeH * 0.065,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: AppColors.greenColor
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: RaisedButton(
                                      color: AppColors.greenColor,
                                      elevation: 0,
                                      onPressed: () async {
                                        Provider.of<HomeProvieder>(context,
                                                listen: false)
                                            .changeModelhan(true);

                                        if (SHelper.sHelper.getToken() ==
                                            null) {
                                          Provider.of<HomeProvieder>(context,
                                                  listen: false)
                                              .changeModelhan(false);
                                          awesomeDialog(context)..show();
                                        } else {
                                          if (cartProveder.getPriceCart() >=
                                              50) {
                                            await Provider.of<HomeProvieder>(
                                                    context,
                                                    listen: false)
                                                .getCompleteCart("0");
                                            Provider.of<HomeProvieder>(context,
                                                    listen: false)
                                                .changeModelhan(false);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Talapat2(
                                                            point: cartModel
                                                                    .balance ??
                                                                "0".toString(),
                                                            dsicont: (cartModel
                                                                        .discount ??
                                                                    "0")
                                                                .toString(),
                                                            tax: (cartModel
                                                                        .tax ??
                                                                    "0")
                                                                .toString(),
                                                            price: cartProveder
                                                                .getPriceCart()
                                                                .toString())));
                                          } else {
                                            Provider.of<HomeProvieder>(context,
                                                    listen: false)
                                                .changeModelhan(false);
                                            Fluttertoast.showToast(
                                                msg: "الطلب أقل من 50 جنية",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
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
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        AppColors.greenColor),
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              "إستمرار",
                                              style: Style.cairoW,
                                            )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: sizeH * 0.05,
                            )
                          ],
                        ),
                      ]);
                    } else {
                      return Container(
                        height: sizeH * 0.8,
                        width: double.infinity,
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              Provider.of<HomeProvieder>(context, listen: false)
                                  .setIndex(0);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductScreen(
                                            data: Provider.of<HomeProvieder>(
                                                    context)
                                                .homeModel
                                                .dataCategory,
                                          )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "أضافة عنصر جديد ",
                                  style: Style.cairo,
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColors.greenColor,
                                  child: Icon(Icons.add, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(child: IsLoad());
                  }
                },
              )),
        )
      ],
    );
    //  : Center(child: IsLoad());
  }
}
// }
