import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutrix/models/user_model.dart';
import 'package:http/http.dart';
import 'package:nutrix/utility/settings.dart';
import 'package:nutrix/utility/shared_preference.dart';

class UserProvider with ChangeNotifier {

  UserProvider() {
    this.fetchUserDetails();
  }

  UserModel _user = UserModel();

  UserModel get user => _user;

  void setUser (UserModel user) {
    _user = user;
    notifyListeners();
  }

  fetchUserDetails() async {
    String? userID;
    userID = await UserPreferences().getUserID();

    print('Loading user details');

    Response response = await get(
      Uri.parse(AppUrl.userDetails + userID! + "/")
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      UserModel userD = UserModel.fromJson(data);
      setUser(userD);
      notifyListeners();
    }
  }
}