import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../services/config.dart';

Future<AuthorizationCredentialAppleID> appleAuth() async {
  final rawNonce = _generateNonce();
  final nonce = _sha256ofString(rawNonce);

  String clientID = 'com.example.flymedia-service';
  String callbackUrl =
      'https://${Config.apiUrl}/apple/callbacks/sign_up_with_apple';
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: Platform.isIOS ? nonce : null,
    webAuthenticationOptions: Platform.isIOS
        ? null
        : WebAuthenticationOptions(
            clientId: clientID,
            redirectUri: Uri.parse(callbackUrl),
          ),
  );

  return appleCredential;
}

String _generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

String _sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
