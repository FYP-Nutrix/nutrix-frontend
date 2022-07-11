import 'package:flutter/material.dart';
import 'package:nutrix/models/user_model.dart';
import 'package:nutrix/utility/settings.dart';
import 'package:nutrix/utility/shared_preference.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CaloriesProvider with ChangeNotifier {
  CaloriesProvider() {
    print("calling calories provider");
    this.fetchDailyCaloriesNotify();
  }

  DailyCalories _dailyCalories = DailyCalories();

  DailyCalories get dailyCalories => _dailyCalories;

  void setDailyCalories(DailyCalories dCalories) {
    print("set data");
    _dailyCalories = dCalories;
    notifyListeners();
  }

  // get Daily Calories for user
  Future<DailyCalories> fetchDailyCalories() async {
    String? userID = await UserPreferences().getUserID();
    Response response = await get(Uri.parse(AppUrl.dailyCalories));
    if (response.statusCode == 200) {
      return DailyCalories.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception("failed to load data");
    }
  }

  fetchDailyCaloriesNotify() async {
    print("calories has been called");
    String? userID;
    userID = await UserPreferences().getUserID();
    Response response =
        await get(Uri.parse(AppUrl.dailyCalories + userID! + "/"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      DailyCalories dCalories = DailyCalories.fromJson(data);
      setDailyCalories(dCalories);

      print(_dailyCalories.dailyCalories);
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> updateCalories(double newCalories) async {
    String? userID = await UserPreferences().getUserID();

    Map<String, dynamic> updateCaloriesData = {'daily_calories': newCalories};

    Response response = await put(
      Uri.parse(AppUrl.dailyCalories + userID! + "/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(updateCaloriesData),
    );

    print("this api is called" + AppUrl.dailyCalories + userID + "/");

    var result;

    if (response.statusCode == 200) {
      DailyCalories.fromJson(json.decode(response.body));
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
        'status': true,
        'message': 'Failed',
        'body': response.body,
      };
    }
    return result;
  }
}
