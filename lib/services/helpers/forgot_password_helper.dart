import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ForgotPasswordHelper extends ChangeNotifier {
  var client = http.Client();
  bool _isloading = false;
  bool get isloading => _isloading;
  String? recoveryMail;
  String? get mail => recoveryMail;
  set recoverMail(String? mail) {
    recoveryMail = mail;
  }

  Future<List<dynamic>> forgotPassword(String email) async {
    _isloading = !_isloading;
    notifyListeners();
    try {
      final response = await http.post(
          Uri.https(Config.apiUrl, Config.forgotPassword),
          body: {"email": email});

      final decodedResponse = jsonDecode(response.body);

      _isloading = !_isloading;
      notifyListeners();
      return [
        decodedResponse['status'] == "Success",
        decodedResponse['message']
      ];
    } catch (e, s) {
      debugPrint("error with forgot password : ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    _isloading = !_isloading;
    notifyListeners();
    return [false, 'An error occured.'];
  }

  Future<List<dynamic>> verifyOTP(String code) async {
    _isloading = !_isloading;
    notifyListeners();
    try {
      final response = await http.post(
          Uri.https(Config.apiUrl, Config.verifyOtp),
          body: {"verificationCode": code});

      final decodedResponse = jsonDecode(response.body);

      _isloading = !_isloading;
      notifyListeners();
      return [response.statusCode == 200, decodedResponse['message']];
    } catch (e, s) {
      debugPrint("error with verify otp : ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    _isloading = !_isloading;
    notifyListeners();
    return [false, 'An error occured.'];
  }

  Future<List<dynamic>> resendOTP() async {
    _isloading = !_isloading;
    notifyListeners();
    try {
      final response = await http.post(
          Uri.https(Config.apiUrl, Config.resendOtp),
          body: {"email": recoveryMail});

      final decodedResponse = jsonDecode(response.body);

      _isloading = !_isloading;
      notifyListeners();
      return [response.statusCode == 200, decodedResponse['message']];
    } catch (e, s) {
      debugPrint("error with verify otp : ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    _isloading = !_isloading;
    notifyListeners();
    return [false, 'An error occured.'];
  }

  Future<List<dynamic>> resetPassword(String newPassword) async {
    _isloading = !_isloading;
    notifyListeners();
    String userType = '';
    String? respMessage;
    try {
      final response = await http.patch(
          Uri.https(Config.apiUrl, Config.resetPassword),
          body: {"email": recoveryMail, "newPassword": newPassword});

      final decodedResponse = jsonDecode(response.body);
      respMessage = decodedResponse['message'];
      if (response.statusCode == 200) {
        userType = decodedResponse['userType'];
        int container = decodedResponse['userType'] == 'Influencer' ? 2 : 1;
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('token', decodedResponse['userToken']);
        await prefs.setString('userId', decodedResponse['_id']);
        // await prefs.setString('uid', decodedResponse['uid']);
        await prefs.setString('profile', decodedResponse['profile']);
        await prefs.setString('fullname', decodedResponse['fullname']);
        await prefs.setInt('selectedContainer', container);
        await prefs.setBool('loggedIn', true);
      }
      _isloading = !_isloading;
      notifyListeners();
      return [
        response.statusCode == 200,
        respMessage,
        userType == 'Influencer'
      ];
    } catch (e, s) {
      debugPrint("error with verify otp : ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    _isloading = !_isloading;
    notifyListeners();
    return [
      false,
      respMessage ?? 'An error occured.',
      userType == 'Influencer'
    ];
  }
}
