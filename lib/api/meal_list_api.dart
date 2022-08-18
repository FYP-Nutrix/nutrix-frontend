import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nutrix/models/meal_model.dart';
import 'package:nutrix/utility/settings.dart';
import 'package:nutrix/utility/shared_preference.dart';
import 'package:http/http.dart' as http;

class MealListProvider with ChangeNotifier {
  MealListProvider() {
    print("Meal is called");
    this.fetchMeals();
  }

  List<MealModel> _mealList = [];

  List<MealModel> get mealList {
    return [..._mealList];
  }

  fetchMeals() async {
    
    String? userID;
    userID = await UserPreferences().getUserID();
    http.Response response = await http.get(Uri.parse(AppUrl.mealLogging + "patient/" + userID! + "/"));
    
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body) as List;
      _mealList = responseJson.map<MealModel>((json) => MealModel.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception("failed to load data");
    }

  }
}
