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
    apiKey: 'AIzaSyC-SopY04YOy6wL_BIPO6wHwCAfae-M48g',
    appId: '1:776171177484:web:b2e0b552ac88ec97a49029',
    messagingSenderId: '776171177484',
    projectId: 'attendance-system-5542a',
    authDomain: 'attendance-system-5542a.firebaseapp.com',
    storageBucket: 'attendance-system-5542a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSJsIW3AMykerRhqFlKhyUv7y4BIiEwSY',
    appId: '1:776171177484:android:de99dade2f2cdf3ca49029',
    messagingSenderId: '776171177484',
    projectId: 'attendance-system-5542a',
    storageBucket: 'attendance-system-5542a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbfw06QFEp89kOMPO8svDYeK9hU2NT2m0',
    appId: '1:776171177484:ios:ec3976fa616c026ca49029',
    messagingSenderId: '776171177484',
    projectId: 'attendance-system-5542a',
    storageBucket: 'attendance-system-5542a.appspot.com',
    iosBundleId: 'com.example.attendanceSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbfw06QFEp89kOMPO8svDYeK9hU2NT2m0',
    appId: '1:776171177484:ios:983f7f38558a4aa7a49029',
    messagingSenderId: '776171177484',
    projectId: 'attendance-system-5542a',
    storageBucket: 'attendance-system-5542a.appspot.com',
    iosBundleId: 'com.example.attendanceSystem.RunnerTests',
  );
}