import 'package:http/http.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:nutrix/models/user_model.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutrix/utility/settings.dart';
import 'package:nutrix/utility/shared_preference.dart';
import 'package:flutter/foundation.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthAPI extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  notify() {
    notifyListeners();
  }

  static Future<Map<String, dynamic>> onValue(Response response) async {
    var result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      var userData = responseData['data'];

      // now we will create a user model
      UserModel authUser = UserModel.fromJson(responseData);

      // now we will create shared preference and save data
      // UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Failed registered',
        'data': responseData,
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email.trim(),
      'password': password.trim(),
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(Uri.parse(AppUrl.login),
        body: json.encode(loginData),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // LoginResponseModel authUser = LoginResponseModel.fromJson(responseData);

      // UserPreference().saveUser(authUser);

      // get user id from jwt token
      String token = responseData['access'].toString();
      Map<String, dynamic> decodeToken = Jwt.parseJwt(token);
      String userId = decodeToken['user_id'];

      UserPreferences().saveUserID(userId);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Succesful',
        'user': responseData,
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(String first_name, String last_name,
      String email, String phone_number, String password) async {
    Map<String, dynamic> caloriesBodyData = {'daily_calories': 2000};
    final Map<String, dynamic> apiBodyData = {
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'password': password,
      'daily_calories':caloriesBodyData,
    };

    return await post(Uri.parse(AppUrl.register),
        body: json.encode(apiBodyData),
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
        }).then(onValue).catchError(onError);
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
