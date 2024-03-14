import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flymedia_app/models/profile/influencer_points.dart';

class ProfileModel {
  String id;
  String? imageUrl;
  String? firstAndLastName;
  String? location;
  String? noOfTikTokFollowers;
  String? noOfTikTokLikes;
  String? postsViews;
  String? email;
  String? profileLink;
  String? verificationStatus;
  List<String>? niches;
  String? bio;
  InfluencerPoints? points;
  ProfileModel(
      {required this.id,
      this.imageUrl,
      this.firstAndLastName,
      this.location,
      this.noOfTikTokFollowers,
      this.noOfTikTokLikes,
      this.postsViews,
      this.email,
      this.profileLink,
      this.niches,
      this.bio,
      this.points,
      this.verificationStatus});

  ProfileModel copyWith({
    String? id,
    ValueGetter<String?>? imageUrl,
    ValueGetter<String?>? firstAndLastName,
    ValueGetter<String?>? location,
    ValueGetter<String?>? noOfTikTokFollowers,
    ValueGetter<String?>? noOfTikTokLikes,
    ValueGetter<String?>? postsViews,
    ValueGetter<String?>? email,
    ValueGetter<String?>? verificationStatus,
    ValueGetter<String?>? profileLink,
    ValueGetter<List<String>?>? niches,
    ValueGetter<String?>? bio,
    ValueGetter<InfluencerPoints>? points,
  }) {
    return ProfileModel(
        id: id ?? this.id,
        imageUrl: imageUrl?.call() ?? this.imageUrl,
        firstAndLastName: firstAndLastName?.call() ?? this.firstAndLastName,
        location: location?.call() ?? this.location,
        noOfTikTokFollowers:
            noOfTikTokFollowers?.call() ?? this.noOfTikTokFollowers,
        noOfTikTokLikes: noOfTikTokLikes?.call() ?? this.noOfTikTokLikes,
        postsViews: postsViews?.call() ?? this.postsViews,
        email: email?.call() ?? this.email,
        profileLink: profileLink?.call() ?? this.profileLink,
        niches: niches?.call() ?? this.niches,
        bio: bio?.call() ?? this.bio,
        points: points?.call() ?? this.points,
        verificationStatus:
            verificationStatus?.call() ?? this.verificationStatus);
  }

  Map<String, String> toMap() {
    return {
      '_id': id,
      'imageURL': imageUrl ?? '',
      'firstAndLastName': firstAndLastName ?? '',
      'location': location ?? '',
      'noOfTikTokFollowers': noOfTikTokFollowers ?? '',
      'noOfTikTokLikes': noOfTikTokLikes ?? '',
      'postsViews': postsViews ?? '',
      'email': email ?? '',
      'tikTokLink': profileLink ?? '',
      'verificationStatus': verificationStatus ?? '',
      'bio': bio ?? '',
      'niches': niches?.join(",") ?? ''
      // ...{for (var element in niches ?? []) 'niches[]': element}
    };
  }

  Map<String, String> toStore() {
    return {
      '_id': id,
      'imageUrl': imageUrl ?? '',
      'firstAndLastName': firstAndLastName ?? '',
      'location': location ?? '',
      'noOfTikTokFollowers': noOfTikTokFollowers ?? '',
      'noOfTikTokLikes': noOfTikTokLikes ?? '',
      'postsViews': postsViews ?? '',
      'email': email ?? '',
      'tikTokLink': profileLink ?? '',
      'bio': bio ?? '',
      'niches': niches?.join(",") ?? ''
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['_id'] ?? '',
      imageUrl: map['imageURL'],
      firstAndLastName: map['firstAndLastName'],
      location: map['location'],
      noOfTikTokFollowers: map['noOfTikTokFollowers'],
      noOfTikTokLikes: map['noOfTikTokLikes'],
      postsViews: map['postsViews'],
      email: map['email'],
      points: map.containsKey('points')
          ? map['points'] != null
              ? InfluencerPoints.fromMap(map['points'])
              : null
          : null,
      verificationStatus: map['verificationStatus'],
      profileLink: map.containsKey('tikTokLink') ? map['tikTokLink'] : null,
      niches: List<String>.from(
          (map['niches'] as List<dynamic>).map((niche) => niche['name'])),
      bio: map['bio'],
    );
  }

  factory ProfileModel.fromStorage(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['_id'] ?? '',
      imageUrl: map['imageURL'],
      firstAndLastName: map['firstAndLastName'],
      location: map['location'],
      noOfTikTokFollowers: map['noOfTikTokFollowers'],
      noOfTikTokLikes: map['noOfTikTokLikes'],
      postsViews: map['postsViews'],
      email: map['email'],
      profileLink: map.containsKey('tikTokLink') ? map['tikTokLink'] : null,
      niches: List<String>.from(((map['niches'] as String).split(','))),
      bio: map['bio'],
    );
  }

  String toJson() => json.encode(toMap());
  String toStorage() => json.encode(toStore());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));

  factory ProfileModel.storage(String source) =>
      ProfileModel.fromStorage(json.decode(source));

  @override
  String toString() {
    return 'ProfileModel(id: $id, imageUrl: $imageUrl, firstAndLastName: $firstAndLastName, location: $location, email: $email, noOfTikTokFollowers: $noOfTikTokFollowers, noOfTikTokLikes: $noOfTikTokLikes, points: $points, postsViews: $postsViews, profileLink: $profileLink, niches: $niches, bio: $bio)';
  }

  Color verificationStatColor() {
    switch (verificationStatus) {
      case 'Not Started':
        return Colors.black;
      case 'Pending':
        return Colors.amber;
      case 'Failed':
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  bool isVerified() => verificationStatus == 'Verified';
}
