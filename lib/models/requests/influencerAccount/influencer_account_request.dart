import 'dart:convert';

InfluencerAddAccount influencerAddAccountFromJson(String str) =>
    InfluencerAddAccount.fromJson(json.decode(str));

String influencerAddAccountToJson(InfluencerAddAccount data) =>
    json.encode(data.toJson());

class InfluencerAddAccount {
  final String influencerId;
  final String accountName;
  final String accountNumber;
  final String bankName;

  InfluencerAddAccount({
    required this.influencerId,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  });

  factory InfluencerAddAccount.fromJson(Map<String, dynamic> json) =>
      InfluencerAddAccount(
        influencerId: json["influencer_id"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
      );

  Map<String, dynamic> toJson() => {
        "influencer_id": influencerId,
        "account_name": accountName,
        "account_number": accountNumber,
        "bank_name": bankName,
      };
}
