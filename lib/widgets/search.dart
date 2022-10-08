import 'package:capotcha/utils/lunchers_helper.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'custom_svg.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizew = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        height: sizeH * 0.05,
        width: sizew * 0.6,
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text("ابحث",
                  style: TextStyle(
                      height: 1,
                      color: Colors.grey,
                      fontFamily: "Cairo",
                      fontSize: 16))),
        ),
      ),
    );
  }
}

class ResaltSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Center(
                          child: TextFormField(
                              textAlign: TextAlign.right,
                              onChanged: (value) async {
                                // await Provider.of<HomeProvieder>(context,
                                //         listen: false)
                                //     .setSearch(value);
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.backgroundColor,
                                  hintText: "ابحث ",
                                  hintStyle: TextStyle(
                                      height: 1,
                                      color: Colors.grey,
                                      fontFamily: "Cairo",
                                      fontSize: 16),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      InkWell(
                        onTap: () {
                          LuncherHelper.validationHelper
                              .launchURL("201101381311");
                          // Text('Running on: $_platformVersion\n');
                        },
                        child: CustomSvgImage(
                          "whatup",
                        ),
                      ),
                    ],
                  ),
                  Divider()
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        // child: Container(height: double.infinity, child: ListGridProduct()),
      ),
    );
  }
}
