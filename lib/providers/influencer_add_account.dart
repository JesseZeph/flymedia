import 'package:flutter/material.dart';
import 'package:flymedia_app/models/network_response.dart';
import 'package:flymedia_app/models/response/get_accountdetails_res.dart';
import 'package:flymedia_app/services/config.dart';
import 'package:flymedia_app/utils/global_variables.dart';

class InfluencerAccountDetailsProvider extends ChangeNotifier {
  GetAccountResponse? getAccountResponse;

  Future<void> postAccountDetails(
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
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> editAccountDetails(
      {required String id,
      required String name,
      required String accountNumber,
      required String bankName}) async {
    try {
      var response = await repository.putRequest(
        endpoint: Config.addAccount,
        body: {
          "account_id": getAccountResponse?.id ?? '',
          "account_name": name,
          "account_number": accountNumber,
          "bank_name": bankName
        },
      );
      if (response.status) {
        getAccountResponse = GetAccountResponse.fromJson(response.data);
        notifyListeners();
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> getAccountDetails(String influencerId) async {
    var response = await repository.getRequest(
        endpoint: '${Config.addAccount}/$influencerId');
    if (response.status) {
      getAccountResponse = GetAccountResponse.fromJson(response.data);
      notifyListeners();
    }
  }

  Future<NetworkResponse> deleteAccount(String influencerId) async {
    var response = await repository.deleteRequest(
        endpoint: Config.addAccount,
        body: {'account_id': getAccountResponse?.id ?? ''});
    if (response.status) {
      getAccountResponse = null;
      notifyListeners();
    }
    return response;
  }
}
