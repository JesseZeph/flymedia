import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ApplicationsHelper extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  var client = http.Client();

  Future<List> applyToCampaign(
      {String userId = '', String campaignId = ''}) async {
    print("=====> influencer id : $userId ==========>");
    print("=====> campaign id : $campaignId ==========>");
    _isLoading = !_isLoading;
    notifyListeners();
    try {
      final response = await http.post(
          Uri.https(Config.apiUrl, '${Config.campaignApplication}/apply'),
          headers: await getHeaders(),
          body: {"influencerId": userId, "campaignId": campaignId});

      final decodedResponse = jsonDecode(response.body);

      _isLoading = !_isLoading;
      notifyListeners();
      return [decodedResponse['success'], decodedResponse['message']];
    } catch (e, s) {
      debugPrint("error with applying to campaign : ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    _isLoading = !_isLoading;
    notifyListeners();
    return [false, 'An error occured.'];
  }

  Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();

    return {'Authorization': 'Bearer ${prefs.getString('token')}'};
  }
}
