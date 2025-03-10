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
    apiKey: 'AIzaSyBUpkFysa7Tl5BX5IiDgn1u2YBrgydyMlc',
    appId: '1:601988286642:web:15206553aa411f391321ab',
    messagingSenderId: '601988286642',
    projectId: 'ente-ph',
    authDomain: 'ente-ph.firebaseapp.com',
    storageBucket: 'ente-ph.firebasestorage.app',
    measurementId: 'G-M629Z11EM3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8ZrJV_Qna0rLItkl1twfbn-qNH7JFe4M',
    appId: '1:601988286642:android:2e357aef49ad0a041321ab',
    messagingSenderId: '601988286642',
    projectId: 'ente-ph',
    storageBucket: 'ente-ph.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1nfoFTzCABpg3Eo3mK-l81Nbz90Q8w-E',
    appId: '1:601988286642:ios:732923eacd719f5a1321ab',
    messagingSenderId: '601988286642',
    projectId: 'ente-ph',
    storageBucket: 'ente-ph.firebasestorage.app',
    iosBundleId: 'com.phanphuongnam.entePhotos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1nfoFTzCABpg3Eo3mK-l81Nbz90Q8w-E',
    appId: '1:601988286642:ios:732923eacd719f5a1321ab',
    messagingSenderId: '601988286642',
    projectId: 'ente-ph',
    storageBucket: 'ente-ph.firebasestorage.app',
    iosBundleId: 'com.phanphuongnam.entePhotos',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBUpkFysa7Tl5BX5IiDgn1u2YBrgydyMlc',
    appId: '1:601988286642:web:48e819cc1013d5b11321ab',
    messagingSenderId: '601988286642',
    projectId: 'ente-ph',
    authDomain: 'ente-ph.firebaseapp.com',
    storageBucket: 'ente-ph.firebasestorage.app',
    measurementId: 'G-DW7FLW6CQK',
  );
}
