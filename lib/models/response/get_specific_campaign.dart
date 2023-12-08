import 'dart:convert';

List<GetSpecificClientCampaignRes> getSpecificClientCampaignResFromJson(
        String str) =>
    List<GetSpecificClientCampaignRes>.from(
        json.decode(str).map((x) => GetSpecificClientCampaignRes.fromJson(x)));

// GetSpecificClientCampaignRes getSpecificClientCampaignResFromJson(String str) =>
//     GetSpecificClientCampaignRes.fromJson(json.decode(str));
//
// String getSpecificClientCampaignResToJson(GetSpecificClientCampaignRes data) => json.encode(data.toJson());

class GetSpecificClientCampaignRes {
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

  GetSpecificClientCampaignRes({
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
  });

  factory GetSpecificClientCampaignRes.fromJson(Map<String, dynamic> json) =>
      GetSpecificClientCampaignRes(
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
      };
}
