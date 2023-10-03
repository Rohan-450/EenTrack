// File generated by FlutterFire CLI.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// / Default [FirebaseOptions] for use with your Firebase apps.
// /
// / Example:
// / ```dart
// / import 'firebase_options.dart';
// / // ...
// / await Firebase.initializeApp(
// /   options: DefaultFirebaseOptions.currentPlatform,
// / );
// / ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAZWo18kQu1T4jdLhzyvmgCCPJbbud4QbE',
    appId: '1:628728276338:web:4625094877d605a16ca9eb',
    messagingSenderId: '628728276338',
    projectId: 'eentrack',
    authDomain: 'eentrack.firebaseapp.com',
    storageBucket: 'eentrack.appspot.com',
    measurementId: 'G-XHVLJ974FP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNUXWhHf3EqgO_ajUBEs5_dhXSW93pHo8',
    appId: '1:628728276338:android:37d548768a510a5a6ca9eb',
    messagingSenderId: '628728276338',
    projectId: 'eentrack',
    storageBucket: 'eentrack.appspot.com',
  );
}
