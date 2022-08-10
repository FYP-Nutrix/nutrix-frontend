import 'dart:convert';
import 'dart:io';
import 'package:nutrix/utility/settings.dart';
import 'package:flutter/material.dart';
import 'package:nutrix/models/user_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:nutrix/utility/shared_preference.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    this.fetchUserDetails();
  }

  UserModel _user = UserModel();

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  fetchUserDetails() async {
    String? userID;
    userID = await UserPreferences().getUserID();
    Response response =
        await get(Uri.parse(AppUrl.userDetails + userID! + "/"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      UserModel userD = UserModel.fromJson(data);
      UserPreferences().saveUser(userD);
      setUser(userD);
      notifyListeners();
    }
  }

  Future<UserModel> fetchUser() async {
    String? userID = await UserPreferences().getUserID();
    Response response = await get(Uri.parse(AppUrl.userDetails + userID! + "/"));
    
    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      UserModel userD = UserModel.fromJson(userData);
      UserPreferences().saveUser(userD);
      setUser(userD);
      notifyListeners();
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
    throw Exception("failed to load data");
    }
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> updateUser(String email, String firstName,
      String lastName, String phoneNumber, String password, String? profileFile) async {
    // get user id first
    var result;
    String? UserID;
    UserID = await UserPreferences().getUserID();

    UserModel userDetails = await UserPreferences().getUser();

    Map<String, dynamic> updateUserData;

    // profile pic logic here

    if (password == "") {
      print("calling edit api without password");
      updateUserData = {
        'email': email.trim(),
        'first_name': firstName.trim(),
        'last_name': lastName.trim(),
        'phone_number': phoneNumber.trim(),
        'is_active': UserModel().is_active,
        'is_patient': UserModel().is_patient,
      };

      // Response response = await put(
      //   Uri.parse(AppUrl.userDetails + UserID! + "/"),
      //   headers: {"Content-Type": "application/json"},
      //   body: json.encode(updateUserData),
      // );

      var request = http.MultipartRequest('PUT', Uri.parse(AppUrl.userDetails + UserID! + "/"));

      request.fields['email'] = email.trim();
      request.fields['first_name'] = firstName.trim();
      request.fields['last_name'] = lastName.trim();
      request.fields['phone_number'] = phoneNumber.trim();
      request.fields['is_active'] = "true";
      request.fields['is_patient'] = "true";
      request.files.add(http.MultipartFile.fromBytes('profile_pic', File(profileFile!).readAsBytesSync(),filename: profileFile));

      var response = await request.send();

      if (response.statusCode == 200) {

        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> responseData = json.decode(responseBody);

        UserModel user = UserModel.fromJson(responseData);

        result = {
          'status': true,
          'message': 'Succesful',
          'body': responseData,
        };
        notifyListeners();
      } else {
        // print(response.body);
        // result = {'status': false, 'message': json.decode(response.body)};
      }
    } else {
      updateUserData = {
        'email': email.trim(),
        'first_name': firstName.trim(),
        'last_name': lastName.trim(),
        'phone_number': phoneNumber.trim(),
        'password': password.trim(),
        'is_active': UserModel().is_active,
        'is_patient': UserModel().is_patient,
      };

      notifyListeners();

      Response response = await put(
        Uri.parse(AppUrl.userDetails + UserID! + "/"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(updateUserData),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        UserModel user = UserModel.fromJson(responseData);

        result = {
          'status': true,
          'message': 'Succesful',
          'body': responseData,
        };
        notifyListeners();
      } else {
        print(response.body);
        result = {'status': false, 'message': json.decode(response.body)};
      }
    }
    notifyListeners();
    return result;
  }

  
}
