import 'dart:convert';

GetCampaignRes getCampaignResFromJson(String str) =>
    GetCampaignRes.fromJson(json.decode(str));

String getCampaignResToJson(GetCampaignRes data) => json.encode(data.toJson());

class GetCampaignRes {
  final String id;
  final String imageUrl;
  final String companyDescription;
  final String jobTitle;
  final String country;
  final String rateFrom;
  final String rateTo;
  final String viewsRequired;
  final String jobDescription;

  GetCampaignRes({
    required this.id,
    required this.imageUrl,
    required this.companyDescription,
    required this.jobTitle,
    required this.country,
    required this.rateFrom,
    required this.rateTo,
    required this.viewsRequired,
    required this.jobDescription,
  });

  factory GetCampaignRes.fromJson(Map<String, dynamic> json) => GetCampaignRes(
        id: json["_id"],
        imageUrl: json["imageUrl"],
        companyDescription: json["companyDescription"],
        jobTitle: json["jobTitle"],
        country: json["country"],
        rateFrom: json["rateFrom"],
        rateTo: json["rateTo"],
        viewsRequired: json["viewsRequired"],
        jobDescription: json["jobDescription"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "imageUrl": imageUrl,
        "companyDescription": companyDescription,
        "jobTitle": jobTitle,
        "country": country,
        "rateFrom": rateFrom,
        "rateTo": rateTo,
        "viewsRequired": viewsRequired,
        "jobDescription": jobDescription,
      };
}
