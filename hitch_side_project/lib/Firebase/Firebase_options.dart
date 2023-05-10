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

      case TargetPlatform.windows:
       /*   return win; */
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
      apiKey: "AIzaSyB_5Qy6YcorX4QC8XkWNFvtY1UMFVA9igw",
      appId: "1:923827506019:android:578dc5a4f6e2cfcbb92156",
      messagingSenderId: "923827506019",
      projectId: "hitch---sideproject",
      storageBucket: "hitch---sideproject.appspot.com",
      authDomain: "hitch---sideproject.firebaseapp.com",
      measurementId: ""
      );

 static const FirebaseOptions win = FirebaseOptions(
      apiKey: "AIzaSyB_5Qy6YcorX4QC8XkWNFvtY1UMFVA9igw",
      appId: "1:923827506019:android:578dc5a4f6e2cfcbb92156",
      messagingSenderId: "923827506019",
      projectId: "hitch---sideproject",
      storageBucket: "hitch---sideproject.appspot.com",
      authDomain: "hitch---sideproject.firebaseapp.com",
      measurementId: ""
      );
 static const FirebaseOptions android = FirebaseOptions(
      apiKey: "AIzaSyB_5Qy6YcorX4QC8XkWNFvtY1UMFVA9igw",
      appId: "1:923827506019:android:578dc5a4f6e2cfcbb92156",
      messagingSenderId: "923827506019",
      projectId: "hitch---sideproject",
      storageBucket: "hitch---sideproject.appspot.com",
      );
}
