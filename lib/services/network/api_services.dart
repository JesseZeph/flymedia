import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flymedia_app/models/network_response.dart';
import 'package:flymedia_app/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<NetworkResponse> getRequest(
      {String? endpoint,
      Map<String, String>? query,
      bool requiresHeader = true}) async {
    NetworkResponse finalResponse = NetworkResponse(
        status: false, message: 'Could not process request.', data: null);
    try {
      var response = await http
          .get(Uri.https(Config.apiUrl, endpoint ?? '', query),
              headers: requiresHeader ? await getHeaders() : null)
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => http.Response(
                jsonEncode({
                  "status": false,
                  "message": "Network Timeout",
                  "data": null
                }),
                408),
          );
      finalResponse = NetworkResponse.fromMap(jsonDecode(response.body));
    } catch (e, s) {
      debugPrint('======> request error: $e');
      debugPrintStack(stackTrace: s);
    }
    return finalResponse;
  }

  Future<NetworkResponse> postRequest(
      {String? endpoint,
      Map<String, String>? body,
      Map<String, String>? query,
      bool requiresHeader = true}) async {
    NetworkResponse finalResponse = NetworkResponse(
        status: false, message: 'Could not process request.', data: null);
    try {
      var response = await http
          .post(Uri.https(Config.apiUrl, endpoint ?? '', query),
              body: body, headers: requiresHeader ? await getHeaders() : null)
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => http.Response(
                jsonEncode({
                  "status": false,
                  "message": "Network Timeout",
                  "data": null
                }),
                408),
          );
      finalResponse = NetworkResponse.fromMap(jsonDecode(response.body));
    } catch (e, s) {
      debugPrint('======> request error: $e');
      debugPrintStack(stackTrace: s);
    }
    return finalResponse;
  }

  Future<NetworkResponse> putRequest(
      {String? endpoint,
      Map<String, String>? body,
      Map<String, String>? query,
      bool requiresHeader = true}) async {
    NetworkResponse finalResponse = NetworkResponse(
        status: false, message: 'Could not process request.', data: null);
    try {
      var response = await http
          .put(Uri.https(Config.apiUrl, endpoint ?? '', query),
              body: body, headers: requiresHeader ? await getHeaders() : null)
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => http.Response(
                jsonEncode({
                  "status": false,
                  "message": "Network Timeout",
                  "data": null
                }),
                408),
          );
      finalResponse = NetworkResponse.fromMap(jsonDecode(response.body));
    } catch (e, s) {
      debugPrint('======> request error: $e');
      debugPrintStack(stackTrace: s);
    }
    return finalResponse;
  }

  Future<NetworkResponse> deleteRequest(
      {String? endpoint,
      Map<String, String>? body,
      Map<String, String>? query,
      bool requiresHeader = true}) async {
    NetworkResponse finalResponse = NetworkResponse(
        status: false, message: 'Could not process request.', data: null);
    try {
      var response = await http
          .delete(Uri.https(Config.apiUrl, endpoint ?? '', query),
              body: body, headers: requiresHeader ? await getHeaders() : null)
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => http.Response(
                jsonEncode({
                  "status": false,
                  "message": "Network Timeout",
                  "data": null
                }),
                408),
          );
      finalResponse = NetworkResponse.fromMap(jsonDecode(response.body));
    } catch (e, s) {
      debugPrint('======> request error: $e');
      debugPrintStack(stackTrace: s);
    }
    return finalResponse;
  }

  Future<NetworkResponse> requestWithFile(
      {String? endpoint,
      String method = 'POST',
      Map<String, String>? body,
      Map<String, String>? query,
      Map<String, String> filesMap = const {},
      bool requiresHeader = true}) async {
    NetworkResponse finalResponse = NetworkResponse(
        status: false, message: 'Could not process request.', data: null);
    try {
      var request = http.MultipartRequest(
        method,
        Uri.https(Config.apiUrl, endpoint ?? '', query),
      )..headers.addAll(await getHeaders());
      if (body?.isNotEmpty ?? false) {
        request.fields.addAll(body ?? {});
      }
      filesMap.forEach((fieldName, filePath) {
        var file = File(filePath);
        request.files.add(http.MultipartFile.fromBytes(
            fieldName, file.readAsBytesSync(),
            filename: file.path.split(Platform.pathSeparator).last));
      });
      var response = await request.send().timeout(const Duration(seconds: 20),
          onTimeout: () => http.StreamedResponse(Stream.fromIterable([]), 408));
      if (response.statusCode == 408) {
        finalResponse.message = 'Network Timeout';
      } else {
        var newResponse = await http.Response.fromStream(response);
        finalResponse = NetworkResponse.fromMap(jsonDecode(newResponse.body));
      }
    } catch (e, s) {
      debugPrint('======> request error: $e');
      debugPrintStack(stackTrace: s);
    }
    return finalResponse;
  }

  Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();

    return {'Authorization': 'Bearer ${prefs.getString('token')}'};
  }
}
