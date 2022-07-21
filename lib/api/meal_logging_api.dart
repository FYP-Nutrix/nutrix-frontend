import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:nutrix/models/meal_model.dart';
import 'package:nutrix/utility/settings.dart';
import 'package:nutrix/utility/shared_preference.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class MealProvider with ChangeNotifier {
  MealModel _mealModel = MealModel();

  MealModel get mealModel => _mealModel;

  Future<Map<String, dynamic>> addMeal(String mealType, String mealImage) async {
    File imageFile = File(mealImage);
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var request = new http.MultipartRequest("POST", Uri.parse(AppUrl.mealLogging));
    var multipartFile = new http.MultipartFile('meal_image', stream, length,
          filename: basename(imageFile.path));
    ////////
    var result;
    String? userID = await UserPreferences().getUserID();
    Map<String, dynamic> addMealData = {
      'meal_type': mealType,
      'user': userID,
      'meal_image': {
        'meal_image': multipartFile,
        'total_calorie': 0,
        'meal_size': "0",
      }
    };

    Response response = await post(
      Uri.parse(AppUrl.mealLogging),
      headers: {"Content-Type": "application/json",
      "Content-type": "multipart/form-data"},
      body: json.encode(addMealData),
    );

    print("this api is called" + AppUrl.mealLogging);

    if (response.statusCode == 200) {
      print(response.body);
      result = {
        'status': true,
        'message': 'Succesful',
        'body': response.body,
      };
      notifyListeners();
    } else {
      print("update calories failed");
      print(response.body);
      result = {
        'code': response.statusCode,
        'status': true,
        'message': 'Failed',
        'body': response.body,
      };
    }
    return result;
  }
}
