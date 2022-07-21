import 'package:flutter/material.dart';
import 'package:nutrix/Screens/History/components/body.dart';
import 'package:nutrix/Screens/History/components/recipe_bundel_card.dart';
import 'package:nutrix/Screens/History/view_history_detail_screen.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';
import 'package:nutrix/models/RecipeBundel.dart';

class fakescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GridView.builder(
                itemCount: newrecipeBundles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.65,
                ),
                itemBuilder: (context, index) => RecipeBundelcard(
                  recipeBundle: newrecipeBundles[index],
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewHistoryDetailsScreen()));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ),
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
