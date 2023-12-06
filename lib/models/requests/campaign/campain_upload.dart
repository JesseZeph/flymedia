import 'dart:convert';

String campaignUploadRequestToJson(CampaignUploadRequest data) =>
    json.encode(data.toJson());

class CampaignUploadRequest {
  final String imageUrl;
  final String companyDescription;
  final String jobTitle;
  final String country;
  final String rateFrom;
  final String rateTo;
  final String viewsRequired;
  final String jobDescription;

  CampaignUploadRequest({
    required this.imageUrl,
    required this.companyDescription,
    required this.jobTitle,
    required this.country,
    required this.rateFrom,
    required this.rateTo,
    required this.viewsRequired,
    required this.jobDescription,
  });

  factory CampaignUploadRequest.fromJson(Map<String, dynamic> json) =>
      CampaignUploadRequest(
        imageUrl: json["imageUrl"],
        companyDescription: json["companyDescription"],
        jobTitle: json["jobTitle"],
        country: json["country"],
        rateFrom: json["rateFrom"],
        rateTo: json["rateTo"],
        viewsRequired: json["viewsRequired"],
        jobDescription: json["jobDescription"],
      );

  Map<String, String> toJson() => {
        // "imageUrl": imageUrl,
        "companyDescription": companyDescription,
        "jobTitle": jobTitle,
        "country": country,
        "rateFrom": rateFrom,
        "rateTo": rateTo,
        "viewsRequired": viewsRequired,
        "jobDescription": jobDescription,
      };
}
