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
    apiKey: 'AIzaSyBOi7mulphewn2petzrtk1vMtcj4SHsk0M',
    appId: '1:583921155202:web:1d13586ce4bdbdab7b089b',
    messagingSenderId: '583921155202',
    projectId: 'movies-app-9917c',
    authDomain: 'movies-app-9917c.firebaseapp.com',
    storageBucket: 'movies-app-9917c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHFvRvS-C3M09zE2YmrIzjDnKZjq-JlAQ',
    appId: '1:583921155202:android:10d410485e98af827b089b',
    messagingSenderId: '583921155202',
    projectId: 'movies-app-9917c',
    storageBucket: 'movies-app-9917c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXrevB5rt_P6EpQM4Zv6_Z3tXhdYD_nLk',
    appId: '1:583921155202:ios:6f53100843a045457b089b',
    messagingSenderId: '583921155202',
    projectId: 'movies-app-9917c',
    storageBucket: 'movies-app-9917c.appspot.com',
    iosBundleId: 'com.example.movies',
  );
}
