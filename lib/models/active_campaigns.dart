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

  ActiveCampaignModel copyWith({
    String? id,
    dynamic campaign,
    dynamic client,
    dynamic influencer,
    String? message,
    String? status,
    bool? completed,
    bool? verified,
    String? completedDate,
  }) {
    return ActiveCampaignModel(
      id: id ?? this.id,
      campaign: campaign ?? this.campaign,
      client: client ?? this.client,
      influencer: influencer ?? this.influencer,
      message: message ?? this.message,
      status: status ?? this.status,
      completed: completed ?? this.completed,
      verified: verified ?? this.verified,
      completedDate: completedDate ?? this.completedDate,
    );
  }

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

  String actionCommand(bool isClient) {
    if (isClient) {
      return verified ? 'Contract complete' : 'Complete contract';
    }
    return completed ? 'Contract complete' : 'Complete contract';
  }

  bool checkIfMarkedComplete(bool isClient) {
    return isClient ? verified : completed;
  }
}
