part of 'preference.dart';

abstract interface class PreferenceKeys {
  //---------- login states ----------//
  static const String isLogin = 'is_login';
  static const String showOnBoarding = 'show_on_boarding';

  //---------- Task states ----------//
  static const String luckTimer = "luck_timer";
  static const String drinkWaterTimer = "drink_water_timer";
  static const String walkTimer = "walk_timer";
  static const String exerciseTimer = "exercise_timer";
  static const String prayTimer = "pray_timer";

  //---------- Daily Total Limit states ----------//

  static const String configModel = 'config_model';
  static const String coins = 'coins';
  static const String minCoins = 'min_coins';
  static const String coinsConfig = 'coins_config';

  //---------- user's common states ----------//
  static const String userId = 'user_id';
  static const String userInfo = 'user_info';
  static const String referCode = 'refer_code';

//---------- News states ----------//
  static const String readNews = 'read_news';
  static const String claimedSurveyIds = 'claimed_survey_ids';
  static const String surveyResetDate = 'survey_reset_date';
  static const String claimedReferFriendIds = 'claimed_refer_friends_ids';

}
