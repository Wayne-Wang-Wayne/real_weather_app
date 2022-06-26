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
    apiKey: 'AIzaSyAbG0b7tK4E3HLgPFd4AZod_VDR118YHtk',
    appId: '1:285819753618:web:802f988098e0f5d744824b',
    messagingSenderId: '285819753618',
    projectId: 'flutter-real-weather-app',
    authDomain: 'flutter-real-weather-app.firebaseapp.com',
    storageBucket: 'flutter-real-weather-app.appspot.com',
    measurementId: 'G-3YYR79DMPW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCG-hv0dWhBNJWUJxPVSlg4bL8ND6J2wL8',
    appId: '1:285819753618:android:ccd45dbbc1f27eca44824b',
    messagingSenderId: '285819753618',
    projectId: 'flutter-real-weather-app',
    storageBucket: 'flutter-real-weather-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1Iah2be1CPxsOABu41QIdqi4tlqOcw1I',
    appId: '1:285819753618:ios:11d6918e809d866644824b',
    messagingSenderId: '285819753618',
    projectId: 'flutter-real-weather-app',
    storageBucket: 'flutter-real-weather-app.appspot.com',
    iosClientId: '285819753618-mm4lvgusbinmd9mb50fvk092ls8onrgc.apps.googleusercontent.com',
    iosBundleId: 'com.wayne.realWeatherSharedApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD1Iah2be1CPxsOABu41QIdqi4tlqOcw1I',
    appId: '1:285819753618:ios:2dc2131926921cff44824b',
    messagingSenderId: '285819753618',
    projectId: 'flutter-real-weather-app',
    storageBucket: 'flutter-real-weather-app.appspot.com',
    iosClientId: '285819753618-vcan30p4jmiohm9nfpemd1o3t0hd5s1n.apps.googleusercontent.com',
    iosBundleId: 'com.example.realWeatherSharedApp',
  );
}