import 'package:flutter/material.dart';
import 'package:nutrix/Screens/History/components/body.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

AppBar buildAppBar() {
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
