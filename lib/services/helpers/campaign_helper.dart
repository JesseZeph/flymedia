import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:http/http.dart' as https;

import '../../models/response/get_campaign_res.dart';
import '../config.dart';

class CampaignHelper {
  static var client = https.Client();

  static Future<List<CampaignUploadResponse>> getCampaigns() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.campaignUpload);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = campaignResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load campaign');
    }
  }

  static Future<GetCampaignRes> getCampaign(String campaignId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.campaignUpload}/$campaignId");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var campaign = getCampaignResFromJson(response.body);
      return campaign;
    } else {
      throw Exception('Failed to load campaign');
    }
  }

  static Future<List<CampaignUploadResponse>> searchCampaign(
      String query) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.searchCampaign}/$query");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var campaignList = campaignResponseFromJson(response.body);
      return campaignList;
    } else {
      throw Exception('Failed to load campaign');
    }
  }
}
