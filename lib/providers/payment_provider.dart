import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:flymedia_app/services/config.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentNotifier extends ChangeNotifier {
  var sessionId = '';

  var state = PaymentState.initial;
  Future<String> makepayment({String? plan}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = PaymentState.loading;
    notifyListeners();
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}',
      };
      var body = {"plan": plan, "userId": prefs.getString('userId') ?? ''};
      var url = Uri.https(Config.apiUrl, Config.stripemakePayment);
      var response =
          await post(url, headers: requestHeaders, body: jsonEncode(body));
      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        state = PaymentState.loaded;
        notifyListeners();
        sessionId = decodedResponse['data']['sessionId'];
        return decodedResponse['data']['redirectUrl'];
      } else {
        state = PaymentState.error;
        notifyListeners();
        return decodedResponse['message'];
      }
    } catch (e, s) {
      debugPrint("==> login error: ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    state = PaymentState.error;
    notifyListeners();
    return '';
  }

  Future<PaymentState> confirmPayment() async {
    state = PaymentState.loading;

    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}',
      };
      var body = {
        "sessionId": sessionId,
        "userId": prefs.getString('userId') ?? ''
      };
      var url = Uri.https(Config.apiUrl, Config.stripeConfirmPayment);
      log(url.toString());
      var response =
          await post(url, headers: requestHeaders, body: jsonEncode(body));
      if (response.statusCode == 200) {
        state = PaymentState.loaded;
        notifyListeners();
        // return decodedResponse['data']['redirectUrl'];
      } else {
        state = PaymentState.error;
        notifyListeners();
        // return decodedResponse['message'];
      }
    } catch (e, s) {
      state = PaymentState.error;
      notifyListeners();
      debugPrint("==> login error: ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }

    return state;
    // return 'An error occured. Try again later.';
  }

  Future<String> influencerPayment({String? campaignFee}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = PaymentState.loading;
    notifyListeners();
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}',
      };
      var body = {
        "campaignFee": campaignFee,
        "userId": prefs.getString('userId') ?? '',
      };
      var url = Uri.https(Config.apiUrl, Config.influencerPayment);
      var response =
          await post(url, headers: requestHeaders, body: jsonEncode(body));
      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        state = PaymentState.loaded;
        notifyListeners();
        sessionId = decodedResponse['data']['sessionId'];
        return decodedResponse['data']['sessionUrl'];
      } else {
        state = PaymentState.error;
        notifyListeners();
        return decodedResponse['message'];
      }
    } catch (e, s) {
      debugPrint("==> login error: ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    state = PaymentState.error;
    notifyListeners();
    return '';
  }

  Future<PaymentState> confirmCampaignPayment() async {
    state = PaymentState.loading;

    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}',
      };
      var body = {
        "sessionId": sessionId,
        "userId": prefs.getString('userId') ?? ''
      };
      var url = Uri.https(Config.apiUrl, Config.confirmCampaignPayment);
      log(url.toString());
      var response =
          await post(url, headers: requestHeaders, body: jsonEncode(body));
      if (response.statusCode == 200) {
        state = PaymentState.loaded;
        notifyListeners();
        // return decodedResponse['data']['redirectUrl'];
      } else {
        state = PaymentState.error;
        notifyListeners();
        // return decodedResponse['message'];
      }
    } catch (e, s) {
      state = PaymentState.error;
      notifyListeners();
      debugPrint("==> login error: ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }

    return state;
    // return 'An error occured. Try again later.';
  }
}

enum PaymentState { initial, loading, loaded, error }
