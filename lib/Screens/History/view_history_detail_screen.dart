import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutrix/api/nutrition_log_api.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';
import 'package:nutrix/models/meal_model.dart';
import 'package:nutrix/models/nutrition_model.dart';
import 'package:nutrix/utility/settings.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ViewHistoryDetailsScreen extends StatefulWidget {
  const ViewHistoryDetailsScreen({Key? key, required this.meal})
      : super(key: key);

  final MealModel meal;

  @override
  State<ViewHistoryDetailsScreen> createState() => _ViewHistoryDetailsState();
}

class _ViewHistoryDetailsState extends State<ViewHistoryDetailsScreen> {
  String nutritionID = "";
  String carb = "";
  String protein = "";
  String fiber = "";
  String fats = "";
  String water = "";
  String mineral = "";
  String vitaminA = "";
  String vitaminB = "";
  String vitaminC = "";
  String vitaminD = "";
  String vitaminE = "";
  String vitaminK = "";

  void getNutritionInformation() async {
    http.Response response = await http.get(Uri.parse(
        AppUrl.foodNutrition + widget.meal.mealImage![0].imageID + "/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Map nutrition = data['nutrition'];
      setState(() {
        nutritionID = data['nutrition_logging_id'];
        carb = nutrition['carb'];
        protein = nutrition['protein'];
        fiber = nutrition['fiber'];
        fats = nutrition['fats'];
        water = nutrition['water'];
        mineral = nutrition['mineral'];
        vitaminA = nutrition['vitamin_a'];
        vitaminB = nutrition['vitamin_b'];
        vitaminC = nutrition['vitamin_c'];
        vitaminD = nutrition['vitamin_d'];
        vitaminE = nutrition['vitamin_e'];
        vitaminK = nutrition['vitamin_k'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNutritionInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: <Widget>[
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  widget.meal.mealImage![0].mealImage,
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              Text(
                'Food Nutrition',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                "Food Name: " + widget.meal.mealImage![0].mealName,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "Meal Type: " + widget.meal.mealType,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "Calories: " +
                    widget.meal.mealImage![0].totalCalories.toString(),
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "Meal Size: " + widget.meal.mealImage![0].mealSize,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "carb: " + carb,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "protein: " + protein,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "fiber: " + fiber,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "fats: " + fats,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "water: " + water,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "mineral: " + mineral,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "vitamin A: " + vitaminA,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "vitamin B: " + vitaminB,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "vitamin C: " + vitaminC,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "vitamin D: " + vitaminD,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "vitamin E: " + vitaminE,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "vitamin K: " + vitaminK,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    centerTitle: true,
    title: const Text(
      "View Meal Diary",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
