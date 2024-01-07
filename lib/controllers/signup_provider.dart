import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flymedia_app/models/requests/auth/verification_code.dart';
import 'package:flymedia_app/src/authentication/clientAuth/clientverification/userverificationsuccess.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/influencerverification/userverificationsuccess.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/requests/auth/signup.dart';
import '../services/helpers/auth_helper.dart';
import '../src/authentication/clientAuth/clientverification/verifyemailaddress.dart';
import '../src/authentication/influencerAuth/influencerverification/verifyemailaddress.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _loader = false;
  bool get loader => _loader;
  set loader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  bool? _loggedIn = false;
  bool get loggedIn => _loggedIn ?? false;
  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  final signupFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = signupFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(String model, {bool notSocialAuth = true}) async {
    if (notSocialAuth) {
      _loader = !_loader;
      notifyListeners();
    }

    bool wasSuccessful = false;
    await AuthHelper.signUp(model).then((response) {
      wasSuccessful = response;
    });
    if (notSocialAuth) {
      _loader = !_loader;
      notifyListeners();
    }
    return wasSuccessful;
  }

  Future<bool> influencerSignup(String model,
      {bool notSocialAuth = true}) async {
    if (notSocialAuth) {
      _loader = !_loader;
      notifyListeners();
    }
    bool wasSuccessful = false;
    await AuthHelper.influenerRegister(model).then((response) {
      wasSuccessful = response;
    });
    if (notSocialAuth) {
      _loader = !_loader;
      notifyListeners();
    }
    return wasSuccessful;
  }

  userEmailVerification(VerificationCode model, BuildContext cnt) async {
    _loader = !_loader;
    notifyListeners();
    await AuthHelper.verifyUserEmail(model).then((response) {
      if (response == true) {
        Get.offAll(const UserVerificationSuccessful());
      } else {
        cnt.showError('Invalid OTP');
      }
    });
    _loader = !_loader;
    notifyListeners();
  }

  influencerEmailVerification(VerificationCode model, BuildContext cnt) {
    _loader = !_loader;
    notifyListeners();
    AuthHelper.verifyInfluencerEmail(model).then(
      (response) {
        if (response == true) {
          Get.offAll(const InfluencerVerifySuccess());
        } else {
          cnt.showError('Invalid OTP');
        }
      },
    );
    _loader = !_loader;
    notifyListeners();
  }

  getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  signUpWithGoogle(BuildContext context, bool isClient) async {
    _loader = !_loader;
    notifyListeners();
    const List<String> scopes = <String>[
      'email',
    ];

    var googleSignIn = GoogleSignIn(
      scopes: scopes,
    );

    try {
      var userData = await googleSignIn.signIn();
      if (userData != null) {
        SignupModel model = SignupModel(
            fullname: userData.displayName ?? 'Anonymous',
            email: userData.email,
            password: userData.id);
        String newModel = signupModelToJson(model);
        if (isClient) {
          await signUp(newModel, notSocialAuth: false).then((success) {
            if (success) {
              Get.offAll(() => const VerifyEmailAccount());
            } else {
              context.showError("Sign up failed. Try again later.");
            }
          });
        } else {
          await influencerSignup(newModel, notSocialAuth: false)
              .then((success) {
            if (success) {
              Get.offAll(() => const InfluencerVerifyEmail());
            } else {
              context.showError("Sign up failed. Try again later.");
            }
          });
        }
      }
    } catch (e, s) {
      debugPrint("=======> error with google sign in: $e");
      debugPrintStack(stackTrace: s);
      context.showError('Could not authenticate');
    }

    _loader = !_loader;
    notifyListeners();
  }

  signUpWithApple(BuildContext context, bool isClient) async {
    _loader = !_loader;
    notifyListeners();
    String clientID = 'com.example.app-demo-service';
    String callbackUrl =
        'https://hurricane-insidious-shock.glitch.me/callbacks/sign_with_apple';

    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

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

      final AuthCredential appleAuthCredential =
          OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: Platform.isIOS ? rawNonce : null,
        accessToken: Platform.isIOS ? null : appleCredential.authorizationCode,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);

      if (userCredential.user != null) {
        SignupModel model = SignupModel(
            fullname: userCredential.user?.displayName ?? 'Anonymous',
            email: userCredential.user?.email ?? '',
            password: userCredential.user?.uid ?? '');
        String newModel = signupModelToJson(model);
        if (isClient) {
          await signUp(newModel, notSocialAuth: false).then((success) {
            if (success) {
              Get.offAll(() => const VerifyEmailAccount());
            } else {
              context.showError("Sign up failed. Try again later.");
            }
          });
        } else {
          await influencerSignup(newModel, notSocialAuth: false)
              .then((success) {
            if (success) {
              Get.offAll(() => const InfluencerVerifyEmail());
            } else {
              context.showError("Sign up failed. Try again later.");
            }
          });
        }
      }
    } catch (e, s) {
      debugPrint("=======> error with google sign in: $e");
      debugPrintStack(stackTrace: s);
      context.showError('Could not authenticate');
    }

    _loader = !_loader;
    notifyListeners();
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
