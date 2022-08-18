import 'dart:convert';

import 'package:nutrix/models/meal_model.dart';

class NutritionLog {
  String nutritionLogID;
  List<MealImageModel>? mealImage;
  List<Nutrition>? nutrition;
  
  NutritionLog({
    this.nutritionLogID = "",
    this.mealImage,
    this.nutrition,
  });


  factory NutritionLog.fromJson(Map<String,dynamic> json) {
    return NutritionLog(
      nutritionLogID: json['nutrition_logging_id'],
      mealImage: List<MealImageModel>.from(json["meal_image"].map((x) => MealImageModel.fromMap(x))),
      nutrition: List<Nutrition>.from(json["nutrition"].map((x) => Nutrition.fromMap(x))),
    );
  }
}

class Nutrition {
  String nutritionID;
  String mealName;
  String carb;
  String protein;
  String fiber;
  String fats;
  String water;
  String mineral;
  String vitaminA;
  String vitaminB;
  String vitaminC;
  String vitaminD;
  String vitaminE;
  String vitaminK;
  int caloriePerServing;
  String servingSize;
  String servingType;
  String servingGram;

  Nutrition({
    this.nutritionID = "",
    this.mealName = "",
    this.carb = "",
    this.protein = "",
    this.fiber = "",
    this.fats ="",
    this.water = "",
    this.mineral = "",
    this.vitaminA ="",
    this.vitaminB = "",
    this.vitaminC = "",
    this.vitaminD = "",
    this.vitaminE = "",
    this.vitaminK = "",
    this.caloriePerServing = 0,
    this.servingGram = "",
    this.servingSize = "",
    this.servingType = "",
  });

  factory Nutrition.fromJson(String str) => Nutrition.fromMap(json.decode(str));

  factory Nutrition.fromMap(Map<String, dynamic> json) => Nutrition(
    nutritionID: json['nutrition_id'],
    mealName: json['meal_name'],
    carb: json['carb'],
    protein: json['protein'],
    fiber: json['fiber'],
    fats: json['fats'],
    water: json['water'],
    mineral: json['mineral'],
    vitaminA: json['vitamin_a'],
    vitaminB: json['vitamin_b'],
    vitaminC: json['vitamin_c'],
    vitaminD: json['vitamin_d'],
    vitaminE: json['vitamin_e'],
    vitaminK: json['vitamin_k'],
    caloriePerServing: json['calorie_per_serving'],
    servingSize: json['serving_size'],
    servingType: json['serving_type'],
    servingGram: json['serving_gram'],
  );
}