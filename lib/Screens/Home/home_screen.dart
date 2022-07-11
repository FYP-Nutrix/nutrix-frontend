import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutrix/Screens/Home/components/body.dart';
import 'package:nutrix/api/calories_api.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CaloriesProvider(),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: HomeBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green,
          child: Icon(Icons.add_circle_rounded),
        ),
        bottomNavigationBar: MyBottomNavBar(),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {},
    ),
    centerTitle: true,
    title: const Text(
      "Eiyo Tracker",
      style: TextStyle(color: kPrimaryColor),
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("assets/icons/search.svg"),
      ),
    ],
  );
}
