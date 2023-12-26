import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreData {
  final _db = FirebaseFirestore.instance;

  Future sendMessage(
    String senderId,
    String recieverId,
  ) async {
    try {
      _db.collection('chats').doc(senderId);
    } catch (e) {}
  }
}
