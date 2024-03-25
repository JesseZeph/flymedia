// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfwbDKwzd1XyD6wr__SRHrG346GYq9Y3M',
    appId: '1:89477570848:android:7108c411a1b6183e067745',
    messagingSenderId: '89477570848',
    projectId: 'flymedia-app-7a2b9',
    databaseURL: 'https://flymedia-app-7a2b9-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flymedia-app-7a2b9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAab6xIoRhgIx7InB9l7dD-iv9mfp--rlM',
    appId: '1:89477570848:ios:f3cf1786269ade21067745',
    messagingSenderId: '89477570848',
    projectId: 'flymedia-app-7a2b9',
    databaseURL: 'https://flymedia-app-7a2b9-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flymedia-app-7a2b9.appspot.com',
    androidClientId: '89477570848-7a4p75d6tade0an7egardi9bavomlnl9.apps.googleusercontent.com',
    iosClientId: '89477570848-7b77a855a47rplgtb24iap65joi4annh.apps.googleusercontent.com',
    iosBundleId: 'com.flymedia.app',
  );
}
