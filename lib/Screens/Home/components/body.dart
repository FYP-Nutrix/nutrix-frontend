import 'package:flutter/material.dart';
import 'package:nutrix/Screens/Home/components/categories.dart';
import 'package:nutrix/api/calories_api.dart';
import 'package:nutrix/constrants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  HomeBodyState createState() => HomeBodyState();
}

class HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    CaloriesProvider caloriesP = Provider.of<CaloriesProvider>(context);
    return SafeArea(
      child: Column(
        children: <Widget>[
          Categories(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CircularPercentIndicator(
              radius: 140,
              percent: 0.4,
              progressColor: kPrimaryColor,
              center: Text(
                '${context.watch<CaloriesProvider>().dailyCalories.dailyCalories}' + " Cal",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
              footer: Text("Your max calories intake are :" + '${context.watch<CaloriesProvider>().dailyCalories.dailyCalories}' + " Cal"),
            ),
          ),
        ],
      ),
    );
  }
}
