import 'dart:convert';

String campaignUploadRequestToJson(CampaignUploadRequest data) =>
    json.encode(data.toJson());

class CampaignUploadRequest {
  final String imageUrl;
  final String companyDescription;
  final String jobTitle;
  final String country;
  // final int maxApplicants;
  final int minFollowers;
  final String rate;
  // final String rateFrom;
  final String viewsRequired;
  final String jobDescription;

  CampaignUploadRequest({
    required this.imageUrl,
    required this.companyDescription,
    required this.jobTitle,
    required this.country,
    // required this.maxApplicants,
    required this.minFollowers,
    required this.rate,
    // required this.rateTo,
    required this.viewsRequired,
    required this.jobDescription,
  });

  factory CampaignUploadRequest.fromJson(Map<String, dynamic> json) =>
      CampaignUploadRequest(
        imageUrl: json["imageUrl"],
        companyDescription: json["companyDescription"],
        jobTitle: json["jobTitle"],
        country: json["country"],
        // maxApplicants: json["maxApplicants"],
        minFollowers: json["minFollowers"],
        // rateFrom: json["rateFrom"],
        rate: json["rate"],
        viewsRequired: json["viewsRequired"],
        jobDescription: json["jobDescription"],
      );

  Map<String, String> toJson() => {
        // "imageUrl": imageUrl,
        "companyDescription": companyDescription,
        "jobTitle": jobTitle,
        "country": country,
        // "maxApplicants": maxApplicants.toString(),
        "minFollowers": minFollowers.toString(),
        // "rateFrom": rateFrom,
        "rate": rate,
        "viewsRequired": viewsRequired,
        "jobDescription": jobDescription,
      };
}
