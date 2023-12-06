import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/requests/campaign/campain_upload.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/services/helpers/campaign_helper.dart';

class CampaignsNotifier extends ChangeNotifier {
  late Future<List<CampaignUploadResponse>> campaignList;
  bool _isUploading = false;
  bool get isUploading => _isUploading;
  // late Future<GetJobRes> job;

  Future<List<CampaignUploadResponse>> getCampaigns() {
    campaignList = CampaignHelper.getCampaigns();
    return campaignList;
  }

  Future<List<Object>> postCampaign(CampaignUploadRequest details) async {
    _isUploading = !_isUploading;
    notifyListeners();
    List<Object> response = await CampaignHelper.uploadCampaign(details);
    _isUploading = !_isUploading;
    notifyListeners();

    return response;
  }

  // Future<GetJobRes> getJob(String jobId) {
  //   job = JobsHelper.getJob(jobId);
  //   return job;
  // }
}
