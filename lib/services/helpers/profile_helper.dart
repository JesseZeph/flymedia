import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:flymedia_app/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileHelper {
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
    try {
      if (hasFile) {
        File file = File(details['imageUrl'] ?? '');
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

        if (response.statusCode == 504) {
          return [false, 'Network Timeout'];
        }
        var finalResponse = await http.Response.fromStream(response);
        var decodedResponse = jsonDecode(finalResponse.body);
        getUserProfile(userId);
        return [decodedResponse['success'], decodedResponse['message']];
      } else {
        final response = await http
            .put(
                Uri.https(Config.apiUrl,
                    '${Config.influencerProfile}${details['id'] ?? ''}'),
                headers: await getHeaders(),
                body: details)
            .timeout(
              const Duration(seconds: 15),
              onTimeout: () => http.Response('Network Timeout', 504),
            );

        if (response.statusCode == 504) {
          return [false, 'Network Timeout'];
        }

        var decodedResponse = jsonDecode(response.body);
        getUserProfile(userId);
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
}
