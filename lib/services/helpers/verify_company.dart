import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class VerifyCompanyHelper {
  static var client = https.Client();

  static Future<bool> verifyCompany(String model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        return false;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };

      var url = Uri.https(Config.apiUrl, Config.companyVerification);

      var response =
          await client.post(url, headers: requestHeaders, body: model);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
