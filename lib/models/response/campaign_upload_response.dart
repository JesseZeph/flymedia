import 'dart:convert';

List<CampaignUploadResponse> campaignResponseFromJson(String str) =>
    List<CampaignUploadResponse>.from(
        json.decode(str).map((x) => CampaignUploadResponse.fromJson(x)));

class CampaignUploadResponse {
  final String id;
  final String imageUrl;
  final String companyDescription;
  final String jobTitle;
  final String country;
  final String rateFrom;
  final String rateTo;
  final String viewsRequired;
  final String jobDescription;
  final String? assigned;

  CampaignUploadResponse({
    required this.id,
    required this.imageUrl,
    required this.companyDescription,
    required this.jobTitle,
    required this.country,
    required this.rateFrom,
    required this.rateTo,
    required this.viewsRequired,
    required this.jobDescription,
    this.assigned,
  });

  factory CampaignUploadResponse.fromJson(Map<String, dynamic> json) =>
      CampaignUploadResponse(
        id: json['_id'],
        imageUrl: json["imageUrl"],
        companyDescription: json["companyDescription"],
        jobTitle: json["jobTitle"],
        country: json["country"],
        rateFrom: json["rateFrom"],
        rateTo: json["rateTo"],
        viewsRequired: json["viewsRequired"],
        jobDescription: json["jobDescription"],
        assigned: json["assigned"],
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
        "assigned": assigned,
      };
}
