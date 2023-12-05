import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  SignupModel({
    required this.fullname,
    required this.email,
    required this.password,
  });
  final String fullname;
  final String email;
  final String password;

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "password": password,
      };
}
