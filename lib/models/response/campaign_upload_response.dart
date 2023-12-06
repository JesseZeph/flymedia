import 'dart:convert';

List<CampaignUploadResponse> campaignResponseFromJson(String str) =>
    List<CampaignUploadResponse>.from(
        json.decode(str).map((x) => CampaignUploadResponse.fromJson(x)));

class CampaignUploadResponse {
  final String imageUrl;
  final String companyDescription;
  final String jobTitle;
  final String country;
  final String rateFrom;
  final String rateTo;
  final String viewsRequired;
  final String jobDescription;

  CampaignUploadResponse({
    required this.imageUrl,
    required this.companyDescription,
    required this.jobTitle,
    required this.country,
    required this.rateFrom,
    required this.rateTo,
    required this.viewsRequired,
    required this.jobDescription,
  });

  factory CampaignUploadResponse.fromJson(Map<String, dynamic> json) =>
      CampaignUploadResponse(
        imageUrl: json["imageUrl"],
        companyDescription: json["companyDescription"],
        jobTitle: json["jobTitle"],
        country: json["country"],
        rateFrom: json["rateFrom"],
        rateTo: json["rateTo"],
        viewsRequired: json["viewsRequired"],
        jobDescription: json["jobDescription"],
      );

  Map<String, dynamic> toJson() {
    return {
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
}
