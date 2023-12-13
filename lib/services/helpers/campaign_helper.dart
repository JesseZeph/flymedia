import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/requests/campaign/campain_upload.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/get_specific_campaign.dart';
import '../config.dart';

class CampaignHelper {
  static var client = https.Client();

  static Future<List<CampaignUploadResponse>> getCampaigns() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.getAllCampaigns);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = campaignResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load campaign');
    }
  }

  // static Future<GetSpecificClientCampaignRes> getUserCampaigns(
  //     String userId) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   String? userId = prefs.getString('userId');
  //
  //   if (token == null) {
  //     throw Exception('Failed to load campaign');
  //   }
  //
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'authorization': 'Bearer $token',
  //   };
  //
  //   var url = Uri.https(Config.apiUrl, Config.specificUserCampaign + userId!);
  //   print(url);
  //
  //   var response = await client.get(url, headers: requestHeaders);
  //
  //   if (response.statusCode == 200) {
  //     var specificClientCampaign =
  //         getSpecificClientCampaignResFromJson(response.body);
  //     return specificClientCampaign;
  //   } else {
  //     throw Exception('Failed to load campaign');
  //   }
  // }

  // static Future<GetCampaignRes> getCampaign(String campaignId) async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //   };

  //   var url = Uri.https(Config.apiUrl, "${Config.campaignUpload}/$campaignId");
  //   var response = await client.get(url, headers: requestHeaders);
  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     var campaign = getCampaignResFromJson(response.body);
  //     return campaign;
  //   } else {
  //     throw Exception('Failed to load campaign');
  //   }
  // }

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
        ..fields.addAll({
          "user_id": "${prefs.getString("userId")}",
          ...requestDetails.toJson()
        })
        ..headers
            .addAll({'Authorization': 'Bearer ${prefs.getString("token")}'})
        ..files.add(https.MultipartFile.fromBytes(
            'image', fileToUpload.readAsBytesSync(),
            filename: fileToUpload.path.split(Platform.pathSeparator).last));

      var response = await request.send().timeout(
            const Duration(seconds: 20),
            onTimeout: () =>
                https.StreamedResponse(Stream.fromIterable([]), 504),
          );
      var finalResponse = await https.Response.fromStream(response);

      final decodedResponse = jsonDecode(finalResponse.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return [decodedResponse['success'], 'Campaign posted successfully'];
      } else if (response.statusCode == 504) {
        return [false, 'Network Timeout'];
      }
      return [decodedResponse['success'], decodedResponse['message']];
    } catch (e, s) {
      debugPrint("===> error uploading campaign : ${e.toString()}");
      debugPrintStack(stackTrace: s);
      return [false, 'Error occurred, try again later.'];
    }
  }

  static Future<bool> deleteCampaign(String campaignId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}',
      };

      var url =
          Uri.https(Config.apiUrl, "${Config.deleteCampaign}/$campaignId");
      var response = await client.delete(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      debugPrint("===> error deleting campaign : ${e.toString()}");
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  static Future<GetSpecificClientCampaignRes?> getSpecificClientCampaigns(
      String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Map<String, String> requestHeaders = {
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString("token")}',
        HttpHeaders.contentTypeHeader: 'application/json',
      };

      var url =
          Uri.https(Config.apiUrl, Config.specificUserCampaign, {"id": userId});
      var response = await client.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        var clientCampaigns =
            GetSpecificClientCampaignRes.fromJson(json.decode(response.body));
        return clientCampaigns;
      } else {
        return null;
      }
    } catch (e, s) {
      debugPrint("===> error fetching client campaigns : ${e.toString()}");
      debugPrintStack(stackTrace: s);
      // throw Exception('Error occurred, try again later.');
    }
    return null;
  }
}
