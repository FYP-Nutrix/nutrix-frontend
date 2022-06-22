import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nutrix/models/login_model.dart';

// API Link
String baseUrl = "http://127.0.0.1:8000/";

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String endpoint = baseUrl + "api/token/";
    // String endpoint = "http://127.0.0.1:8000/api/token/";

    final response = await http.post(Uri.parse(endpoint), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 401) {
      print(response.body);
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}