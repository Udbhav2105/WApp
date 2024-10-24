// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAhpE5ksObc6X9hsKMBW5mDydlpMjJPhoo',
    appId: '1:804514134571:web:f1843c621b4e58ee53486e',
    messagingSenderId: '804514134571',
    projectId: 'weatherapp-2a0e2',
    authDomain: 'weatherapp-2a0e2.firebaseapp.com',
    storageBucket: 'weatherapp-2a0e2.appspot.com',
    measurementId: 'G-CMQPE0X4SX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBe4VtXD2wb99j-x9RYVtkpt_09dVrZAnM',
    appId: '1:804514134571:android:2732a5ccf0b7f61753486e',
    messagingSenderId: '804514134571',
    projectId: 'weatherapp-2a0e2',
    storageBucket: 'weatherapp-2a0e2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApN5KqatlOi8XYhqxkQoSBSmDtU76Z8gM',
    appId: '1:804514134571:ios:22bb9b058c9948cd53486e',
    messagingSenderId: '804514134571',
    projectId: 'weatherapp-2a0e2',
    storageBucket: 'weatherapp-2a0e2.appspot.com',
    iosClientId: '804514134571-07ntgb46livhb7u69oa159tu1llkm2mc.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyApN5KqatlOi8XYhqxkQoSBSmDtU76Z8gM',
    appId: '1:804514134571:ios:22bb9b058c9948cd53486e',
    messagingSenderId: '804514134571',
    projectId: 'weatherapp-2a0e2',
    storageBucket: 'weatherapp-2a0e2.appspot.com',
    iosClientId: '804514134571-07ntgb46livhb7u69oa159tu1llkm2mc.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAhpE5ksObc6X9hsKMBW5mDydlpMjJPhoo',
    appId: '1:804514134571:web:1fe463891b18fa0d53486e',
    messagingSenderId: '804514134571',
    projectId: 'weatherapp-2a0e2',
    authDomain: 'weatherapp-2a0e2.firebaseapp.com',
    storageBucket: 'weatherapp-2a0e2.appspot.com',
    measurementId: 'G-7G5RBGBK7T',
  );

}