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

  @override
  String toString() {
    return 'ChatMessages(clientId: $clientId, influencerId: $influencerId, type: $type, text: $text, fileName: $fileName, downloadUrl: $downloadUrl, sentBy: $sentBy, timeStamp: $timeStamp)';
  }

  bool isSender(String userId) => sentBy == userId;
  bool get isFile => type == 'File';
  bool justUploaded(int uploadTime) => (uploadTime - timeStamp!) <= 3000;
  String get filePath =>
      '${clientId.substring(17)}_${influencerId.substring(17)}/$fileName}';
}

class GroupMessages {
  String type;
  String? text;
  String? fileName;
  String? downloadUrl;
  String? senderName;
  String? senderId;
  String? senderImg;
  int? timeStamp;
  GroupMessages({
    required this.type,
    this.text,
    this.fileName,
    this.downloadUrl,
    this.senderName,
    this.senderId,
    this.senderImg,
    time,
  }) : timeStamp = time ?? DateTime.now().millisecondsSinceEpoch;

  GroupMessages copyWith({
    String? type,
    ValueGetter<String?>? text,
    ValueGetter<String?>? fileName,
    ValueGetter<String?>? downloadUrl,
    ValueGetter<String?>? senderName,
    ValueGetter<String?>? senderId,
    ValueGetter<String?>? senderImg,
    int? timeStamp,
  }) {
    return GroupMessages(
        type: type ?? this.type,
        text: text?.call() ?? this.text,
        fileName: fileName?.call() ?? this.fileName,
        downloadUrl: downloadUrl?.call() ?? this.downloadUrl,
        senderName: senderName?.call() ?? this.senderName,
        senderId: senderId?.call() ?? this.senderId,
        senderImg: senderImg?.call() ?? this.senderImg,
        time: timeStamp);
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'text': text,
      'fileName': fileName,
      'downloadUrl': downloadUrl,
      'senderName': senderName,
      'senderId': senderId,
      'senderImg': senderImg,
      'timeStamp': timeStamp,
    };
  }

  factory GroupMessages.fromMap(Map<String, dynamic> map) {
    return GroupMessages(
        type: map['type'] ?? '',
        text: map['text'],
        fileName: map['fileName'],
        downloadUrl: map['downloadUrl'],
        senderName: map['senderName'],
        senderId: map['senderId'],
        senderImg: map['senderImg'],
        time: map['timeStamp']);
  }

  @override
  String toString() {
    return 'ChatMessages( type: $type, text: $text, fileName: $fileName, downloadUrl: $downloadUrl, senderName: $senderName, senderId: $senderId, timeStamp: $timeStamp, senderImg: $senderImg)';
  }

  bool isSender(String userId) => senderId == userId;
  bool get isFile => type == 'File';
  bool justUploaded(int uploadTime) => (uploadTime - timeStamp!) <= 3000;
  // String get filePath =>
  //     '${clientId.substring(17)}_${influencerId.substring(17)}/$fileName}';
}
