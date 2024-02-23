// To parse this JSON data, do
//
//     final getAllInfluencersRes = getAllInfluencersResFromJson(jsonString);

import 'dart:convert';

List<GetAllInfluencersRes> getAllInfluencersResFromJson(String str) =>
    List<GetAllInfluencersRes>.from(
        json.decode(str).map((x) => GetAllInfluencersRes.fromJson(x)));

String getAllInfluencersResToJson(List<GetAllInfluencersRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllInfluencersRes {
  final String id;
  final String imageUrl;
  final String firstAndLastName;
  final String location;
  final String tikTokLink;
  final String email;
  final String noOfTikTokFollowers;
  final String noOfTikTokLikes;
  final String postsViews;
  final String bio;
  final List<Nich> niches;
  final String userId;

  GetAllInfluencersRes({
    required this.id,
    required this.imageUrl,
    required this.firstAndLastName,
    required this.location,
    required this.tikTokLink,
    required this.email,
    required this.noOfTikTokFollowers,
    required this.noOfTikTokLikes,
    required this.postsViews,
    required this.bio,
    required this.niches,
    required this.userId,
  });

  factory GetAllInfluencersRes.fromJson(Map<String, dynamic> json) =>
      GetAllInfluencersRes(
        id: json["_id"],
        imageUrl: json["imageURL"],
        firstAndLastName: json["firstAndLastName"],
        location: json["location"],
        tikTokLink: json["tikTokLink"],
        email: json["email"],
        noOfTikTokFollowers: json["noOfTikTokFollowers"],
        noOfTikTokLikes: json["noOfTikTokLikes"],
        postsViews: json["postsViews"],
        bio: json["bio"],
        niches: List<Nich>.from(json["niches"].map((x) => Nich.fromJson(x))),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "imageURL": imageUrl,
        "firstAndLastName": firstAndLastName,
        "location": location,
        "tikTokLink": tikTokLink,
        "email": email,
        "noOfTikTokFollowers": noOfTikTokFollowers,
        "noOfTikTokLikes": noOfTikTokLikes,
        "postsViews": postsViews,
        "bio": bio,
        "niches": List<dynamic>.from(niches.map((x) => x.toJson())),
        "userId": userId,
      };
}

class Nich {
  final String id;
  final String name;

  Nich({
    required this.id,
    required this.name,
  });

  factory Nich.fromJson(Map<String, dynamic> json) => Nich(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
