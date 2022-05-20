import 'package:flutter/material.dart';
import 'package:nutrix/Screens/Home/components/calories_circle.dart';
import 'package:nutrix/Screens/Home/components/categories.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Categories(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CaloriesCircle(),
          ),
        ],
      ),
    );
  }
}


