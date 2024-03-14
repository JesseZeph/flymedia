import 'dart:io';

import 'package:background_downloader/background_downloader.dart'
    as bg_downloader;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flymedia_app/models/chats/chats_messages.dart';
import 'package:flymedia_app/models/network_response.dart';
import 'package:flymedia_app/services/config.dart';
import 'package:flymedia_app/services/helpers/chat_helper.dart';
import 'package:flymedia_app/utils/global_variables.dart';

import '../models/chats/chat_model.dart';
import '../models/chats/group_chat.dart';

class ChatProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  ChatHelper helper = ChatHelper();
  List<ChatModel> userMessages = [];
  List<GroupChat> userGroups = [];
  bool fetchingChat = true;
  int? uploadTime;
  double taskProgress = 0;
  bool uploadingFile = false;
  bool downloadingFile = false;
  UploadTask? uploadTask;
  String? currentTaskId;

  fetchUserMessages(String userId, String userType) async {
    try {
      List<NetworkResponse> messages = await Future.wait([
        repository.getRequest(
            endpoint: Config.chats,
            query: {"user_id": userId, "user_type": userType}),
        repository.getRequest(
            endpoint: '${Config.chats}/groups',
            query: {"user_id": userId, "user_type": userType}),
      ]);
      if (messages.first.status) {
        List initList = messages.first.data;
        userMessages = initList.map((item) => ChatModel.fromMap(item)).toList();
      }
      if (messages.last.status) {
        List initList = messages.last.data;
        userGroups = initList.map((item) => GroupChat.fromMap(item)).toList();
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
    // List<ChatModel> messages =
    //     await helper.fetchUserMessages(userId: userId, userType: userType);
    // messages.sort((a, b) => a.newMessagesCount.compareTo(b.newMessagesCount));
    // userMessages = messages.reversed.toList();
    fetchingChat = false;

    notifyListeners();
  }

  Future<ChatModel?> addChat(String clientId, String influencerId,
      String lastMessage, String userId, String userType) async {
    var chat = await helper.addChat(clientId, influencerId, lastMessage);
    await fetchUserMessages(userId, userType);
    return chat;
  }

  updateChat(
      String? chatId, String? lastMessage, String userId, String userType,
      {bool isGroup = false}) async {
    var endPointToUse = isGroup ? '${Config.chats}/groups' : Config.chats;
    await repository.putRequest(endpoint: endPointToUse, body: {
      "chat_id": chatId ?? '',
      "last_message": lastMessage ?? '',
      "user_type": userType
    });
    // await helper.updateChat(
    //     chatId: chatId, lastMessage: lastMessage, user: userType);
    await fetchUserMessages(userId, userType);
  }

  updateChatStatus(String? chatId, String userId, String userType,
      {bool isGroup = false}) async {
    var endPointToUse =
        isGroup ? '${Config.chats}/groups/status' : '${Config.chats}/status';

    await repository.postRequest(
        endpoint: endPointToUse,
        body: {"chat_id": chatId ?? '', "user_type": userType});
    // await helper.updateChatStatus(chatId: chatId, user: userType);
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

  Query<GroupMessages> groupChatStream({String? groupName}) {
    return _db
        .collection('chats')
        .doc('groups')
        .collection(groupName ?? '')
        // .orderBy('timestamp', descending: true)
        .withConverter<GroupMessages>(
            fromFirestore: (snapshot, _) =>
                GroupMessages.fromMap(snapshot.data() ?? {}),
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

  sendGroupMessage(GroupMessages message, String groupName) async {
    try {
      _db
          .collection('groups')
          .doc('chats')
          .collection(groupName)
          .add(message.toMap());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  Future<String?> uploadFileToStorage(
      File file, String clientId, String influencerId) async {
    String? downloadUrl;
    bool cancelled = false;
    uploadingFile = !uploadingFile;
    uploadTime = DateTime.now().millisecondsSinceEpoch;
    notifyListeners();
    String path =
        '${clientId.substring(17)}/${influencerId.substring(17)}/${file.path.split(Platform.pathSeparator).last}';
    var storageRef = FirebaseStorage.instance.ref();
    var fileRef = storageRef.child(path);
    try {
      // uploadTask = fileRef.putFile(file);
      // uploadTask?.snapshotEvents.listen((event) {
      fileRef.putFile(file).snapshotEvents.listen((event) {
        switch (event.state) {
          case TaskState.running:
            taskProgress = event.bytesTransferred / event.totalBytes;
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
      await fileRef.putFile(file);
    } on FirebaseException catch (e) {
      debugPrint("========> firebase storage error: '${e.code}': ${e.message}");
    }

    taskProgress = 0;
    uploadTime = null;
    uploadingFile = !uploadingFile;
    notifyListeners();
    downloadUrl = cancelled ? null : await fileRef.getDownloadURL();
    return downloadUrl;
  }

  Future<bg_downloader.TaskStatusUpdate?> downloadFile(
      bg_downloader.DownloadTask task) async {
    bg_downloader.TaskStatusUpdate? result;
    downloadingFile = !downloadingFile;
    currentTaskId = task.taskId;
    notifyListeners();
    try {
      result = await bg_downloader.FileDownloader().download(
        task,
        onProgress: (progress) {
          taskProgress = progress;
          notifyListeners();
        },
      );
    } catch (e, s) {
      debugPrint("error with downloading file: $e");
      debugPrintStack(stackTrace: s);
    }
    downloadingFile = !downloadingFile;

    notifyListeners();
    return result;
  }
}
