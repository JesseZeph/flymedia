import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthHelper {
  final auth = FirebaseAuth.instance;

  static final firebaseAuthHelper = FirebaseAuthHelper._();

  factory FirebaseAuthHelper() => firebaseAuthHelper;

  FirebaseAuthHelper._();

  signIn({String? email, String? password}) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email ?? '', password: password ?? '');
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase sign in error: ${e.code}");
    }
  }

  signUp({String? email, String? password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email ?? '', password: password ?? '');
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase sign up error: ${e.code}");
    }
  }

  signOut() async {
    auth.signOut();
  }
}
