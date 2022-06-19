import 'package:capotcha/View/widgets/AppCustomer.dart';
import 'package:capotcha/View/widgets/background.dart';
import 'package:capotcha/View/widgets/navBottom2.dart';
import 'package:capotcha/View/widgets/navfloat2.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<About>
    with SingleTickerProviderStateMixin {
  int lastSelected = 0;
  bool v = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                child: AppCustomer("عن كابوتشا"),
                preferredSize: const Size(double.infinity, 60),
              ),
              body: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Bakeground(),
                          ListView(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "كابوتشا",
                                    style: Style.cairog,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "هي خدمة متخصصة في تجارة التجزئة للخضروات و الفواكه عبر الانترنت",
                                    style: Style.cairo,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "ضمان الجودة",
                                    style: Style.cairog,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "هو الحصول على المنتجات من المزارع و الموزعين المعتدمين محلياً و دولياً",
                                    style: Style.cairo,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "رؤيتنا",
                                    style: Style.cairog,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "أن نكون الوجهه الاولي للخضروات والفواكه للمستهلك النهائي",
                                    style: Style.cairo,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
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
