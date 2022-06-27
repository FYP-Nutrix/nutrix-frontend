import 'package:jwt_decode/jwt_decode.dart';

class LoginResponseModel {
  final String token;
  final String error;
  final String userID;

  LoginResponseModel({required this.token, required this.error, required this.userID});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    String getToken = json["access"] != null ? json["access"] : "";
    String getError = json["detail"] != null ? json["detail"] : "";

    Map<String, dynamic> payload = Jwt.parseJwt(getToken);
    String getUserID = payload['user_id'];

    return LoginResponseModel(
      token: getToken,
      error: getError,
      userID: getUserID != null ? getUserID: "",
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    required this.email,
    required this.password,
    
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
