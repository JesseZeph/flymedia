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
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  bool _fetchedCampaigns = false;
  bool get fetchedCampaigns => _fetchedCampaigns;
  late Future<GetCampaignRes> campaign;

  Future<void> getCampaigns() async {
    _isFetching = !_isFetching;
    campaignList = await CampaignHelper.getCampaigns();
    _isFetching = !_isFetching;
    notifyListeners();
  }

  Future<List<Object>> postCampaign(
      CampaignUploadRequest details, String userId) async {
    _isUploading = !_isUploading;
    notifyListeners();
    List<Object> response = await CampaignHelper.uploadCampaign(details);
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

  deleteCampaign(int index) {
    clientCampaigns.removeAt(index);
    notifyListeners();
  }
}
