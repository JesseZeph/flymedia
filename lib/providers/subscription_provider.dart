import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/all_plan_model.dart';
import '../models/subscription_model.dart';
import '../services/config.dart';
import '../utils/global_variables.dart';

class SubscriptionProvider extends ChangeNotifier {
  // List<Subscriptions> allSubscription = [];
  List<AllPlanModel> allPlans = [];
  Subscriptions? userCurrentSub;
  String? subscriptionExpiry;

  Future<void> fetchSubscriptions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs.getString("token")}',
    };

    var url = Uri.https(Config.apiUrl, Config.allPlans);
    log(url.toString());
    var response = await get(url, headers: requestHeaders);
    var body = jsonDecode(response.body);
    log(body['data']['plans'].toString());
    for (var data in body['data']['plans']) {
      allPlans.add(AllPlanModel.fromJson(data));
      log(allPlans.length.toString());
    }
    log(allPlans.length.toString());
    notifyListeners();
  }
  // var response = await repository.getRequest(endpoint: Config.allPlans);
//     if (response.status) {
//       final body = jsonDecode(response.data);
//
//       log(response.data.toString());
//       List initList = response.data;
//       log(initList.toString());
// }
  // allSubscription =
  //     initList.map((item) => Subscriptions.fromMap(item)).toList();

  Future<void> fetchUserSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await repository.getRequest(
        endpoint: '${Config.subscription}/${prefs.getString('userId')}');
    if (response.status) {
      userCurrentSub = response.data['subscription'] == null
          ? null
          : Subscriptions.fromMap(response.data['subscription']);
      subscriptionExpiry = response.data['expires'] == null
          ? null
          : DateFormat.MMMd().format(response.data['expires']);
      notifyListeners();
    }
  }

  void init() {
    fetchSubscriptions();
    fetchUserSubscription();
  }
}
