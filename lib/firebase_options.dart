import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError('This platform is not supported');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBOOEcB-7M3iA7xjE2IKgjbhOeakdUHwrg',
    appId: '1:662126021349:web:2a693cdd34b4fbd68c4a42',
    messagingSenderId: '662126021349',
    projectId: 'rewear-4bffc',
    databaseURL: 'https://rewear-4bffc-default-rtdb.firebaseio.com',
    storageBucket: 'rewear-4bffc.appspot.com',
    authDomain: 'rewear-4bffc.firebaseapp.com',
    measurementId: 'G-XXXXXX', // optional
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOOEcB-7M3iA7xjE2IKgjbhOeakdUHwrg',
    appId: '1:662126021349:android:e1b9364d1a5cbfdd8c4a42',
    messagingSenderId: '662126021349',
    projectId: 'rewear-4bffc',
    databaseURL: 'https://rewear-4bffc-default-rtdb.firebaseio.com',
    storageBucket: 'rewear-4bffc.appspot.com',
  );
}
