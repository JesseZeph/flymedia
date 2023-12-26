class ChatModel {
  String id;
  dynamic companyOwnerId;
  dynamic influencerId;
  String lastMessage;
  int newMessagesCount;
  ChatModel({
    required this.id,
    required this.companyOwnerId,
    required this.influencerId,
    required this.lastMessage,
    required this.newMessagesCount,
  });

  Map<String, String> toMap() {
    return {
      'id': id,
      'company_owner_id': companyOwnerId,
      'influencer_id': influencerId,
      'last_message': lastMessage,
      'new_messages_count': newMessagesCount.toString(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['_id'] ?? '',
      companyOwnerId: map['company'],
      influencerId: map['influencer'],
      lastMessage: map['last_message'] ?? '',
      newMessagesCount: map['new_messages_count'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'ChatModel(id: $id, companyOwnerId: $companyOwnerId, influencerId: $influencerId, lastMessage: $lastMessage, firestoreDocName: $newMessagesCount)';
  }
}
