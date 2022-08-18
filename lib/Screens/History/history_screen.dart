import 'package:flutter/material.dart';
import 'package:nutrix/Screens/History/components/body.dart';
import 'package:nutrix/Screens/Home/home_screen.dart';
import 'package:nutrix/api/meal_list_api.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class HistoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MealListProvider(),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: BodyClass(),
        floatingActionButton: AddMealButton(),
        bottomNavigationBar: MyBottomNavBar(),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: SizedBox(),
    centerTitle: true,
    title: const Text(
      "My Diary",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
