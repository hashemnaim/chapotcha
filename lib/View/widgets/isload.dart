import 'package:capotcha/value/colors.dart';
import 'package:flutter/material.dart';

class IsLoad extends StatefulWidget {
  @override
  _IsLoadState createState() => _IsLoadState();
}

class _IsLoadState extends State<IsLoad> with TickerProviderStateMixin {
 Animation<double> animation;

  AnimationController _controller;


  @override
  void initState() {
    super.initState();

     _controller = AnimationController(
       vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
  
    return CircleAvatar(
      backgroundColor: Colors.grey[100],
      
      radius: 28,
          child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.greenColor),
                strokeWidth: 2,
              ),
    );
  }
}