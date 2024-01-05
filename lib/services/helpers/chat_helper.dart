import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flymedia_app/models/chats/chat_model.dart';
import 'package:flymedia_app/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatHelper {
  Future<List<ChatModel>> fetchUserMessages(
      {String? userId, String? userType}) async {
    List<ChatModel> chats = [];
    var url = Uri.https(Config.apiUrl, Config.chats,
        {"user_id": userId, "user_type": userType});

    try {
      var response = await http.get(url, headers: await getHeaders());

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        List initList = decodedResponse['data'];
        chats = initList.map((item) => ChatModel.fromMap(item)).toList();
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }

    return chats;
  }

  Future<ChatModel?> fetchSingleChat(
      {String? ownerId, String? influencerId}) async {
    ChatModel? chat;
    var url = Uri.https(Config.apiUrl, '${Config.chats}/single',
        {"company_owner_id": ownerId, "influencer_id": influencerId});

    try {
      var response = await http.get(url, headers: await getHeaders());

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        chat = ChatModel.fromMap(data);
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }

    return chat;
  }

  Future<ChatModel?> addChat(
      String clientId, String influencerId, String lastMessage) async {
    ChatModel? newChat;
    var url = Uri.https(
      Config.apiUrl,
      Config.chats,
    );
    try {
      var response = await http.post(url, headers: await getHeaders(), body: {
        "company_owner_id": clientId,
        "influencer_id": influencerId,
        "last_message": lastMessage
      });

      newChat = ChatModel.fromMap(jsonDecode(response.body)['data']);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }

    return newChat;
  }

  Future<void> updateChat({String? chatId, String? lastMessage}) async {
    var url = Uri.https(
      Config.apiUrl,
      Config.chats,
    );

    try {
      await http.put(url,
          headers: await getHeaders(),
          body: {"chat_id": chatId, "last_message": lastMessage});
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> updateChatStatus({String? chatId}) async {
    var url = Uri.https(
      Config.apiUrl,
      '${Config.chats}/status',
    );

    try {
      await http
          .post(url, headers: await getHeaders(), body: {"chat_id": chatId});
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  Future<List<dynamic>> deleteChat({String? chatId}) async {
    List<dynamic> resp = [false, 'An error occured, try again later.'];
    var url = Uri.https(
      Config.apiUrl,
      Config.chats,
    );

    try {
      var response = await http
          .delete(url, headers: await getHeaders(), body: {"chat_id": chatId});

      var decodedResponse = jsonDecode(response.body);

      resp = [decodedResponse['success'], decodedResponse['message']];
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }

    return resp;
  }

  Future<Map<String, String>> getHeaders() async {
    var prefs = await SharedPreferences.getInstance();
    return {"Authorization": "Bearer ${prefs.getString('token')}"};
  }
}
