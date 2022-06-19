import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:capotcha/View/widgets/conter.dart';
// import 'package:capotcha/components/models/cart_modal.dart';
// import 'package:capotcha/components/models/home_model.dart';
// import 'package:capotcha/components/widgets/conter.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/features/repository/sql_table.dart';
// import 'package:capotcha/pages/login_screen.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/string.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../features/repository/s_helpar.dart';
import '../../models/cart_modal.dart';
import '../../models/home_model.dart';
import '../../value/constaint.dart';
import '../Screen/Auth_screen/login_screen.dart';

class ListGridCatagris extends StatefulWidget {
  @override
  _ListGridCatagrisState createState() => _ListGridCatagrisState();
}

class _ListGridCatagrisState extends State<ListGridCatagris> {
  getData() async {
    await Provider.of<HomeProvieder>(context, listen: false).getCartDB();
    // await Provider.of<HomeProvieder>(context, listen: false).getToken();
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
    int i = Provider.of<HomeProvieder>(context).index;

    List<DataCategory> data =
        Provider.of<HomeProvieder>(context).homeModel.dataCategory;
    final provider = Provider.of<HomeProvieder>(context, listen: false);

    return GridView.builder(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      itemCount: data[i].product.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: data[i].product[index].image != null
                          ? Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: CachedNetworkImageProvider(
                                        imgUrl + data[i].product[index].image),
                                  )),
                            )
                          : Container(
                              child: Image.asset("assets/images/shamer.gif"),
                            ),
                    ),
                  ),
                  Center(
                    child: Text(
                      data[Provider.of<HomeProvieder>(context).index]
                          .product[index]
                          .name,
                      style: Style.cairo,
                    ),
                  ),
                  Text.rich(TextSpan(
                      text: " السعر : ",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'cairo',
                          color: Colors.grey[700]),
                      children: <TextSpan>[
                        TextSpan(
                          text: data[i].product[index].oldPrice != null &&
                                  data[i].product[index].oldPrice != "0"
                              ? data[i].product[index].oldPrice + ".0"
                              : "",
                          style: new TextStyle(
                            fontSize: 15,
                            fontFamily: 'cairo',
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 1,
                            decorationColor: Colors.red,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                        TextSpan(text: " "),
                        TextSpan(
                            text:
                                "${double.parse(data[i].product[index].price)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'cairo',
                              color: Colors.grey[900],
                            )),
                        TextSpan(
                            text: ' جنيه',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'cairo',
                              color: Colors.grey[700],
                            )),
                      ])),
                  Text(
                    "${data[i].product[index].unit}",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'cairo',
                        color: Colors.grey[900]),
                  ),
                  CounterWidget(
                    sizeH * 0.038,
                    sizeW * 0.35,
                    data[i].product[index].id,
                    data[i].product[index].unit,
                  ),
                  Divider(),
                  Container(
                    height: sizeH * 0.045,
                    child: GestureDetector(
                      onTap: () async {
                        if (SHelper.sHelper.getToken() == null) {
                          awesomeDialog(context)..show();
                        } else {
                          DataCart dataCart = DataCart(
                              productId: data[i].product[index].id,
                              quantity: data[i].product[index].unit == "كيلو"
                                  ? provider.quantityMap[
                                          data[i].product[index].id] ??
                                      0.5
                                  : provider.quantityMap[
                                          data[i].product[index].id] ??
                                      1.0);
                          await DBClint.dbClint.insertDB(dataCart);

                          await Provider.of<HomeProvieder>(context,
                                  listen: false)
                              .getCartDB();
                          Provider.of<HomeProvieder>(context, listen: false)
                              .getprdaDB();

                          await Fluttertoast.showToast(
                              msg: "تمت الاضافة",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xff98B119),
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child:
                                    Text("اضف الى السلة", style: Style.cairog),
                              ),
                              Stack(
                                children: [
                                  provider.getprdaDB().contains(
                                              data[i].product[index].id) ==
                                          true
                                      ? Positioned(
                                          right: 3,
                                          child: data[i].product[index].image !=
                                                  null
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                    imgUrl +
                                                        data[i]
                                                            .product[index]
                                                            .image,
                                                  ),
                                                  radius: 8,
                                                )
                                              : CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  radius: 7,
                                                ))
                                      : Container(),
                                  SvgPicture.asset(
                                    "assets/images/icon-cart.svg",
                                    color: provider.dataprId.contains(
                                                data[i].product[index].id) ==
                                            true
                                        ? AppColors.greenColor
                                        : AppColors.bluColor,
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            data[i].product[index].offer == "1"
                ? Container(
                    alignment: Alignment.topLeft,
                    height: sizeH * 0.15,
                    child: Image.asset("assets/modal_offer.png",
                        fit: BoxFit.cover))
                : Container(),
            data[i].product[index].state == "0"
                ? Container(
                    //  height: sizeH * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.7)),
                    child: Center(
                        child: Text("نفدت الكمية",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Cairo",
                                fontSize: 18))),
                  )
                : Container()
          ]),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: sizeH * 0.00085,
        crossAxisCount: 2,
      ),
    );
  }
}
