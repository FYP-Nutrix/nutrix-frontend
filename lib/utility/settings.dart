class AppUrl {
  // default endpoint
  static const String baseUrl = "http://127.0.0.1:8000";

  // Login endpoint
  static const String login = baseUrl +  "/api/token/";

  static const String register = baseUrl + "/user/user/";
  // User Details endpoint
  static const String userDetails = baseUrl + "/user/user/";

  static const String dailyCalories = baseUrl + "/user/meal-setting/";

  static const String mealLogging = baseUrl + "/meal/meal-log/";

  static const String foodNutrition = baseUrl + "/nutrition/nutrition-log/";

}