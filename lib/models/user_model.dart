class UserModel {
  String userID;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;
  String profile_pic;
  bool is_active;
  bool is_patient;
  DailyCalories? calories;

  UserModel({
    this.userID = "",
    this.firstName = "",
    this.lastName = "",
    this.phoneNumber = "",
    this.email = "",
    this.profile_pic = "",
    this.password = "",
    this.is_active = true,
    this.is_patient = true,
    this.calories,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      profile_pic: json['profile_pic'],
      password: json['password'] == null ? null : json['password'],
      is_active: json['is_active'],
      is_patient: json['is_patient'],
      calories: json["daily_calories"] == null
          ? null
          : DailyCalories.fromJson(json["daily_calories"]),
    );
  }
  dynamic toJson() => {
        'id': userID,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'email': email,
        'profile_pic': profile_pic,
        'password': password == null ? null : password,
        'is_active': is_active,
        'is_patient': is_patient,
        'daily_calories':
            DailyCalories == null ? null : DailyCalories().toJson(),
      };
}

class DailyCalories {
  double dailyCalories;

  DailyCalories({
    this.dailyCalories = 2000,
  });

  factory DailyCalories.fromJson(Map<String, dynamic> json) => DailyCalories(
        dailyCalories: double.parse(json["daily_calories"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "daily_calories": dailyCalories == null ? null : dailyCalories,
    };
    return map;
  }
}
