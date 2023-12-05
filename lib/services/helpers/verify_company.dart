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
        // Handle the case where the token is missing or empty.
        print("Token is missing or empty");
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
        print("Response body: ${response.body}");

        return true;
      } else {
        print("Verification failed with status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error during verification: $e");
      return false;
    }
  }
}
