import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/requests/campaign/campain_upload.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<List<Object>> uploadCampaign(
      CampaignUploadRequest requestDetails) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      File fileToUpload = File(requestDetails.imageUrl);
      var request = https.MultipartRequest(
          'POST', Uri.https(Config.apiUrl, Config.campaignUpload))
        ..fields.addAll(requestDetails.toJson())
        ..headers
            .addAll({'Authorization': 'Bearer ${prefs.getString("token")}'})
        ..files.add(https.MultipartFile.fromBytes(
            'image', fileToUpload.readAsBytesSync()));
      var response = await request.send().timeout(
            const Duration(seconds: 20),
            onTimeout: () =>
                https.StreamedResponse(Stream.fromIterable([]), 504),
          );
      var finalResponse = await https.Response.fromStream(response);

      final decodedResponse = jsonDecode(finalResponse.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return [decodedResponse['success'], 'Campaign posted successfully'];
      }
      return [decodedResponse['success'], decodedResponse['message']];
    } catch (e, s) {
      debugPrint("===> error uploading campaign : ${e.toString()}");
      debugPrintStack(stackTrace: s);
      return [false, 'Error occurred, try again later.'];
    }
  }
}
