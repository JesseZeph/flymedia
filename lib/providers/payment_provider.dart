import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:flymedia_app/services/config.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentNotifier extends ChangeNotifier {
  final String _userId = '';
  String get userId => _userId;

  var sessionId = '';

  var state = PaymentState.initial;
  Future<String> makepayment({String? plan}) async {
    state = PaymentState.loading;

    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}',
      };
      var body = {
        "plan": plan ?? 'price_1Og4MHFVGuxznuspRxJ8HnES',
        "userId": _userId
      };
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
    return 'An error occurred. Try again later.';
  }

  // var state = PaymentState.initial;
  Future<PaymentState> confirmPayment() async {
    state = PaymentState.loading;

    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}',
      };
      var body = {"sessionId": sessionId, "userId": _userId};
      var url = Uri.https(Config.apiUrl, Config.stripeConfirmPayment);
      log(url.toString());
      var response =
          await post(url, headers: requestHeaders, body: jsonEncode(body));
      var decodedResponse = jsonDecode(response.body);
      log(decodedResponse.toString());
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
