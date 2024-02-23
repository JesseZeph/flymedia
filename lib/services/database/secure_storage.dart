import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  final store = const FlutterSecureStorage();
  static const pinKey = 'pin';
  static const toolClient = 'tooltip_client';
  static const toolInfluencer = 'tooltip_influencer';

  Future<void> storeData({String? dataKey, String? value}) async {
    await store.write(key: dataKey ?? pinKey, value: value ?? '');
  }

  Future<String?> retrieveData({String? dataKey}) async {
    return await store.read(key: dataKey ?? pinKey);
  }

  Future<void> clearSecureData() async {
    store.delete(key: pinKey);
  }

  Future<bool> isPinSet() async {
    final pin = await retrieveData();
    return pin != null && pin.isNotEmpty;
  }

  Future<bool> verifyPin(String enteredPin) async {
    final savedPin = await retrieveData();
    return savedPin == enteredPin;
  }
}
