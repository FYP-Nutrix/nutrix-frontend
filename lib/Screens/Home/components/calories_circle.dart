import 'package:flutter/material.dart';
import 'package:nutrix/constrants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CaloriesCircle extends StatelessWidget {
  const CaloriesCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 140,
      percent: 0.4,
      progressColor: kPrimaryColor,
      center: Text(
        "1500 Cal",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 30,
        ),
      ),
    );
  }
}