import 'dart:convert';

String verifyCompanyToJson(VerifyCompanyRequest data) =>
    json.encode(data.toJson());

class VerifyCompanyRequest {
  final String companyName;
  final String companyHq;
  final String website;
  final String companyEmail;
  final String memberContact;
  final String userId;

  VerifyCompanyRequest({
    required this.companyName,
    required this.companyHq,
    required this.website,
    required this.companyEmail,
    required this.memberContact,
    required this.userId,
  });

  factory VerifyCompanyRequest.fromJson(Map<String, dynamic> json) =>
      VerifyCompanyRequest(
        companyName: json["companyName"],
        companyHq: json["companyHq"],
        website: json["website"],
        companyEmail: json["companyEmail"],
        memberContact: json["memberContact"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "companyHq": companyHq,
        "website": website,
        "companyEmail": companyEmail,
        "memberContact": memberContact,
        "userId": userId,
      };
}
