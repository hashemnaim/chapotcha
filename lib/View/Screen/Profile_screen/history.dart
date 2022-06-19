import 'package:capotcha/View/Screen/Cart_screen/cart4.dart';
import 'package:capotcha/View/widgets/AppCustomer.dart';
import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/historylistitem.dart';
import 'package:capotcha/View/widgets/isload.dart';
import 'package:capotcha/View/widgets/navBottom2.dart';
import 'package:capotcha/View/widgets/navfloat2.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/models/profile_modal.dart';

import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  final int lastSelected = 0;

  final int x = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                child: AppCustomer("سجل الطلبات"),
                preferredSize: const Size(double.infinity, 60),
              ),
              body: Stack(
                children: [
                  Bakeground(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: FutureBuilder<Profile_Modal>(
                            future: Provider.of<HomeProvieder>(
                              context,
                            ).getProfile(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                Profile_Modal profile = snapshot.data;
                                List<Order> data = profile.user.order;
                                if (data.length > 0) {
                                  return Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                          child: Text(
                                            "سجل جميع الطلبات",
                                            style: Style.cairo,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: ListView.builder(
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  child: Container(
                                                    color: Colors.grey[300],
                                                    child: ExpansionTile(
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      title: Text(
                                                        "طلبك رقم ${data[index].id}",
                                                        style: Style.cairog,
                                                      ),
                                                      children: <Widget>[
                                                        Divider(),
                                                        Container(
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[200],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: HistoryItem(
                                                                index)),
                                                        Divider(),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 10),
                                                              child: Text(
                                                                "حالة الطلب",
                                                                style: Style
                                                                    .cairog,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await Provider.of<
                                                                            HomeProvieder>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .setOrderId(
                                                                        data[index]
                                                                            .id);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Talapat4()));
                                                              },
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.1,
                                                                child: Text(
                                                                  data[index]
                                                                      .status,
                                                                  style: Style
                                                                      .cairog,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 1,
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container(
                                      child: Center(
                                    child: Text(
                                      "لا يوجد طلبات",
                                      style:
                                          Style.cairogX.copyWith(fontSize: 30),
                                    ),
                                  ));
                                }
                              } else {
                                return Center(child: IsLoad());
                              }
                            }),
                      ),
                    ],
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
