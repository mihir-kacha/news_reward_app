part of 'model.dart';

class AdPlaceConfig {
  final bool categoryNative;
  final bool dailyActivityReward;
  final bool dailyReadNewsAd;
  final bool dailyTaskClaimAd;
  final bool homeNative;
  final bool referFriendAd;
  final bool newsDetailAd;
  final bool newsCodeAd;
  final bool referAd;
  final bool congratulationNewsAd;
  final bool categoryNewsAd;
  final bool openInterOnInitial;
  final bool onBoardingNativeAd;

  AdPlaceConfig({
    required this.categoryNative,
    required this.dailyActivityReward,
    required this.dailyReadNewsAd,
    required this.dailyTaskClaimAd,
    required this.homeNative,
    required this.referFriendAd,
    required this.newsDetailAd,
    required this.newsCodeAd,
    required this.referAd,
    required this.congratulationNewsAd,
    required this.categoryNewsAd,
    required this.openInterOnInitial,
    required this.onBoardingNativeAd,
  });

  Map<String, dynamic> toJson() {
    return {
      'category_native': categoryNative,
      'daily_activity_reward': dailyActivityReward,
      'daily_read_news_ad': dailyReadNewsAd,
      'daily_task_claim_ad': dailyTaskClaimAd,
      'home_native': homeNative,
      'refer_friend_ad': referFriendAd,
      'news_detail_ad': newsDetailAd,
      'news_code_ad': newsCodeAd,
      'refer_ad': referAd,
      'congratulation_news_ad': congratulationNewsAd,
      'category_news_ad': categoryNewsAd,
      'open_inter_on_initial': openInterOnInitial,
      'on_boarding_native_ad': onBoardingNativeAd,
    };
  }

  factory AdPlaceConfig.fromJson(Map<String, dynamic> map) {
    return AdPlaceConfig(
      categoryNative: map['category_native'] ?? false,
      dailyActivityReward: map['daily_activity_reward'] ?? false,
      dailyReadNewsAd: map['daily_read_news_ad'] ?? false,
      dailyTaskClaimAd: map['daily_task_claim_ad'] ?? false,
      homeNative: map['home_native'] ?? false,
      referFriendAd: map['refer_friend_ad'] ?? false,
      newsDetailAd: map['news_detail_ad'] ?? false,
      newsCodeAd: map['news_code_ad'] ?? false,
      referAd: map['refer_ad'] ?? false,
      congratulationNewsAd: map['congratulation_news_ad'] ?? false,
      categoryNewsAd: map['category_news_ad'] ?? false,
      openInterOnInitial: map['open_inter_on_initial'] ?? false,
      onBoardingNativeAd: map['on_boarding_native_ad'] ?? false,
    );
  }

  AdPlaceConfig copyWith({
    bool? categoryNative,
    bool? dailyActivityReward,
    bool? dailyReadNewsAd,
    bool? dailyTaskClaimAd,
    bool? homeNative,
    bool? referFriendAd,
    bool? newsDetailAd,
    bool? newsCodeAd,
    bool? referAd,
    bool? congratulationNewsAd,
    bool? categoryNewsAd,
    bool? openInterOnInitial,
    bool? onBoardingNativeAd,
  }) {
    return AdPlaceConfig(
      categoryNative: categoryNative ?? this.categoryNative,
      dailyActivityReward: dailyActivityReward ?? this.dailyActivityReward,
      dailyReadNewsAd: dailyReadNewsAd ?? this.dailyReadNewsAd,
      dailyTaskClaimAd: dailyTaskClaimAd ?? this.dailyTaskClaimAd,
      homeNative: homeNative ?? this.homeNative,
      referFriendAd: referFriendAd ?? this.referFriendAd,
      newsDetailAd: newsDetailAd ?? this.newsDetailAd,
      newsCodeAd: newsCodeAd ?? this.newsCodeAd,
      referAd: referAd ?? this.referAd,
      congratulationNewsAd: congratulationNewsAd ?? this.congratulationNewsAd,
      categoryNewsAd: categoryNewsAd ?? this.categoryNewsAd,
      openInterOnInitial: openInterOnInitial ?? this.openInterOnInitial,
      onBoardingNativeAd: onBoardingNativeAd ?? this.onBoardingNativeAd,
    );
  }
}
