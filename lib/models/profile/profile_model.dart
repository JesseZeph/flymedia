import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProfileModel {
  String id;
  String? imageUrl;
  String? firstAndLastName;
  String? location;
  String? noOfTikTokFollowers;
  String? noOfTikTokLikes;
  String? postsViews;
  List<String>? niches;
  String? bio;
  ProfileModel({
    required this.id,
    this.imageUrl,
    this.firstAndLastName,
    this.location,
    this.noOfTikTokFollowers,
    this.noOfTikTokLikes,
    this.postsViews,
    this.niches,
    this.bio,
  });

  ProfileModel copyWith({
    String? id,
    ValueGetter<String?>? imageUrl,
    ValueGetter<String?>? firstAndLastName,
    ValueGetter<String?>? location,
    ValueGetter<String?>? noOfTikTokFollowers,
    ValueGetter<String?>? noOfTikTokLikes,
    ValueGetter<String?>? postsViews,
    ValueGetter<List<String>?>? niches,
    ValueGetter<String?>? bio,
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
      niches: niches?.call() ?? this.niches,
      bio: bio?.call() ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'firstAndLastName': firstAndLastName,
      'location': location,
      'noOfTikTokFollowers': noOfTikTokFollowers,
      'noOfTikTokLikes': noOfTikTokLikes,
      'postsViews': postsViews,
      'niches': niches,
      'bio': bio,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'],
      firstAndLastName: map['firstAndLastName'],
      location: map['location'],
      noOfTikTokFollowers: map['noOfTikTokFollowers'],
      noOfTikTokLikes: map['noOfTikTokLikes'],
      postsViews: map['postsViews'],
      niches: List<String>.from(map['niches']),
      bio: map['bio'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileModel(id: $id, imageUrl: $imageUrl, firstAndLastName: $firstAndLastName, location: $location, noOfTikTokFollowers: $noOfTikTokFollowers, noOfTikTokLikes: $noOfTikTokLikes, postsViews: $postsViews, niches: $niches, bio: $bio)';
  }
}
