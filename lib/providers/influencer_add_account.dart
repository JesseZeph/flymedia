import 'package:flutter/material.dart';
import 'package:flymedia_app/models/requests/influencerAccount/influencer_account_request.dart';
import 'package:flymedia_app/models/response/get_accountdetails_res.dart';
import 'package:flymedia_app/services/config.dart';
import 'package:flymedia_app/utils/global_variables.dart';

class InfluencerAccountDetailsProvider extends ChangeNotifier {
  Data? accountdetails;

  Future<bool> postAccountDetails(InfluencerAddAccount accountDetails) async {
    Map<String, String> bodyMap = Map.castFrom(accountDetails.toJson());
    print(accountDetails.accountName);

    notifyListeners();

    var response = await repository.postRequest(
        endpoint: Config.addAccount, body: bodyMap);

    if (response.status) {
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<void> getAccountdetails(String id) async {
    var response =
        await repository.getRequest(endpoint: "${Config.addAccount}/id");
    print(response.data);

    print(response.message);
    if (response.status) {
      accountdetails = response.data;
      print(accountdetails);
      notifyListeners();
    }
  }
}
