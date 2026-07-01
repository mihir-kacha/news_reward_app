part of 'model.dart';

class AdsIdsModel extends Equatable {
  final List<String>? bannerAdsIds;
  final List<String>? interstitialAdsIds;
  final List<String>? nativeAdsIds;
  final List<String>? nativeVideoAdsIds;
  final List<String>? openAppAdsIds;
  final List<String>? rewardAdsIds;
  final List<String>? rewardInterstitialAdsIds;

  @override
  List<Object?> get props => [
    bannerAdsIds,
    interstitialAdsIds,
    nativeAdsIds,
    nativeVideoAdsIds,
    openAppAdsIds,
    rewardAdsIds,
    rewardInterstitialAdsIds,
  ];

  const AdsIdsModel({
    this.bannerAdsIds,
    this.interstitialAdsIds,
    this.nativeAdsIds,
    this.nativeVideoAdsIds,
    this.openAppAdsIds,
    this.rewardAdsIds,
    this.rewardInterstitialAdsIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'banner_ids': bannerAdsIds,
      'interstitial_ids': interstitialAdsIds,
      'native_ad_ids': nativeAdsIds,
      'native_video_ad_ids': nativeVideoAdsIds,
      'open_app_ids': openAppAdsIds,
      'reward_ad_ids': rewardAdsIds,
      'rewarded_interstitial_ids': rewardInterstitialAdsIds,
    };
  }

  factory AdsIdsModel.fromJson(Map<String, dynamic> map) {
    return AdsIdsModel(
      bannerAdsIds: map['banner_ids'] != null
          ? List<String>.from(map['banner_ids'])
          : null,
      interstitialAdsIds: map['interstitial_ids'] != null
          ? List<String>.from(map['interstitial_ids'])
          : null,
      nativeAdsIds: map['native_ad_ids'] != null
          ? List<String>.from(map['native_ad_ids'])
          : null,
      nativeVideoAdsIds: map['native_video_ad_ids'] != null
          ? List<String>.from(map['native_video_ad_ids'])
          : null,
      openAppAdsIds: map['open_app_ids'] != null
          ? List<String>.from(map['open_app_ids'])
          : null,
      rewardAdsIds: map['reward_ad_ids'] != null
          ? List<String>.from(map['reward_ad_ids'])
          : null,
      rewardInterstitialAdsIds: map['rewarded_interstitial_ids'] != null
          ? List<String>.from(map['rewarded_interstitial_ids'])
          : null,
    );
  }

  AdsIdsModel copyWith({
    List<String>? bannerAdsIds,
    List<String>? interstitialAdsIds,
    List<String>? nativeAdsIds,
    List<String>? nativeVideoAdsIds,
    List<String>? openAppAdsIds,
    List<String>? rewardAdsIds,
    List<String>? rewardInterstitialAdsIds,
  }) {
    return AdsIdsModel(
      bannerAdsIds: bannerAdsIds ?? this.bannerAdsIds,
      interstitialAdsIds: interstitialAdsIds ?? this.interstitialAdsIds,
      nativeAdsIds: nativeAdsIds ?? this.nativeAdsIds,
      nativeVideoAdsIds: nativeVideoAdsIds ?? this.nativeVideoAdsIds,
      openAppAdsIds: openAppAdsIds ?? this.openAppAdsIds,
      rewardAdsIds: rewardAdsIds ?? this.rewardAdsIds,
      rewardInterstitialAdsIds:
          rewardInterstitialAdsIds ?? this.rewardInterstitialAdsIds,
    );
  }
}
