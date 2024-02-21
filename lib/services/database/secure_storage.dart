import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  final store = const FlutterSecureStorage();
  static const pinKey = 'pin';

  Future<void> storeData({String? value}) async {
    await store.write(key: pinKey, value: value ?? '');
  }

  Future<String?> retrieveData() async {
    return await store.read(key: pinKey);
  }

  Future<void> clearSecureData() async => store.deleteAll();

  Future<bool> isPinSet() async {
    final pin = await retrieveData();
    return pin != null && pin.isNotEmpty;
  }

  Future<bool> verifyPin(String enteredPin) async {
    final savedPin = await retrieveData();
    return savedPin == enteredPin;
  }
}
