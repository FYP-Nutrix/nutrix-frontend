import 'dart:convert';

import 'package:nutrix/models/user_model.dart';

class MealModel {
  String mealID;
  String mealType;
  String dateTime;
  String user;
  List<MealImageModel>? mealImage;

  MealModel({
    this.mealID = "",
    this.mealType = "",
    this.dateTime = "",
    this.user = "",
    this.mealImage,
  });

  factory MealModel.fromJson(Map<String,dynamic> json) {
    return MealModel(
      mealID: json['meal_id'],
      mealImage: List<MealImageModel>.from(json['meal_image'].map((x) => MealImageModel.fromMap(x))),
      mealType: json['meal_type'],
      dateTime: json['datetime'],
      user : json['user']
    );
  }

  dynamic toJson() => {
    'meal_id': mealID,
    'meal_type': mealType,
    'datetime': dateTime,
    'user': user
  };
}

class MealImageModel {
  String imageID;
  String mealName;
  String mealImage;
  int totalCalories;
  String mealSize;

  MealImageModel({
    this.imageID = "",
    this.mealName = "",
    this.mealImage = "",
    this.totalCalories = 0,
    this.mealSize = "",
  });

  factory MealImageModel.fromJson(String str) => MealImageModel.fromMap(json.decode(str));

  factory MealImageModel.fromMap(Map<String,dynamic> json) => MealImageModel(
    imageID: json['image_id'] == null ? null :json['image_id'],
    mealName: json['meal_name'] == null ? null :json['meal_name'],
    mealImage: json['meal_image'] == null ? null : json['meal_image'],
    totalCalories: json['total_calorie'] == null ? 0 : json['total_calorie'],
    mealSize: json['meal_size'] == null ? "nothing" :json['meal_size'],
  );

  Map<String,dynamic> toJson() {
    Map<String,dynamic> map  = {
      "meal_image": mealImage == null ? null: mealImage,

    };
    return map;
  }
}