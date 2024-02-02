import 'package:flutter/material.dart';
import 'package:flymedia_app/models/network_response.dart';
import 'package:flymedia_app/models/requests/influencerAccount/influencer_account_request.dart';
import 'package:flymedia_app/models/response/get_accountdetails_res.dart';
import 'package:flymedia_app/services/config.dart';
import 'package:flymedia_app/utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfluencerAccountDetailsProvider extends ChangeNotifier {
  GetAccountResponse? getAccountResponse;

  Future<NetworkResponse> postAccountDetails(
      {required String id,
      required String name,
      required String accountNumber,
      required String bankName}) async {
    try {
      var response = await repository.postRequest(
        endpoint: Config.addAccount,
        body: {
          "influencer_id": id,
          "account_name": name,
          "account_number": accountNumber,
          "bank_name": bankName
        },
      );
      if (response.status) {
        getAccountResponse = GetAccountResponse.fromJson(response.data);
        notifyListeners();
      }
      notifyListeners();

      return response;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw Exception();
    }
  }

  Future<NetworkResponse> editAccountDetails(
      {required String id,
      required String name,
      required String accountNumber,
      required String bankName}) async {
    try {
      var response = await repository.putRequest(
        endpoint: Config.addAccount,
        body: {
          "influencer_id": id,
          "account_name": name,
          "account_number": accountNumber,
          "bank_name": bankName
        },
      );
      return response;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw Exception();
    }
  }

  Future<void> getAccountDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await repository.getRequest(
        endpoint: '${Config.addAccount}/${prefs.getString('userId')}');
    print('-->> $response');
    if (response.status) {
      getAccountResponse = GetAccountResponse.fromJson(response.data);
      notifyListeners();
    }
  }

  void init() {
    getAccountDetails();
  }
}
