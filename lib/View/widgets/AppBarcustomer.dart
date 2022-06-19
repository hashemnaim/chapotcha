import 'package:capotcha/View/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarCustomer extends StatelessWidget {
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
    double sizew = MediaQuery.of(context).size.width;
    double sizeh = MediaQuery.of(context).size.height;

    return Container(
      height: sizeh * 0.11,
      child: Padding(
        padding: EdgeInsets.only(right: sizeh * 0.02),
        child: Row(
          children: [
            InkWell(
                onTap: () {
                  // Get.b
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back)),
            SizedBox(
              width: sizew * 0.1,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ResaltSearch()));
                },
                child: Search()),
            SizedBox(
              width: sizew * 0.05,
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
      ),
    );
  }
}
