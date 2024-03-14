class GroupChat {
  String id;
  String groupName;
  String groupImage;
  String lastMessage;
  int newMessageCount;
  int newMessageCountClient;
  GroupChat({
    required this.id,
    required this.groupName,
    required this.groupImage,
    required this.lastMessage,
    required this.newMessageCount,
    required this.newMessageCountClient,
  });

  GroupChat copyWith({
    String? id,
    String? groupName,
    String? groupImage,
    String? lastMessage,
    int? newMessageCount,
    int? newMessageCountClient,
  }) {
    return GroupChat(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      groupImage: groupImage ?? this.groupImage,
      lastMessage: lastMessage ?? this.lastMessage,
      newMessageCount: newMessageCount ?? this.newMessageCount,
      newMessageCountClient:
          newMessageCountClient ?? this.newMessageCountClient,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'group_name': groupName,
      'group_image': groupImage,
      'last_message': lastMessage,
      'new_message_count': newMessageCount,
      'new_message_count_client': newMessageCountClient,
    };
  }

  factory GroupChat.fromMap(Map<String, dynamic> map) {
    return GroupChat(
      id: map['_id'] ?? '',
      groupName: map['group_name'] ?? '',
      groupImage: map['group_image'] ?? '',
      lastMessage: map['last_message'] ?? '',
      newMessageCount: map['new_message_count']?.toInt() ?? 0,
      newMessageCountClient: map['new_message_count_client']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'GroupChat(id: $id, groupName: $groupName, groupImage: $groupImage, lastMessage: $lastMessage, newMessageCount: $newMessageCount, newMessageCountClient: $newMessageCountClient)';
  }

  bool hasNewMessages(bool isClient) =>
      isClient ? newMessageCountClient > 0 : newMessageCount > 0;
}
