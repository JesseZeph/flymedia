import 'dart:convert';

InfluencerLoginModel influencerLoginModelFromJson(String str) =>
    InfluencerLoginModel.fromJson(json.decode(str));

String influencerLoginModelToJson(InfluencerLoginModel data) =>
    json.encode(data.toJson());

class InfluencerLoginModel {
  InfluencerLoginModel({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory InfluencerLoginModel.fromJson(Map<String, dynamic> json) =>
      InfluencerLoginModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
