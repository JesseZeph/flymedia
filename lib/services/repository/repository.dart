import 'package:flymedia_app/services/network/api_services.dart';

import '../../models/network_response.dart';
import '../database/secure_storage.dart';

class Repository {
  final _apiService = ApiService();
  final _secureDb = SecureStore();

  Future<NetworkResponse> getRequest(
          {String? endpoint,
          Map<String, String>? query,
          bool requiresHeader = true}) async =>
      _apiService.getRequest(
          endpoint: endpoint, query: query, requiresHeader: requiresHeader);

  Future<NetworkResponse> postRequest(
          {String? endpoint,
          Map<String, String>? body,
          Map<String, String>? query,
          bool requiresHeader = true}) async =>
      _apiService.postRequest(
          endpoint: endpoint,
          body: body,
          query: query,
          requiresHeader: requiresHeader);

  Future<NetworkResponse> putRequest(
          {String? endpoint,
          Map<String, String>? body,
          Map<String, String>? query,
          bool requiresHeader = true}) async =>
      _apiService.putRequest(
          endpoint: endpoint,
          body: body,
          query: query,
          requiresHeader: requiresHeader);

  Future<NetworkResponse> deleteRequest(
          {String? endpoint,
          Map<String, String>? body,
          Map<String, String>? query,
          bool requiresHeader = true}) async =>
      _apiService.deleteRequest(
          endpoint: endpoint,
          body: body,
          query: query,
          requiresHeader: requiresHeader);

  Future<NetworkResponse> requestWithFile(
          {String? endpoint,
          String method = 'POST',
          Map<String, String>? body,
          Map<String, String>? query,
          Map<String, String> filesMap = const {},
          bool requiresHeader = true}) async =>
      _apiService.requestWithFile(
          endpoint: endpoint,
          method: method,
          body: body,
          query: query,
          filesMap: filesMap,
          requiresHeader: requiresHeader);

  Future<void> storeData({String? dataKey, String? value}) async =>
      _secureDb.storeData(dataKey: dataKey, value: value);

  Future<String?> retrieveData({String? dataKey}) async =>
      _secureDb.retrieveData(dataKey: dataKey);

  Future<void> clearSecureData() async => _secureDb.clearSecureData();

  Future<bool> isPinSet() async => _secureDb.isPinSet();

  Future<bool> verifyPin(String enteredPin) async =>
      _secureDb.verifyPin(enteredPin);
}
