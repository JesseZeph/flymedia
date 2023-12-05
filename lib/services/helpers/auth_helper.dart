import 'dart:convert';
import 'dart:developer';

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
    log('Verifying User ${model.email}');
    log('Verifying User ${model.verificationCode}');
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };
      var url = Uri.https(Config.apiUrl, Config.verifyEmail);
      var response = await client.patch(url,
          headers: requestHeaders, body: jsonEncode(model.toJson()));
      print({jsonDecode(response.body).toString()});
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
    log('Verifying User ${model.email}');
    log('Verifying User ${model.verificationCode}');
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };
      var url = Uri.https(Config.apiUrl, Config.verifyEmail);
      var response = await client.patch(url,
          headers: requestHeaders, body: jsonEncode(model.toJson()));
      print({jsonDecode(response.body).toString()});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login(String model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.login);
    var response = await client.post(url, headers: requestHeaders, body: model);
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var user = loginResponseModelFromJson(response.body);
      await prefs.setString('token', user.userToken);
      await prefs.setString('userId', user.id);
      await prefs.setString('uid', user.uid);
      await prefs.setString('profile', user.profile);
      await prefs.setString('fullname', user.fullname);
      await prefs.setBool('loggedIn', true);
      print('success');
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> influencersLogin(String model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.influencerLogin);
    var response = await client.post(url, headers: requestHeaders, body: model);
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var user = influencerLoginResponseModelFromJson(response.body);
      await prefs.setString('token', user.userToken);
      await prefs.setString('userId', user.id);
      await prefs.setString('uid', user.uid);
      await prefs.setString('profile', user.profile);
      await prefs.setString('fullname', user.fullname);
      await prefs.setBool('loggedIn', true);
      print('success');
      return true;
    } else {
      return false;
    }
  }
}
