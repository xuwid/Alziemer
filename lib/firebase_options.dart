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
    apiKey: 'AIzaSyCR9fjSDTGhrnNyIuh989D2Phu27FBPZ5U',
    appId: '1:1010362692234:web:8b9e132c15849f918db373',
    messagingSenderId: '1010362692234',
    projectId: 'alzimer-hamza12',
    authDomain: 'alzimer-hamza12.firebaseapp.com',
    storageBucket: 'alzimer-hamza12.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsVnMCRMdNimXxxiJyH7aO1eHoxoBI5gM',
    appId: '1:1010362692234:android:fcaaba05fdd2bb838db373',
    messagingSenderId: '1010362692234',
    projectId: 'alzimer-hamza12',
    storageBucket: 'alzimer-hamza12.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnzZLYVknEuoXbNEA4Kk7estLrzQgE934',
    appId: '1:1010362692234:ios:11a4ea73652f25438db373',
    messagingSenderId: '1010362692234',
    projectId: 'alzimer-hamza12',
    storageBucket: 'alzimer-hamza12.firebasestorage.app',
    iosBundleId: 'com.example.alzimerapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnzZLYVknEuoXbNEA4Kk7estLrzQgE934',
    appId: '1:1010362692234:ios:11a4ea73652f25438db373',
    messagingSenderId: '1010362692234',
    projectId: 'alzimer-hamza12',
    storageBucket: 'alzimer-hamza12.firebasestorage.app',
    iosBundleId: 'com.example.alzimerapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCR9fjSDTGhrnNyIuh989D2Phu27FBPZ5U',
    appId: '1:1010362692234:web:352be7fffa1f401a8db373',
    messagingSenderId: '1010362692234',
    projectId: 'alzimer-hamza12',
    authDomain: 'alzimer-hamza12.firebaseapp.com',
    storageBucket: 'alzimer-hamza12.firebasestorage.app',
  );
}
