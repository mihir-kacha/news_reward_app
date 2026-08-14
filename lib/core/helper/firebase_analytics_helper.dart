part of '../core.dart';

class FirebaseAnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static FirebaseAnalyticsObserver getObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  static Future<void> trackEvent(String name, {Map<String, Object>? params}) async {
    await _analytics.logEvent(name: name, parameters: params);
  }

  static Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  static Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  static Future<void> trackScreen(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  static Future<void> reset() async {
    await _analytics.setUserId(id: null);
  }
}
