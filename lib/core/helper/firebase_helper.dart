part of '../core.dart';

class FirebaseHelper {
  Future<void> initializeApp() async {
    if (kIsWeb) return;
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  //--------------- Crashlytics ---------------//
  Future<void> setCrashlyticsCollectionEnabled([bool enabled = true]) async {
    if (kIsWeb) return;
    return FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled);
  }

  Future<void> recordFlutterError(FlutterErrorDetails errorDetails) async {
    if (kIsWeb) return;
    return FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  }

  Future<void> recordError(dynamic error, StackTrace stackTrace) async {
    if (kIsWeb) return;
    return FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  //--------------- end ---------------//
}
