import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/requests/campaign/campain_upload.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/services/helpers/campaign_helper.dart';

import '../models/response/get_campaign_res.dart';
import '../models/response/get_specific_campaign.dart';

class CampaignsNotifier extends ChangeNotifier {
  late Future<List<CampaignUploadResponse>> campaignList;
  late Future<List<GetSpecificClientCampaignRes>> userCampaignList;

  bool _isUploading = false;
  bool get isUploading => _isUploading;
  late Future<GetCampaignRes> campaign;

  Future<List<CampaignUploadResponse>> getCampaigns() {
    campaignList = CampaignHelper.getCampaigns();
    return campaignList;
  }

  Future<List<GetSpecificClientCampaignRes>> getUserCampaigns(String userId) {
    userCampaignList = CampaignHelper.getUserCampaigns(userId);
    return userCampaignList;
  }

  Future<List<Object>> postCampaign(CampaignUploadRequest details) async {
    _isUploading = !_isUploading;
    notifyListeners();
    List<Object> response = await CampaignHelper.uploadCampaign(details);
    _isUploading = !_isUploading;
    notifyListeners();

    return response;
  }

  Future<GetCampaignRes> getCampaign(String campaignId) {
    campaign = CampaignHelper.getCampaign(campaignId);
    return campaign;
  }
}
