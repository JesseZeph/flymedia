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
  String? email;
  String? profileLink;
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
    this.email,
    this.profileLink,
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
    ValueGetter<String?>? email,
    ValueGetter<String?>? profileLink,
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
      email: email?.call() ?? this.email,
      profileLink: profileLink?.call() ?? this.profileLink,
      niches: niches?.call() ?? this.niches,
      bio: bio?.call() ?? this.bio,
    );
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
    return 'ProfileModel(id: $id, imageUrl: $imageUrl, firstAndLastName: $firstAndLastName, location: $location, email: $email, noOfTikTokFollowers: $noOfTikTokFollowers, noOfTikTokLikes: $noOfTikTokLikes, postsViews: $postsViews, profileLink: $profileLink, niches: $niches, bio: $bio)';
  }
}
