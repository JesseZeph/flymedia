import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/subscription_model.dart';
import '../services/config.dart';
import '../utils/global_variables.dart';

class SubscriptionProvider extends ChangeNotifier {
  List<Subscriptions> allSubscription = [];

  Subscriptions? userCurrentSub;
  String? subscriptionExpiry;

  Future<void> fetchSubscriptions() async {
    var response = await repository.getRequest(endpoint: Config.subscription);
    if (response.status) {
      List initList = response.data;
      allSubscription =
          initList.map((item) => Subscriptions.fromMap(item)).toList();
      notifyListeners();
    }
  }

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
