import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flymedia_app/models/chats/chats_messages.dart';
import 'package:flymedia_app/services/helpers/chat_helper.dart';

import '../models/chats/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  ChatHelper helper = ChatHelper();
  List<ChatModel> userMessages = [];
  bool fetchingChat = true;
  int? uploadTime;
  double uploadProgress = 0;
  bool uploadingFile = false;
  UploadTask? uploadTask;

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

  Future<String?> getdownloadLink(ChatMessages message) async {
    String? downloadUrl;
    String path =
        '${message.clientId.substring(17)}_${message.influencerId.substring(17)}/${message.fileName}';
    var storageRef = FirebaseStorage.instance.ref();
    var fileRef = storageRef.child(path);
    downloadUrl = await fileRef.getDownloadURL();
    return downloadUrl;
  }

  Future<String?> uploadFileToStorage(
      File file, String clientId, String influencerId) async {
    String? downloadUrl;
    bool cancelled = false;
    print('===========> Got here 1 =============>');
    uploadingFile = !uploadingFile;
    uploadTime = DateTime.now().millisecondsSinceEpoch;
    notifyListeners();
    print('===========> Got here 2 =============>');
    String path =
        '${clientId.substring(17)}_${influencerId.substring(17)}/${file.path.split(Platform.pathSeparator).last}';
    print('===========> Got here 3 =============>');
    print('===========> path: $path =============>');
    var storageRef = FirebaseStorage.instance.ref();
    var fileRef = storageRef.child(path);
    uploadTask = fileRef.putFile(file);
    uploadTask?.snapshotEvents.listen((event) {
      switch (event.state) {
        case TaskState.running:
          uploadProgress = event.bytesTransferred / event.totalBytes;
          print(
              '===========> upload progress : $uploadProgress =============>');
          notifyListeners();
          break;
        case TaskState.paused:
        case TaskState.error:
        case TaskState.canceled:
          cancelled = true;
          break;
        case TaskState.success:
          break;
      }
    });
    uploadProgress = 0;
    uploadTime = null;
    uploadingFile = !uploadingFile;
    notifyListeners();
    downloadUrl = cancelled ? await fileRef.getDownloadURL() : null;
    return downloadUrl;
  }
}
