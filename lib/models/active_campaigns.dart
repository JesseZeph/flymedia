import 'package:flutter/material.dart';
import 'package:flymedia_app/constants/colors.dart';

class ActiveCampaignModel {
  String id;
  dynamic campaign;
  dynamic client;
  dynamic influencer;
  String message;
  String status;
  bool completed;
  bool verified;
  String completedDate;
  ActiveCampaignModel({
    required this.id,
    required this.campaign,
    required this.client,
    required this.influencer,
    required this.message,
    required this.status,
    required this.completed,
    required this.verified,
    required this.completedDate,
  });

  factory ActiveCampaignModel.fromMap(Map<String, dynamic> map) {
    return ActiveCampaignModel(
      id: map['_id'] ?? '',
      campaign: map['campaign'],
      client: map['client'],
      influencer: map['influencer'],
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      completed: map['completed'] ?? false,
      verified: map['verified_complete'] ?? false,
      completedDate: map['completed_date'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ActiveCampaignModel(id: $id, campaign: $campaign, client: $client, influencer: $influencer, message: $message, status: $status, completed: $completed, verified: $verified, completedDate: $completedDate)';
  }

  Color btnColor() {
    switch (status) {
      case 'Pending':
        return Colors.amber;

      case 'In Progress':
        return AppColors.deepGreen;
      case 'Completed':
        return Colors.black;
    }
    return Colors.green;
  }
}
