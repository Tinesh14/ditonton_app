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
    apiKey: 'AIzaSyDa0439V2VXNGwWvTsk2QUpOAu6iTs7VPI',
    appId: '1:816603198079:web:e2030cba94e2e130bec54a',
    messagingSenderId: '816603198079',
    projectId: 'ditonton-a4ac6',
    authDomain: 'ditonton-a4ac6.firebaseapp.com',
    storageBucket: 'ditonton-a4ac6.appspot.com',
    measurementId: 'G-NXYZT8J72N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzbSc1WcTu7prKCxJClsDKDRRjvRz4eyU',
    appId: '1:816603198079:android:63d74da03b390066bec54a',
    messagingSenderId: '816603198079',
    projectId: 'ditonton-a4ac6',
    storageBucket: 'ditonton-a4ac6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkVCwg-XcvW_aysRx6r3ah24MCaRyP3yc',
    appId: '1:816603198079:ios:db20e1eba7765096bec54a',
    messagingSenderId: '816603198079',
    projectId: 'ditonton-a4ac6',
    storageBucket: 'ditonton-a4ac6.appspot.com',
    iosBundleId: 'com.example.ditontonApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkVCwg-XcvW_aysRx6r3ah24MCaRyP3yc',
    appId: '1:816603198079:ios:db20e1eba7765096bec54a',
    messagingSenderId: '816603198079',
    projectId: 'ditonton-a4ac6',
    storageBucket: 'ditonton-a4ac6.appspot.com',
    iosBundleId: 'com.example.ditontonApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDa0439V2VXNGwWvTsk2QUpOAu6iTs7VPI',
    appId: '1:816603198079:web:bed84e642bc3f1c7bec54a',
    messagingSenderId: '816603198079',
    projectId: 'ditonton-a4ac6',
    authDomain: 'ditonton-a4ac6.firebaseapp.com',
    storageBucket: 'ditonton-a4ac6.appspot.com',
    measurementId: 'G-JKFFZ713GG',
  );
}