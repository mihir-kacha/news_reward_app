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

  void clear() {
    prefs?.clear();
  }
}
