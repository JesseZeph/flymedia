import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.email,
    required this.userType,
    required this.password,
  });

  final String email;
  final String password;
  final String userType;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      email: json["email"],
      password: json["password"],
      userType: json["user_type"]);

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "user_type": userType,
      };
}
