import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  final String id;
  final String profile;
  final String userToken;
  final String email;
  final String fullname;

  LoginResponseModel({
    required this.id,
    required this.profile,
    required this.userToken,
    required this.email,
    required this.fullname,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json["_id"],
        profile: json["profile"],
        userToken: json["userToken"],
        email: json.containsKey("email") ? json["email"] : '',
        fullname: json["fullname"],
      );
}
