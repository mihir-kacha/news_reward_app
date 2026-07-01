import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inshorts/data/preference/preference.dart';
import 'package:network/network.dart';

import 'core/core.dart';

void bootstrap({required FutureOr<Widget> Function() builder, required Environment env}) {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final firebaseHelper = FirebaseHelper();
      Env().setEnvironment(env);
      await Future.wait([
        _configureFirebase(firebaseHelper: firebaseHelper),
        _configureSystemUi(),
        Preference().init(),
        EnvHelper.instance.initialize(),
      ]);
      return runApp(await builder());
    },
    (error, stack) {
      debugPrint(error.toString());
      debugPrint(stack.toString());
      throw error;
    },
  );
}

Future<void> _configureFirebase({required FirebaseHelper firebaseHelper}) async {
  if (kIsWeb) return;
  await firebaseHelper.initializeApp();
  firebaseHelper.setCrashlyticsCollectionEnabled(!kDebugMode);

  // Record flutter errors in firebase crashlytics
  var defaultFlutterErrorHandler = FlutterError.onError;
  FlutterError.onError = (details) {
    firebaseHelper.recordFlutterError(details);
    defaultFlutterErrorHandler?.call(details);
  };

  // Record async errors in firebase crashlytics
  var defaultPlatformErrorHandler = PlatformDispatcher.instance.onError;
  PlatformDispatcher.instance.onError = (error, stack) {
    firebaseHelper.recordError(error, stack);
    return defaultPlatformErrorHandler?.call(error, stack) ?? false;
  };
}

Future<void> _configureSystemUi() async {
  await Future.wait([
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: true,
      systemStatusBarContrastEnforced: false,
    ),
  );
}
