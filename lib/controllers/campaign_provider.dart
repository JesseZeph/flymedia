import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/services/helpers/campaign_helper.dart';

class CampaignsNotifier extends ChangeNotifier {
  late Future<List<CampaignUploadResponse>> campaignList;
  // late Future<GetJobRes> job;

  Future<List<CampaignUploadResponse>> getCampaigns() {
    campaignList = CampaignHelper.getCampaigns();
    return campaignList;
  }

  // Future<GetJobRes> getJob(String jobId) {
  //   job = JobsHelper.getJob(jobId);
  //   return job;
  // }
}
