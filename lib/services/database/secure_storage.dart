import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  final store = const FlutterSecureStorage();

  Future<void> storeData({String? key, String? value}) async {
    await store.write(key: key ?? '', value: value ?? '');
  }

  Future<String?> retrieveData(String key) async {
    return await store.read(key: key);
  }

  Future<void> clearSecureData() async => store.deleteAll();
}
