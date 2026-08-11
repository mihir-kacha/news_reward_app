part of 'ads.dart';

class AppLifecycleReactor {
  final AdHelper adHelper;

  AppLifecycleReactor({required this.adHelper});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();

    AppStateEventNotifier.appStateStream.listen(_onAppStateChanged);
  }

  void _onAppStateChanged(AppState state) {
    if (state == AppState.foreground) {
      adHelper.showAppOpen();
    } else {
      adHelper.loadAppOpen();
    }
  }
}
