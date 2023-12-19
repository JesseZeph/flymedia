import 'package:flutter/material.dart';
import 'package:flymedia_app/models/requests/auth/verification_code.dart';
import 'package:flymedia_app/src/authentication/clientAuth/clientverification/userverificationsuccess.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/influencerverification/userverificationsuccess.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/helpers/auth_helper.dart';

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

  Future<bool> signUp(String model) async {
    _loader = !_loader;
    notifyListeners();
    bool wasSuccessful = false;
    await AuthHelper.signUp(model).then((response) {
      wasSuccessful = response;
    });
    _loader = !_loader;
    notifyListeners();
    return wasSuccessful;
  }

  Future<bool> influencerSignup(String model) async {
    _loader = !_loader;
    notifyListeners();
    bool wasSuccessful = false;
    await AuthHelper.influenerRegister(model).then((response) {
      wasSuccessful = response;
    });
    _loader = !_loader;
    notifyListeners();
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
}
