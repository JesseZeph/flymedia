import 'package:flutter/material.dart';
import 'package:flymedia_app/models/requests/auth/verification_code.dart';
import 'package:flymedia_app/src/authentication/clientAuth/clientverification/userverificationsuccess.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/influencerverification/userverificationsuccess.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
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

      // if (response == true) {
      //   Get.offAll(const InfluencerVerifyEmail());
      // } else {
      //   loader = false;
      //   Get.snackbar('Sign up failed', 'Please check your details',
      //       colorText: Colors.white,
      //       backgroundColor: AppColors.errorColor,
      //       icon: const Icon(Icons.add_alert));
      // }
    });
    _loader = !_loader;
    notifyListeners();
    return wasSuccessful;
  }

  userEmailVerification(VerificationCode model) async {
    loader = !loader;
    notifyListeners();
    await AuthHelper.verifyUserEmail(model).then((response) {
      if (response == true) {
        Get.offAll(const UserVerificationSuccessful());
      } else {
        loader = false;
        Get.snackbar('Verification failed', 'invalid OTP',
            colorText: Colors.white,
            backgroundColor: AppColors.errorColor,
            icon: const Icon(
              Icons.add_alert,
              color: AppColors.lightHintTextColor,
            ));
      }
    });
    loader = !loader;
    notifyListeners();
  }

  influencerEmailVerification(VerificationCode model) {
    AuthHelper.verifyInfluencerEmail(model).then(
      (response) {
        if (response == true) {
          Get.offAll(const InfluencerVerifySuccess());
        } else {
          loader = false;
          Get.snackbar('Verification failed', 'invalid OTP',
              colorText: Colors.white,
              backgroundColor: AppColors.errorColor,
              icon: const Icon(
                Icons.add_alert,
                color: AppColors.lightHintTextColor,
              ));
        }
      },
    );
  }

  getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // selectedContainer = prefs.getInt('selectedContainer') ?? 0;
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }
}
