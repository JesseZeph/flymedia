import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/services/helpers/campaign_helper.dart';

import '../models/response/get_campaign_res.dart';

class CampaignsNotifier extends ChangeNotifier {
  late Future<List<CampaignUploadResponse>> campaignList;
  late Future<GetCampaignRes> campaign;

  Future<List<CampaignUploadResponse>> getCampaigns() {
    campaignList = CampaignHelper.getCampaigns();
    return campaignList;
  }

  Future<GetCampaignRes> getCampaign(String campaignId) {
    campaign = CampaignHelper.getCampaign(campaignId);
    return campaign;
  }
}
