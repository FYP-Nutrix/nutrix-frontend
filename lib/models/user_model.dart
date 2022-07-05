class UserModel {
  String userID;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  bool is_active;

  UserModel({
    this.userID = "",
    this.firstName = "",
    this.lastName = "",
    this.phoneNumber = "",
    this.email = "",
    this.is_active = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      is_active: json['is_active'],
    );
  }
  dynamic toJson() => {
        'id': userID,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'email': email,
        'is_active': is_active,
      };
}
