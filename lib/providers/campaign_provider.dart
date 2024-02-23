import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/network_response.dart';
import 'package:flymedia_app/models/requests/campaign/campain_upload.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/services/config.dart';
import 'package:flymedia_app/services/helpers/campaign_helper.dart';
import 'package:flymedia_app/utils/global_variables.dart';

import '../models/active_campaigns.dart';
import '../models/response/get_campaign_res.dart';

class CampaignsNotifier extends ChangeNotifier {
  List<CampaignUploadResponse> campaignList = [];
  List<CampaignUploadResponse> clientCampaigns =
      []; // Change the type to List<Campaign>

  bool _isUploading = false;
  bool get isUploading => _isUploading;
  bool _isFetching = true;
  bool get isFetching => _isFetching;
  bool _fetchedCampaigns = false;
  bool get fetchedCampaigns => _fetchedCampaigns;
  late Future<GetCampaignRes> campaign;

  Future<bool> getCampaigns(int page, {bool isLoadingMore = false}) async {
    bool canLoadMore = true;
    if (isLoadingMore) {
      var newList = await CampaignHelper.getCampaigns(page);
      campaignList.addAll(newList);
      canLoadMore = newList.isNotEmpty && newList.length == 20;
    } else {
      campaignList = await CampaignHelper.getCampaigns(page);
      canLoadMore = campaignList.isNotEmpty && campaignList.length == 20;
    }
    _isFetching = false;
    notifyListeners();
    return canLoadMore;
  }

  Future<List<Object>> postCampaign(
    CampaignUploadRequest details,
    String userId,
    // int maxCampaigns
  ) async {
    _isUploading = !_isUploading;
    notifyListeners();
    List<Object> response = await CampaignHelper.uploadCampaign(
      details,
      // maxCampaigns\
    );
    getClientCampaigns(userId);
    _isUploading = !_isUploading;
    notifyListeners();

    return response;
  }

  Future<void> getClientCampaigns(String userId) async {
    var resp = await CampaignHelper.getSpecificClientCampaigns(userId);

    if (resp != null) {
      clientCampaigns = resp.campaign;
    }
    _fetchedCampaigns = true;
    notifyListeners();
  }

  Future<List<ActiveCampaignModel>> fetchActiveCampaigns(
      {required String userType, required String id}) async {
    var response = await repository.getRequest(
        endpoint: '${Config.campaignUpload}/assign/$id',
        query: {'type': userType});
    if (response.status) {
      List initList = response.data;
      List<ActiveCampaignModel> campaigns = initList.map((item) {
        return ActiveCampaignModel.fromMap(item);
      }).toList();
      return campaigns;
    }
    return [];
  }

  Future<NetworkResponse> verifyOrCompleteCampaign(
      {required String userType,
      required String id,
      required String campaignId}) async {
    var response = await repository.putRequest(
        endpoint: '${Config.campaignUpload}/assign',
        body: {
          "active_campaign_id": campaignId,
          "id": id,
          "user_type": userType
        });
    return response;
  }

  sortCampaigns(int sortIndex) {
    _isFetching = true;
    notifyListeners();
    switch (sortIndex) {
      // sort based on highest amount to be paid
      case 0:
        campaignList.sort((a, b) =>
            (int.tryParse(a.rate) ?? 0).compareTo(int.tryParse(b.rate) ?? 0));
        campaignList = campaignList.reversed.toList();
        break;
      case 1: // sort based on lowest min followers required.
        campaignList.sort((a, b) => a.minFollowers.compareTo(b.minFollowers));
        campaignList = campaignList.reversed.toList();
        break;
      // case 2:
      //   campaignList.sort((a, b) =>
      //       (int.tryParse(a.rate) ?? 0).compareTo(int.tryParse(b.rate) ?? 0));
      //   campaignList = campaignList.reversed.toList();
      //   notifyListeners();
      //   break;
    }
    _isFetching = false;
    notifyListeners();
  }

  deleteCampaign(int index) {
    clientCampaigns.removeAt(index);
    notifyListeners();
  }
}
