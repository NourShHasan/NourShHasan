import 'package:firebase_core/firebase_core.dart';
import 'package:gymmat/app/shared/utils/enums/enums.dart';
import 'package:gymmat/app/shared/utils/firebase/firebase_keys.dart';

import 'config.export.dart';

/// Init options for [FirebaseOptions]
FirebaseOptions get firebaseOptions {
  switch (appEnv) {
    case AppEnvironment.PRODUCTION:
      return const FirebaseOptions(
        appId: PROD_FIREBASE_APP_ID,
        apiKey: PROD_FIREBASE_API_KEY,
        projectId: PROD_FIREBASE_PROJECT_ID,
        messagingSenderId: PROD_FIREBASE_MESSAGING_SENDER_ID,
      );
    case AppEnvironment.STAGING:
      return const FirebaseOptions(
        appId: STAGING_FIREBASE_APP_ID,
        apiKey: STAGING_FIREBASE_API_KEY,
        projectId: STAGING_FIREBASE_PROJECT_ID,
        messagingSenderId: STAGING_FIREBASE_MESSAGING_SENDER_ID,
      );
    case AppEnvironment.DEV:
      return const FirebaseOptions(
        appId: STAGING_FIREBASE_APP_ID,
        apiKey: STAGING_FIREBASE_API_KEY,
        projectId: STAGING_FIREBASE_PROJECT_ID,
        messagingSenderId: STAGING_FIREBASE_MESSAGING_SENDER_ID,
      );
  }
}
