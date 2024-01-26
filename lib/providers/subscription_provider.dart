import 'package:flutter/material.dart';

import '../models/subscription_model.dart';
import '../services/config.dart';
import '../utils/global_variables.dart';

class SubscriptionProvider extends ChangeNotifier {
  List<Subscriptions> allSubscription = [];

  Subscriptions? userCurrentSub;

  Future<void> fetchSubscriptions() async {
    var response = await repository.getRequest(endpoint: Config.subscription);
    if (response.status) {
      List initList = response.data;
      allSubscription =
          initList.map((item) => Subscriptions.fromMap(item)).toList();
      notifyListeners();
    }
  }
}
