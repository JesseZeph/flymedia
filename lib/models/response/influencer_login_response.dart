import 'dart:convert';

InfluencerLoginResponseModel influencerLoginResponseModelFromJson(String str) =>
    InfluencerLoginResponseModel.fromJson(json.decode(str));

class InfluencerLoginResponseModel {
  final String id;
  final String profile;
  final String userToken;
  final String uid;
  final String fullname;

  InfluencerLoginResponseModel({
    required this.id,
    required this.profile,
    required this.userToken,
    required this.uid,
    required this.fullname,
  });

  factory InfluencerLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      InfluencerLoginResponseModel(
        id: json["_id"],
        profile: json["profile"],
        userToken: json["userToken"],
        uid: json["uid"],
        fullname: json["fullname"],
      );
}
