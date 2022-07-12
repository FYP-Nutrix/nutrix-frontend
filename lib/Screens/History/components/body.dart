import 'package:flutter/material.dart';
import 'package:nutrix/Screens/History/components/recipe_bundel_card.dart';
import 'package:nutrix/Screens/History/view_history_detail_screen.dart';
import 'package:nutrix/models/RecipeBundel.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GridView.builder(
                itemCount: recipeBundles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.65,
                ),
                itemBuilder: (context, index) => RecipeBundelcard(
                  recipeBundle: recipeBundles[index],
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewHistoryDetailsScreen()));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
