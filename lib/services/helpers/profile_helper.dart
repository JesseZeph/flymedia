import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:flymedia_app/models/response/get_all_influencers.dart';
import 'package:flymedia_app/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

mixin ProfileHelper {
  static var client = https.Client();

  Future<ProfileModel?> getUserProfile(String userId) async {
    ProfileModel? profile;

    try {
      final response = await http
          .get(Uri.https(Config.apiUrl, Config.influencerProfile + userId),
              headers: await getHeaders())
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () => http.Response('Network Timeout', 504),
          );
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if ((decodedResponse as Map).containsKey('_id')) {
          profile =
              ProfileModel.fromMap(decodedResponse as Map<String, dynamic>);
        }
      }
    } catch (e, s) {
      debugPrint("====> error in getting profile : ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }

    return profile;
  }

  Future<List<dynamic>> updateProfile(
      String userId, Map<String, String> details, bool hasFile,
      {bool isPutRequest = false}) async {
    var prefs = await SharedPreferences.getInstance();

    try {
      if (hasFile) {
        File file = File(details['imageURL'] ?? '');
        var request = http.MultipartRequest(isPutRequest ? 'PUT' : "POST",
            Uri.https(Config.apiUrl, Config.influencerProfile + userId))
          ..fields.addAll(details)
          ..headers.addAll(await getHeaders())
          ..files.add(http.MultipartFile.fromBytes(
              'influencerImage', file.readAsBytesSync(),
              filename: file.path.split(Platform.pathSeparator).last));

        var response = await request.send().timeout(
              const Duration(seconds: 15),
              onTimeout: () =>
                  http.StreamedResponse(Stream.fromIterable([]), 504),
            );

        if (response.statusCode == 200) {
        } else if (response.statusCode == 504) {
          return [false, 'Network Timeout'];
        }
        var finalResponse = await http.Response.fromStream(response);
        var decodedResponse = jsonDecode(finalResponse.body);
        return [decodedResponse['success'], decodedResponse['message']];
      } else {
        final response = await http
            .put(
                Uri.https(Config.apiUrl,
                    '${Config.influencerProfile}${details['_id']}'),
                headers: await getHeaders(),
                body: details)
            .timeout(
              const Duration(seconds: 15),
              onTimeout: () => http.Response('Network Timeout', 504),
            );

        if (response.statusCode == 200) {
          prefs.setBool('profile', true);
        } else if (response.statusCode == 504) {
          return [false, 'Network Timeout'];
        }
        var decodedResponse = jsonDecode(response.body);
        return [decodedResponse['success'], decodedResponse['message']];
      }
    } catch (e, s) {
      debugPrint("====> error in getting profile : ${e.toString()}");
      debugPrintStack(stackTrace: s);
    }

    return [false, 'An error occured, try again later'];
  }

  Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();

    return {'Authorization': 'Bearer ${prefs.getString('token')}'};
  }

  static Future<List<GetAllInfluencersRes>> getAllInfluencers(
      int pageNumber) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };
      List<GetAllInfluencersRes> resp = [];
      var url = Uri.https(Config.apiUrl, Config.influencerProfile,
          {'page': pageNumber.toString()});

      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        resp = getAllInfluencersResFromJson(response.body);
        return resp;
      } else {
        return resp;
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return [];
    }
  }
}
