import 'package:nutrix/models/user_model.dart';

class MealModel {
  String mealID;
  String mealType;
  String dateTime;
  String user;
  MealImageModel? mealImage;

  
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
      mealImage: json['meal_image'] == null ? null : MealImageModel.fromJson(json['meal_image']),
      mealType: json['meal_type'],
      dateTime: json['datetime'],
      user : json['user']
    );
  }

  dynamic toJson() => {
    'meal_id': mealID,
    'meal_image': MealImageModel == null ? null : MealImageModel().toJson(),
    'meal_type': mealType,
    'datetime': dateTime,
    'user': user
  };
}

class MealImageModel {
  String imageID;
  String mealImage;
  int totalCalories;
  String mealSize;

  MealImageModel({
    this.imageID = "",
    this.mealImage = "",
    this.totalCalories = 0,
    this.mealSize = "",
  });

  factory MealImageModel.fromJson(Map<String,dynamic> json) => MealImageModel(
    imageID: json['image_id'] == null ? null :json['image_id'],
    mealImage: json['meal_image'] == null ? null : json['meal_image'],
    totalCalories: json['total_calorie'] == null ? 0 : int.parse(json['total_calorie']),
    mealSize: json['meal_size'] == null ? null :json['meal_size'],
  );

  Map<String,dynamic> toJson() {
    Map<String,dynamic> map  = {
      "meal_image": mealImage == null ? null: mealImage,

    };
    return map;
  }
}