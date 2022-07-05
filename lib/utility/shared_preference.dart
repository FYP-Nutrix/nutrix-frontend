import 'package:nutrix/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // Retrieve Token
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  Future<bool> saveUserID(String userID) async {
    print("userid is saved");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userID);
    return prefs.commit();
  }

  Future<String?> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("user_id");
    print("getting user id...." + userID!);
    return userID;
  }

  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('user_id', user.userID);
    prefs.setString('first_name', user.firstName);
    prefs.setString('last_name', user.lastName);
    prefs.setString('email', user.email);
    prefs.setString('phone_number', user.phoneNumber);
    prefs.setBool('is_active', user.is_active);

    return prefs.commit();
  }

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userID = prefs.getString("user_id");
    String? firstName = prefs.getString("first_name");
    String? lastName = prefs.getString("last_name");
    String? email = prefs.getString("email");
    String? phone_number = prefs.getString("phone_number");
    bool? is_active = prefs.getBool("is_active");

    return UserModel(
      userID: userID ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      email: email ?? "",
      phoneNumber: phone_number ?? "",
      is_active: is_active ?? false,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('user_id');
    prefs.remove('first_name');
    prefs.remove('last_name');
    prefs.remove('email');
    prefs.remove('phone_number');
    prefs.remove('is_active');
  }
}
