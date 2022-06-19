import 'package:capotcha/View/widgets/search.dart';
import 'package:capotcha/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarMaimCustomer extends StatelessWidget {
  launchURL() async {
    const url = 'https://wa.me/201101381311';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizew = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(right: sizeH * 0.02),
      child: Container(
        height: sizeH * 0.1,
        child: Column(
          children: [
            SizedBox(
              height: sizeH * 0.01,
            ),
            Row(
              children: [
                SizedBox(
                  width: sizew * 0.05,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ResaltSearch()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        height: sizeH * 0.05,
                        width: sizew * 0.75,
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
                    )),
                SizedBox(
                  width: sizew * 0.03,
                ),
                InkWell(
                  onTap: () {
                    launchURL();
                  },
                  child: SvgPicture.asset(
                    "assets/images/whatup.svg",
                  ),
                ),
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
