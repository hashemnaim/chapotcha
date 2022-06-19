import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/sql_table.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/constaint.dart';
import 'package:capotcha/value/string.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../features/repository/s_helpar.dart';
import '../../models/cart_modal.dart';
import '../../models/search.dart';
import '../Screen/Auth_screen/login_screen.dart';
import 'conter.dart';
import 'isload.dart';

class ListGridSearch extends StatefulWidget {
  @override
  _ListGridCatagrisState createState() => _ListGridCatagrisState();
}

class _ListGridCatagrisState extends State<ListGridSearch> {
  getData() async {
    await Provider.of<HomeProvieder>(context, listen: false).getCartDB();
    await Provider.of<HomeProvieder>(context, listen: false).getToken();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.width;
    final provider = Provider.of<HomeProvieder>(context, listen: false);
    //var tokenProvider = Provider.of<HomeProvieder>(context,listen: false);

    return FutureBuilder<Search>(
        future: provider.setAllSearch(provider.search),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Search search = snapshot.data;
            List<DataSearch> data = search.dataSearch;
            if (data == null) {
              return Container(child: Center(child: Text("لا يوجد منتجات")));
            } else {
              if (data.length > 0) {
                return AnimationLimiter(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                    itemCount: data.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 200),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Stack(children: [
                                Container(
                                  //      height: sizeH * 0.4,

                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, blurRadius: 6)
                                      ],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: data[index].image != null
                                                ? Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: CachedNetworkImageProvider(
                                                              imgUrl +
                                                                  data[index]
                                                                      .image),
                                                        )),
                                                  )
                                                : Container(
                                                    child: Image.asset(
                                                        "assets/images/shamer.gif"),
                                                  )),
                                      ),
                                      Center(
                                        child: Text(
                                          data[index].name,
                                          style: Style.cairo,
                                        ),
                                      ),
                                      Center(
                                        child: Text.rich(TextSpan(
                                            text: " السعر : ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'cairo',
                                                color: Colors.grey[700]),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                text:
                                                    data[index].oldPrice != "0"
                                                        ? data[index].oldPrice +
                                                            ".0"
                                                        : "",
                                                style: new TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'cairo',
                                                  color: Colors.red,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationThickness: 1,
                                                  decorationColor: Colors.red,
                                                  decorationStyle:
                                                      TextDecorationStyle.wavy,
                                                ),
                                              ),
                                              TextSpan(text: " "),
                                              new TextSpan(
                                                  text:
                                                      "${double.parse(data[index].price)}",
                                                  style: new TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'cairo',
                                                    color: Colors.grey[900],
                                                  )),
                                              new TextSpan(
                                                  text: ' جنيه',
                                                  style: new TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'cairo',
                                                    color: Colors.grey[700],
                                                  )),
                                            ])),
                                      ),
                                      Center(
                                        child: Text(
                                          "${data[index].unit}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'cairo',
                                              color: Colors.grey[900]),
                                        ),
                                      ),
                                      CounterWidget(sizeH * 0.035, sizeW * 0.35,
                                          index, data[index].unit),
                                      Divider(),
                                      Container(
                                        height: sizeH * 0.05,
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (SHelper.sHelper.getToken() ==
                                                null) {
                                              awesomeDialog(context)..show();
                                            } else {
                                              DataCart dataCart = DataCart(
                                                  productId: data[index].id,
                                                  quantity:
                                                      Provider.of<HomeProvieder>(
                                                                  context,
                                                                  listen: false)
                                                              .quantityCart ??
                                                          1.0);

                                              await DBClint.dbClint
                                                  .insertDB(dataCart);

                                              await Provider.of<HomeProvieder>(
                                                      context,
                                                      listen: false)
                                                  .getCartDB();
                                              Provider.of<HomeProvieder>(
                                                      context,
                                                      listen: false)
                                                  .getprdaDB();

                                              await Fluttertoast.showToast(
                                                  msg: "تمت الاضافة",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      Color(0xff98B119),
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          },
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text("اضف الى السلة",
                                                    style: Style.cairog),
                                                Stack(
                                                  children: [
                                                    provider.dataprId.contains(
                                                                data[index]
                                                                    .id) ==
                                                            true
                                                        ? Positioned(
                                                            right: 3,
                                                            child: data[index]
                                                                        .image !=
                                                                    null
                                                                ? CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    backgroundImage:
                                                                        CachedNetworkImageProvider(imgUrl +
                                                                            data[index].image),
                                                                    radius: 8,
                                                                  )
                                                                : CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    radius: 7,
                                                                  ))
                                                        : Container(),
                                                    SvgPicture.asset(
                                                      "assets/images/icon-cart.svg",
                                                      color: provider.dataprId
                                                                  .contains(data[
                                                                          index]
                                                                      .id) ==
                                                              true
                                                          ? AppColors.greenColor
                                                          : AppColors.bluColor,
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                data[index].offer == "1"
                                    ? Container(
                                        alignment: Alignment.topLeft,
                                        height: sizeH * 0.15,
                                        child: Image.asset(
                                            "assets/modal_offer.png",
                                            fit: BoxFit.cover))
                                    : Container(),
                                data[index].status == "0"
                                    ? Container(
                                        //  height: sizeH * 0.4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                        child: Center(
                                            child: Text("غير متوفر",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Cairo",
                                                    fontSize: 18))),
                                      )
                                    : Container()
                              ]),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: sizeH * 0.00085,
                      //  crossAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                  ),
                );
              } else {
                return Center(child: IsLoad());
              }
            }
          } else {
            return Container(child: Center(child: Text("قم بالبحث")));
          }
        });
    // }else{

    // //return  Container(child:Center(child: Text("قم بالبحث")));
    // }
  }
}
