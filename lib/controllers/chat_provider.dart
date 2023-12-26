import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flymedia_app/models/chats/chats_messages.dart';
import 'package:flymedia_app/services/helpers/chat_helper.dart';

import '../models/chats/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  ChatHelper helper = ChatHelper();
  List<ChatModel> userMessages = [];
  bool fetchingChat = true;

  final _db = FirebaseFirestore.instance;

  fetchUserMessages(String userId, String userType) async {
    List<ChatModel> messages =
        await helper.fetchUserMessages(userId: userId, userType: userType);
    messages.sort((a, b) => a.newMessagesCount.compareTo(b.newMessagesCount));
    userMessages = messages.reversed.toList();
    fetchingChat = false;
    notifyListeners();
  }

  addChat(ChatModel chat, String userId, String userType) async {
    await helper.addChat(chat);
    await fetchUserMessages(userId, userType);
  }

  updateChat(String? chatId, String? lastMessage, String userId,
      String userType) async {
    await helper.updateChat(chatId: chatId, lastMessage: lastMessage);
    await fetchUserMessages(userId, userType);
  }

  updateChatStatus(String? chatId, String userId, String userType) async {
    await helper.updateChatStatus(
      chatId: chatId,
    );
    await fetchUserMessages(userId, userType);
  }

  deleteChat(String? chatId, String userId, String userType) async {
    await helper.deleteChat(chatId: chatId);
    await fetchUserMessages(userId, userType);
  }

  Future<ChatModel?> fetchSpecificChat(
      String ownerId, String influencerId) async {
    var chat = await helper.fetchSingleChat(
        ownerId: ownerId, influencerId: influencerId);
    return chat;
  }

  Query<ChatMessages> chatStream({String? clientId, String? influencerId}) {
    return _db
        .collection('chats')
        .doc(clientId)
        .collection(influencerId ?? '')
        // .orderBy('timestamp', descending: true)
        .withConverter<ChatMessages>(
            fromFirestore: (snapshot, _) =>
                ChatMessages.fromMap(snapshot.data() ?? {}),
            toFirestore: (message, _) => message.toMap());
  }

  sendMessage(ChatMessages message) async {
    try {
      _db
          .collection('chats')
          .doc(message.clientId)
          .collection(message.influencerId)
          .add(message.toMap());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }
}
