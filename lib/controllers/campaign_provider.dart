import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/requests/campaign/campain_upload.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/services/helpers/campaign_helper.dart';

import '../models/response/get_campaign_res.dart';

class CampaignsNotifier extends ChangeNotifier {
  List<CampaignUploadResponse> campaignList = [];
  bool _isUploading = false;
  bool get isUploading => _isUploading;
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  late Future<GetCampaignRes> campaign;

  Future<void> getCampaigns() async {
    _isFetching = !_isFetching;
    campaignList = await CampaignHelper.getCampaigns();
    _isFetching = !_isFetching;
    notifyListeners();
  }

  // Future<List<GetSpecificClientCampaignRes>> getUserCampaigns(String userId) {
  //   return CampaignHelper.getUserCampaigns(userId);
  // }

  Future<List<Object>> postCampaign(CampaignUploadRequest details) async {
    _isUploading = !_isUploading;
    notifyListeners();
    List<Object> response = await CampaignHelper.uploadCampaign(details);
    await getCampaigns();
    _isUploading = !_isUploading;
    notifyListeners();

    return response;
  }

  Future<GetCampaignRes> getCampaign(String campaignId) {
    campaign = CampaignHelper.getCampaign(campaignId);
    return campaign;
  }
}
