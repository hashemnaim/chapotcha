import 'package:capotcha/View/Screen/home_screen.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/value/colors.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NavFloat2 extends StatefulWidget {
  @override
  _NavFloatState createState() => _NavFloatState();
}

class _NavFloatState extends State<NavFloat2> with TickerProviderStateMixin {
  //TabController tabController;

  int lastSelected = 0;

  AnimationController _animationController;

  Animation<double> animation;

  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvieder>(context, listen: false).getCartDB();

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: FloatingActionButton(
        elevation: 8,
        backgroundColor: AppColors.greenColor,
        child: Stack(
          children: [
            Center(
              child: Container(
                //color:Colors.amber,
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  "assets/images/icon-cart.svg",
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Provider.of<HomeProvieder>(
                              context,
                            ).dataCart.length +
                            Provider.of<HomeProvieder>(
                              context,
                            ).cartonCart.length !=
                        0
                    ? CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 12,
                        child: Text(
                          "${Provider.of<HomeProvieder>(
                                context,
                              ).dataCart.length + Provider.of<HomeProvieder>(
                                context,
                              ).cartonCart.length}",
                          style: Style.cairoCat,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 12,
                        child: Center(
                          child: Text(
                            "0",
                            style: Style.cairoCat,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
          ],
        ),
        onPressed: () async {
          _animationController.reset();
          Provider.of<HomeProvieder>(context, listen: false).setNav(4);
          _animationController.forward();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
    );
  }
}
