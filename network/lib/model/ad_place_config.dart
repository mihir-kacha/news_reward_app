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
    };
  }

  factory AdPlaceConfig.fromJson(Map<String, dynamic> map) {
    return AdPlaceConfig(
      categoryNative: map['category_native'],
      dailyActivityReward: map['daily_activity_reward'],
      dailyReadNewsAd: map['daily_read_news_ad'],
      dailyTaskClaimAd: map['daily_task_claim_ad'],
      homeNative: map['home_native'],
      referFriendAd: map['refer_friend_ad'],
      newsDetailAd: map['news_detail_ad'],
      newsCodeAd: map['news_code_ad'],
      referAd: map['refer_ad'],
      congratulationNewsAd: map['congratulation_news_ad'],
      categoryNewsAd: map['category_news_ad'],
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
    );
  }
}
