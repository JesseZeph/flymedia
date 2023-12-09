// To parse this JSON data, do
//
//     final getSpecificClientCampaignRes = getSpecificClientCampaignResFromJson(jsonString);

import 'dart:convert';

GetSpecificClientCampaignRes getSpecificClientCampaignResFromJson(String str) =>
    GetSpecificClientCampaignRes.fromJson(json.decode(str));

String getSpecificClientCampaignResToJson(GetSpecificClientCampaignRes data) =>
    json.encode(data.toJson());

class GetSpecificClientCampaignRes {
  final bool success;
  final List<Campaign> campaign;

  GetSpecificClientCampaignRes({
    required this.success,
    required this.campaign,
  });

  factory GetSpecificClientCampaignRes.fromJson(Map<String, dynamic> json) =>
      GetSpecificClientCampaignRes(
        success: json["success"],
        campaign: List<Campaign>.from(
            json["campaign"].map((x) => Campaign.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "campaign": List<dynamic>.from(campaign.map((x) => x.toJson())),
      };
}

class Campaign {
  final String id;
  final String company;
  final String user;
  final String imageUrl;
  final String companyDescription;
  final String jobTitle;
  final String country;
  final String rateFrom;
  final String rateTo;
  final String viewsRequired;
  final String jobDescription;
  final int v;

  Campaign({
    required this.id,
    required this.company,
    required this.user,
    required this.imageUrl,
    required this.companyDescription,
    required this.jobTitle,
    required this.country,
    required this.rateFrom,
    required this.rateTo,
    required this.viewsRequired,
    required this.jobDescription,
    required this.v,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json["_id"],
        company: json["company"],
        user: json["user"],
        imageUrl: json["imageUrl"],
        companyDescription: json["companyDescription"],
        jobTitle: json["jobTitle"],
        country: json["country"],
        rateFrom: json["rateFrom"],
        rateTo: json["rateTo"],
        viewsRequired: json["viewsRequired"],
        jobDescription: json["jobDescription"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "company": company,
        "user": user,
        "imageUrl": imageUrl,
        "companyDescription": companyDescription,
        "jobTitle": jobTitle,
        "country": country,
        "rateFrom": rateFrom,
        "rateTo": rateTo,
        "viewsRequired": viewsRequired,
        "jobDescription": jobDescription,
        "__v": v,
      };
}
