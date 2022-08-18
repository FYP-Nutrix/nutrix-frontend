
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nutrix/models/nutrition_model.dart';
import 'package:http/http.dart' as http;
import 'package:nutrix/utility/settings.dart';

class NutritionLogProvider with ChangeNotifier {

  List<NutritionLog> _nutritionLog = [];

  List<NutritionLog> get nutritionLog {
    return [..._nutritionLog];
  }

  // void setNutritionLog(NutritionLog nutritionLog) {
  //   _nutritionLog = nutritionLog;
  //   notifyListeners();
  // }

  // retrieve food nutrition information
  fetchNutritionInfo(String image_id) async {
    http.Response response = await http.get(Uri.parse(AppUrl.foodNutrition + image_id + "/"));

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _nutritionLog = data.map<NutritionLog>((json) => NutritionLog.fromJson(json)).toList();
      notifyListeners();

    } 
  }

}