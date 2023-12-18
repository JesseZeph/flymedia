import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ApplicationsHelper extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  var client = http.Client();

  Future<List> applyToCampaign(
      {String userId = '', String campaignId = ''}) async {
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
    return [false, 'An error occurred.'];
  }

  Future<List<ProfileModel>> campaignApplicants(
      {String campaignId = ''}) async {
    List<ProfileModel> returnList = [];
    try {
      final response = await http.get(
        Uri.https(Config.apiUrl, Config.campaignApplicants, {"id": campaignId}),
        // headers: await getHeaders(),
      );

      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List initList = decodedResponse['influencerApplications'];
        returnList =
            initList.map((profile) => ProfileModel.fromMap(profile)).toList();
      }
    } catch (e, s) {
      debugPrint("error with fetching campaign applicants : ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }
    return returnList;
  }

  Future<bool> validateToken() async {
    var prefs = await SharedPreferences.getInstance();
    var url = Uri.https(Config.apiUrl, Config.validateToken);
    var response =
        await http.post(url, body: {"token": "${prefs.getString('token')}"});

    var decodedResponse = jsonDecode(response.body);

    return decodedResponse["is_valid"];
  }

  Future<bool> validateCompany(String userId) async {
    var url = Uri.https(Config.apiUrl, Config.validateCompany);
    var response = await http.post(url, body: {"user_id": userId});

    var decodedResponse = jsonDecode(response.body);

    return decodedResponse["is_verified"];
  }

  Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();

    return {'Authorization': 'Bearer ${prefs.getString('token')}'};
  }
}
