import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
        return linux;
      case TargetPlatform.fuchsia:
        throw UnsupportedError('Fuchsia is not configured for Firebase.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCt6HBT7sytg_mbbkq7sBu9qVsOW_qiYpY',
    appId: '1:473324619528:android:6a70aaee0cb97f2eefcebd',
    messagingSenderId: '473324619528',
    projectId: 'quickseva-446b7',
    storageBucket: 'quickseva-446b7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: '1:1234567890:ios:quickseva',
    messagingSenderId: '1234567890',
    projectId: 'quickseva-dev',
    storageBucket: 'quickseva-dev.appspot.com',
    iosBundleId: 'com.quickseva.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    appId: '1:1234567890:macos:quickseva',
    messagingSenderId: '1234567890',
    projectId: 'quickseva-dev',
    storageBucket: 'quickseva-dev.appspot.com',
    iosBundleId: 'com.quickseva.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'YOUR_WINDOWS_API_KEY',
    appId: '1:1234567890:windows:quickseva',
    messagingSenderId: '1234567890',
    projectId: 'quickseva-dev',
    storageBucket: 'quickseva-dev.appspot.com',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'YOUR_LINUX_API_KEY',
    appId: '1:1234567890:linux:quickseva',
    messagingSenderId: '1234567890',
    projectId: 'quickseva-dev',
    storageBucket: 'quickseva-dev.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY',
    appId: '1:1234567890:web:quickseva',
    messagingSenderId: '1234567890',
    projectId: 'quickseva-dev',
    authDomain: 'quickseva-dev.firebaseapp.com',
    storageBucket: 'quickseva-dev.appspot.com',
    measurementId: 'G-QUICKSEVA',
  );
}
