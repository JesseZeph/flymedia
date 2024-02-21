import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  final store = const FlutterSecureStorage();
  static const pinKey = 'pin';

  Future<void> storeData({String? key, String? value}) async {
    await store.write(key: key ?? '', value: value ?? '');
  }

  Future<String?> retrieveData(String key) async {
    return await store.read(key: key);
  }

  Future<void> clearSecureData() async => store.deleteAll();

  Future<bool> isPinSet() async {
    final pin = await retrieveData(pinKey);
    return pin != null && pin.isNotEmpty;
  }

  Future<bool> verifyPin(String enteredPin) async {
    final savedPin = await retrieveData(pinKey);
    return savedPin == enteredPin;
  }
}
