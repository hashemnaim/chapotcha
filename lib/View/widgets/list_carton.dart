import 'package:cached_network_image/cached_network_image.dart';
import 'package:capotcha/View/Screen/details_product.dart';

import 'package:capotcha/models/carton_model.dart';

import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/string.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';

class ListCarton extends StatefulWidget {
  final CartonModel data;

  const ListCarton({Key key, this.data}) : super(key: key);

  @override
  _ListGridCatagrisState createState() => _ListGridCatagrisState();
}

class _ListGridCatagrisState extends State<ListCarton> {
  getData() async {
    // await Provider.of<HomeProvieder>(context, listen: false).getCartDB();
  }

  Animation animation;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.width;

    return GridView.builder(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      itemCount: widget.data.dataCarton.length,
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
                      child: widget.data.dataCarton[index].image != null
                          ? Hero(
                              tag: widget.data.dataCarton[index].image,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: CachedNetworkImageProvider(imgUrl +
                                          widget.data.dataCarton[index].image),
                                    )),
                              ),
                            )
                          : Container(
                              child: Image.asset("assets/images/shamer.gif"),
                            ),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.data.dataCarton[index].name,
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
                          TextSpan(
                            text: widget.data.dataCarton[index].cartonPrice !=
                                        null &&
                                    widget.data.dataCarton[index].cartonPrice !=
                                        "0"
                                ? widget.data.dataCarton[index].cartonPrice +
                                    ".0"
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
                                  "${double.parse(widget.data.dataCarton[index].cartonPrice)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'cairo',
                                color: Colors.grey[700],
                              )),
                          TextSpan(
                              text: ' جنيه',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'cairo',
                                color: Colors.grey[700],
                              )),
                        ])),
                  ),
                  Center(
                    child: Text(
                      "  الوحدة : كرتونة",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'cairo',
                          color: Colors.grey[700]),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  FadeTransition(
                            opacity: animation,
                            child: DetailsProduct(
                              data: widget.data,
                              index: index,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: sizeH * 0.045,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.double_arrow_rounded,
                              color: AppColors.greenColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Center(
                              child: Text("عرض التفاصيل", style: Style.cairog),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            widget.data.dataCarton[index].status == "0"
                ? Container(
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
