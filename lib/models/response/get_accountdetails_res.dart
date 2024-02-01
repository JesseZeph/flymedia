// To parse this JSON data, do
//
//     final getAccountDetailsRes = getAccountDetailsResFromJson(jsonString);

import 'dart:convert';

GetAccountDetailsRes getAccountDetailsResFromJson(String str) =>
    GetAccountDetailsRes.fromJson(json.decode(str));

String getAccountDetailsResToJson(GetAccountDetailsRes data) =>
    json.encode(data.toJson());

class GetAccountDetailsRes {
  final bool status;
  final String message;
  final Data data;

  GetAccountDetailsRes({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAccountDetailsRes.fromJson(Map<String, dynamic> json) =>
      GetAccountDetailsRes(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final String influencer;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String id;
  final int v;

  Data({
    required this.influencer,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.id,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        influencer: json["influencer"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "influencer": influencer,
        "account_name": accountName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "_id": id,
        "__v": v,
      };
}
