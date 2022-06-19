import 'package:cached_network_image/cached_network_image.dart';
import 'package:capotcha/View/Screen/product_screen.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/models/home_model.dart';
import 'package:capotcha/value/shadows.dart';
import 'package:capotcha/value/string.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    List<DataCategory> data = Provider.of<HomeProvieder>(context, listen: false)
        .homeModel
        .dataCategory;
    double sizeH = MediaQuery.of(context).size.height;

    if (data != null) {
      return Column(
        children: [
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, int index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 300),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () async {
                                  Provider.of<HomeProvieder>(context,
                                          listen: false)
                                      .setIndex(index);

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ProductScreen(
                                            data: Provider.of<HomeProvieder>(
                                                    context)
                                                .homeModel
                                                .dataCategory,
                                          )));
                                },
                                child: Container(
                                  height: sizeH * 0.18,
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      Shadows.primaryShadow
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          imageUrl: imgUrl + data[index].image,
                                          placeholder: (context, url) =>
                                              Container(
                                            child: Image.asset(
                                              "assets/images/shamer.gif",
                                              fit: BoxFit.cover,
                                            ),
                                            //  color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                            color:
                                                Colors.black.withOpacity(0.3)),
                                        Center(
                                            child: Text(data[index].name,
                                                style: Style.cairoW)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  }),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // )
        ],
      );
    } else {
      return Center(child: Text('لا يوجد بيانات'));
    }
  }
}
