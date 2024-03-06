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
  // final int maxApplicants;
  final int minFollowers;
  // final String rateFrom;
  final String rate;
  final String viewsRequired;
  final String jobDescription;
  final bool isPaidFor;
  final String? assigned;

  CampaignUploadResponse({
    required this.id,
    required this.imageUrl,
    required this.companyDescription,
    required this.jobTitle,
    required this.country,
    // required this.maxApplicants,
    required this.minFollowers,
    // required this.rateFrom,
    required this.rate,
    required this.viewsRequired,
    required this.isPaidFor,
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
        // maxApplicants: json["maxApplicants"],
        minFollowers: json["minFollowers"],
        // rateFrom: json["rateFrom"],
        rate: json["rate"],
        viewsRequired: json["viewsRequired"],
        isPaidFor: json["isPaidFor"],
        jobDescription: json["jobDescription"],
        assigned: json["assigned"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "imageUrl": imageUrl,
        "companyDescription": companyDescription,
        "jobTitle": jobTitle,
        "country": country,
        // "maxApplicants": maxApplicants,
        "minFollowers": minFollowers,
        // "rateFrom": rateFrom,
        "rate": rate,
        "viewsRequired": viewsRequired,
        "isPaidFor": isPaidFor,
        "jobDescription": jobDescription,
        "assigned": assigned,
      };

  bool checkInfluencerEligibility(int? influencerFollowers) {
    if (influencerFollowers == null) return false;
    return influencerFollowers >= minFollowers ? true : false;
  }
}
