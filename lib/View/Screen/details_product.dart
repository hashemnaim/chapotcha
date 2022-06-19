import 'package:cached_network_image/cached_network_image.dart';
import 'package:capotcha/View/widgets/conter.dart';

import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/s_helpar.dart';
import 'package:capotcha/features/repository/sql_table.dart';
import 'package:capotcha/models/cart_modal.dart';
import 'package:capotcha/models/carton_model.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/string.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../value/constaint.dart';

class DetailsProduct extends StatefulWidget {
  final CartonModel data;
  final int index;

  const DetailsProduct({Key key, this.data, this.index}) : super(key: key);
  @override
  _DetailsProductState createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  // getData() async {
  //   // await Provider.of<HomeProvieder>(context, listen: false).getCartonDB();
  //   await Provider.of<HomeProvieder>(context, listen: false).getToken();
  // }

  @override
  void initState() {
    // getData();
    super.initState();
  }

  String tagHero = "2";
  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.width;

    final provider = Provider.of<HomeProvieder>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              tagHero = "";
            });
            Navigator.pop(context);
          },
        ),
        title: Text(widget.data.dataCarton[widget.index].name,
            style: Style.cairo.copyWith(fontSize: 20)),
        // actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: sizeH * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: Hero(
                      tag: tagHero,
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl:
                            imgUrl + widget.data.dataCarton[widget.index].image,
                        placeholder: (context, url) => Container(
                          child: Image.asset(
                            "assets/images/shamer.gif",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizeH * 0.01,
                  ),
                  CounterWidget(sizeH * 0.038, sizeW * 0.5,
                      widget.data.dataCarton[widget.index].id, "كرتون",
                      parse: int.parse(
                          widget.data.dataCarton[widget.index].maxQty),
                      stock: int.parse(
                          widget.data.dataCarton[widget.index].stock)),
                  SizedBox(
                    height: sizeH * 0.01,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount:
                        widget.data.dataCarton[widget.index].products.length,
                    itemBuilder: (context, index2) {
                      return ListTile(
                        // tileColor: AppColors.bluColor,
                        leading: Container(
                          child: widget.data.dataCarton[widget.index]
                                      .products[index2].product.image !=
                                  null
                              ? Container(
                                  // height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      // color: AppColors
                                      //     .greenColor,

                                      image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: CachedNetworkImageProvider(imgUrl +
                                        widget.data.dataCarton[widget.index]
                                            .products[index2].product.image),
                                  )),
                                )
                              : Container(
                                  child:
                                      Image.asset("assets/images/shamer.gif"),
                                ),
                        ),
                        title: Text(
                          widget.data.dataCarton[widget.index].products[index2]
                              .product.name,
                          style: Style.cairo,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //     widget.data.dataCarton[widget.index]
                            //         .products[index2].product.maxQty
                            //         .toString(),
                            //     style: TextStyle(
                            //         fontSize: 14,
                            //         fontFamily: 'cairo',
                            //         color: Colors.grey[700])),
                            Text(
                              widget.data.dataCarton[widget.index]
                                  .products[index2].product.unit,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'cairo',
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "جنيه " +
                              widget.data.dataCarton[widget.index].cartonPrice,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'cairo',
                              color: Color(0xff98B119)),
                        ),
                        Spacer(),
                        Text(
                          "الأجمالي",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'cairo',
                              color: Color(0xff98B119)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeH * 0.01,
                  ),
                  Container(
                    height: sizeH * 0.045,
                    child: GestureDetector(
                      onTap: () async {
                        if (SHelper.sHelper.getToken() == null) {
                          awesomeDialog(context)..show();
                        } else {
                          DataCarontCart dataCart = DataCarontCart(
                              cartonId: widget.data.dataCarton[widget.index].id,
                              quantity: provider.quantityMap[widget
                                      .data.dataCarton[widget.index].id] ??
                                  1.0);
                          await DBClint.dbClint.insertCarton(dataCart);
                          await Provider.of<HomeProvieder>(context,
                                  listen: false)
                              .getCartonDB();
                          await Fluttertoast.showToast(
                              msg: "تمت الاضافة",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xff98B119),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          tagHero = "2";
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text("أضف إلى السلة",
                                style:
                                    Style.cairog.copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizeH * 0.01,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
