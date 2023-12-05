import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:http/http.dart' as https;

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
}
