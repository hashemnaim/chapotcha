import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey[100],
      radius: 28,
      child: CircularProgressIndicator(
        backgroundColor: Colors.amber,
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).primaryColor,
        ),
        strokeWidth: 2,
      ),
    );
  }
}
