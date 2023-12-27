import 'dart:convert';

import 'package:flutter/widgets.dart';

class ChatMessages {
  String clientId;
  String influencerId;
  String type;
  String? text;
  String? fileName;
  String? downloadUrl;
  String? sentBy;
  int? timeStamp;
  ChatMessages({
    required this.clientId,
    required this.influencerId,
    required this.type,
    this.text,
    this.fileName,
    this.downloadUrl,
    this.sentBy,
    time,
  }) : timeStamp = time ?? DateTime.now().millisecondsSinceEpoch;

  ChatMessages copyWith({
    String? clientId,
    String? influencerId,
    String? type,
    ValueGetter<String?>? text,
    ValueGetter<String?>? fileName,
    ValueGetter<String?>? downloadUrl,
    ValueGetter<String?>? sentBy,
    int? timeStamp,
  }) {
    return ChatMessages(
        clientId: clientId ?? this.clientId,
        influencerId: influencerId ?? this.influencerId,
        type: type ?? this.type,
        text: text?.call() ?? this.text,
        fileName: fileName?.call() ?? this.fileName,
        downloadUrl: downloadUrl?.call() ?? this.downloadUrl,
        sentBy: sentBy?.call() ?? this.sentBy,
        time: timeStamp);
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'influencerId': influencerId,
      'type': type,
      'text': text,
      'fileName': fileName,
      'downloadUrl': downloadUrl,
      'sentBy': sentBy,
      'timeStamp': timeStamp,
    };
  }

  factory ChatMessages.fromMap(Map<String, dynamic> map) {
    return ChatMessages(
        clientId: map['clientId'] ?? '',
        influencerId: map['influencerId'] ?? '',
        type: map['type'] ?? '',
        text: map['text'],
        fileName: map['fileName'],
        downloadUrl: map['downloadUrl'],
        sentBy: map['sentBy'],
        time: map['timeStamp']);
  }

  String toJson() => json.encode(toMap());

  factory ChatMessages.fromJson(String source) =>
      ChatMessages.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatMessages(clientId: $clientId, influencerId: $influencerId, type: $type, text: $text, fileName: $fileName, downloadUrl: $downloadUrl, sentBy: $sentBy, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatMessages &&
        other.clientId == clientId &&
        other.influencerId == influencerId &&
        other.type == type &&
        other.text == text &&
        other.fileName == fileName &&
        other.downloadUrl == downloadUrl &&
        other.timeStamp == timeStamp &&
        other.sentBy == sentBy;
  }

  @override
  int get hashCode {
    return clientId.hashCode ^
        influencerId.hashCode ^
        type.hashCode ^
        text.hashCode ^
        fileName.hashCode ^
        downloadUrl.hashCode ^
        timeStamp.hashCode ^
        sentBy.hashCode;
  }

  bool isSender(String userId) => sentBy == userId;
  bool get isFile => type == 'File';
  bool justUploaded(int uploadTime) => (uploadTime - timeStamp!) <= 3000;
}
