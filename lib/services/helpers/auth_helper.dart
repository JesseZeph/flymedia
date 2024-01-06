import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/response/influencer_login_response.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/requests/auth/verification_code.dart';
import '../../models/response/login_response.dart';
import '../../models/response/signup_response.dart';
import '../config.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> signUp(String model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.signupUrl);
      var response =
          await client.post(url, headers: requestHeaders, body: model);
      if (response.statusCode == 201) {
        SignupResponse signupResponse =
            SignupResponse.fromJson(jsonDecode(response.body));

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', signupResponse.user!.email!);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("====> sign up error : ${e.toString()}");
      return false;
    }
  }

  static Future<bool> influenerRegister(String model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.influencerSignup);
      var response =
          await client.post(url, headers: requestHeaders, body: model);

      if (response.statusCode == 201) {
        SignupResponse signupResponse =
            SignupResponse.fromJson(jsonDecode(response.body));

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', signupResponse.user!.email!);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> verifyUserEmail(VerificationCode model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };
      var url = Uri.https(Config.apiUrl, Config.verifyEmail);
      var response = await client.patch(url,
          headers: requestHeaders, body: jsonEncode(model.toJson()));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> verifyInfluencerEmail(VerificationCode model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };
      var url = Uri.https(Config.apiUrl, Config.verifyEmail);
      var response = await client.patch(url,
          headers: requestHeaders, body: jsonEncode(model.toJson()));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<List<dynamic>> login(String model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.login);

      var response =
          await client.post(url, headers: requestHeaders, body: model);

      var decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        var verifiedCompany = (decodedResponse['company']
                as Map<String, dynamic>)['isVerified'] ??
            false;

        var user = loginResponseModelFromJson(response.body);
        await prefs.setString('token', user.userToken);
        await prefs.setString('userId', user.id);
        await prefs.setString('uid', user.uid);
        await prefs.setString('profile', user.profile);
        await prefs.setString('email', user.email);
        await prefs.setString('fullname', user.fullname);

        await prefs.setBool('loggedIn', true);
        return [true, decodedResponse['isVerified'], verifiedCompany];
      } else {
        return [false, decodedResponse['message']];
      }
    } catch (e, s) {
      debugPrint("==> login error: ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    return [false, 'An error occured. Try again later.'];
  }

  static Future<List<dynamic>> influencersLogin(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    try {
      var url = Uri.https(Config.apiUrl, Config.login);
      var response =
          await client.post(url, headers: requestHeaders, body: model);
      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var user = influencerLoginResponseModelFromJson(response.body);
        await prefs.setString('token', user.userToken);
        await prefs.setString('userId', user.id);
        await prefs.setString('uid', user.uid);
        await prefs.setString('profile', user.profile);
        await prefs.setString('fullname', user.fullname);

        await prefs.setBool('loggedIn', true);

        return [true, decodedResponse['isVerified']];
      } else {
        return [false, decodedResponse['message']];
      }
    } catch (e, s) {
      debugPrint("==> login error: ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    return [false, 'An error occured. Try again later.'];
  }
}
