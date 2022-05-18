import 'package:flutter/material.dart';
import 'package:nutrix/Screens/Home/components/categories.dart';
import 'package:nutrix/constrants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Categories(),
      ],
    );
  }
}
