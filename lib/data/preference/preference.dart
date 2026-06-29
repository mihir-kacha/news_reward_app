import 'dart:convert';

import 'package:network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preference_keys.dart';

class Preference {
  Preference._();

  static final Preference _instance = Preference._();

  factory Preference() => _instance;
  SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  //---------- login states ----------//

  set isLogin(bool status) => prefs?.setBool(PreferenceKeys.isLogin, status);

  bool get isLogin => prefs?.getBool(PreferenceKeys.isLogin) ?? false;

  set isShowOnBoarding(bool show) => prefs?.setBool(PreferenceKeys.showOnBoarding, show);

  bool get isShowOnBoarding => prefs?.getBool(PreferenceKeys.showOnBoarding) ?? true;

  DateTime? _getTimer(String key) {
    final val = prefs?.getString(key);
    if (val == null) return null;
    return DateTime.tryParse(val);
  }

  void _setTimer(String key, DateTime? value) {
    if (value == null) {
      prefs?.remove(key);
    } else {
      prefs?.setString(key, value.toIso8601String());
    }
  }

  set luckTimer(DateTime? value) => _setTimer(PreferenceKeys.luckTimer, value);

  DateTime? get luckTimer => _getTimer(PreferenceKeys.luckTimer);

  set drinkWaterTimer(DateTime? value) => _setTimer(PreferenceKeys.drinkWaterTimer, value);

  DateTime? get drinkWaterTimer => _getTimer(PreferenceKeys.drinkWaterTimer);

  set walkTimer(DateTime? value) => _setTimer(PreferenceKeys.walkTimer, value);

  DateTime? get walkTimer => _getTimer(PreferenceKeys.walkTimer);

  set exerciseTimer(DateTime? value) => _setTimer(PreferenceKeys.exerciseTimer, value);

  DateTime? get exerciseTimer => _getTimer(PreferenceKeys.exerciseTimer);

  set prayTimer(DateTime? value) => _setTimer(PreferenceKeys.prayTimer, value);

  DateTime? get prayTimer => _getTimer(PreferenceKeys.prayTimer);

  //---------- Daily Limit states ----------//

  set coins(int status) => prefs?.setInt(PreferenceKeys.coins, status);

  int get coins => prefs?.getInt(PreferenceKeys.coins) ?? 0;

  set minCoins(int status) => prefs?.setInt(PreferenceKeys.minCoins, status);

  int get minCoins => prefs?.getInt(PreferenceKeys.minCoins) ?? 0;

  set coinsConfig(CoinsConfig config) {
    prefs?.setString(PreferenceKeys.coinsConfig, jsonEncode(config.toJson()));
  }

  CoinsConfig get coinsConfig {
    final data = prefs?.getString(PreferenceKeys.coinsConfig);

    if (data != null) {
      return CoinsConfig.fromJson(jsonDecode(data) as Map<String, dynamic>);
    }

    return const CoinsConfig.empty();
  }

  set referralCoinsConfig(ReferralConfig config) {
    prefs?.setString(PreferenceKeys.referralCoinsConfig, jsonEncode(config.toJson()));
  }

  ReferralConfig get referralCoinsConfig {
    final data = prefs?.getString(PreferenceKeys.referralCoinsConfig);

    if (data != null) {
      return ReferralConfig.fromJson(jsonDecode(data) as Map<String, dynamic>);
    }

    return const ReferralConfig.empty();
  }

  //---------- user's common states ----------//

  set userId(String? userId) => userId == null ? null : prefs?.setString(PreferenceKeys.userId, userId);

  String? get userId => prefs?.getString(PreferenceKeys.userId);

  set referCode(String? userId) => userId == null ? null : prefs?.setString(PreferenceKeys.referCode, userId);

  String? get referCode => prefs?.getString(PreferenceKeys.referCode);

  set userInfo(UserInfo userInfo) => prefs?.setString(PreferenceKeys.userInfo, jsonEncode(userInfo.toJson()));

  UserInfo get userInfo {
    final data = prefs?.getString(PreferenceKeys.userInfo);
    if (data != null) {
      return UserInfo.fromJson(jsonDecode(data) as Map<String, dynamic>);
    }
    return UserInfo.unknown();
  }

  //---------- News states ----------//

  set readNews(int status) => prefs?.setInt(PreferenceKeys.readNews, status);

  int get readNews => prefs?.getInt(PreferenceKeys.readNews) ?? 0;

  set claimedSurveyIds(Set<String> ids) => prefs?.setStringList(PreferenceKeys.claimedSurveyIds, ids.toList());

  Set<String> get claimedSurveyIds => (prefs?.getStringList(PreferenceKeys.claimedSurveyIds) ?? []).toSet();

  set claimedReferFriendIds(Set<String> ids) =>
      prefs?.setStringList(PreferenceKeys.claimedReferFriendIds, ids.toList());

  Set<String> get claimedReferFriendIds => (prefs?.getStringList(PreferenceKeys.claimedReferFriendIds) ?? []).toSet();

  set surveyResetDate(DateTime? value) => _setTimer(PreferenceKeys.surveyResetDate, value);

  DateTime? get surveyResetDate => _getTimer(PreferenceKeys.surveyResetDate);

  void clear() {
    final isShowOnBoarding = this.isShowOnBoarding;
    prefs?.clear();
    this.isShowOnBoarding = isShowOnBoarding;
  }
}
