part of '../../network.dart';

class NetworkPrefs {
  NetworkPrefs._();

  static final NetworkPrefs _instance = NetworkPrefs._();

  factory NetworkPrefs() => _instance;

  static const _keyToken = 'auth_token';
  static const _keyRefreshToken = 'auth_refresh_token';

  static SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveTokens({required String token, required String refreshToken}) async {
    await prefs?.setString(_keyToken, token);
    await prefs?.setString(_keyRefreshToken, refreshToken);
  }



  static String? getToken() {

    return prefs?.getString(_keyToken);
  }

  static String? getRefreshToken() {
    return prefs?.getString(_keyRefreshToken);
  }

  static Future<void> clearTokens() async {
    await prefs?.remove(_keyToken);
    await prefs?.remove(_keyRefreshToken);
  }
}
