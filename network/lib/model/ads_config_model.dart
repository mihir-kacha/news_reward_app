part of 'model.dart';

class AdsConfigModel extends Equatable {
  final AdsCountsModel? adsCountsModel;
  final AdsStatusModel? adsStatusModel;
  final AdPlaceConfig? adPlaceConfig;

  @override
  List<Object?> get props => [adsCountsModel, adsStatusModel,adPlaceConfig ];

  const AdsConfigModel({this.adsCountsModel, this.adsStatusModel,
    this.adPlaceConfig
  });

  Map<String, dynamic> toJson() {
    return {
      'ads_count': adsCountsModel?.toJson(),
      'ads_status': adsStatusModel?.toJson(),
      'ad_place_config': adPlaceConfig?.toJson(),
    };
  }

  factory AdsConfigModel.fromJson(Map<String, dynamic> map) {
    return AdsConfigModel(
      adsCountsModel: map['ads_count'] != null ? AdsCountsModel.fromJson(map['ads_count']) : null,
      adsStatusModel: map['ads_status'] != null ? AdsStatusModel.fromJson(map['ads_status']) : null,
      adPlaceConfig: map['ad_place_config'] != null ? AdPlaceConfig.fromJson(map['ad_place_config']) : null,
    );
  }

  AdsConfigModel copyWith({
    AdsCountsModel? adsCountsModel,
    AdsStatusModel? adsStatusModel,
    AdPlaceConfig? adPlaceConfig,
  }) {
    return AdsConfigModel(
      adsCountsModel: adsCountsModel ?? this.adsCountsModel,
      adsStatusModel: adsStatusModel ?? this.adsStatusModel,
      adPlaceConfig: adPlaceConfig ?? this.adPlaceConfig,
    );
  }
}

class AdsCountsModel extends Equatable {
  final int? interstitialAdsIntervalCount;

  @override
  List<Object?> get props => [interstitialAdsIntervalCount];

  const AdsCountsModel({this.interstitialAdsIntervalCount});

  Map<String, dynamic> toJson() {
    return {'interstitial_ads_interval': interstitialAdsIntervalCount};
  }

  factory AdsCountsModel.fromJson(Map<String, dynamic> map) {
    return AdsCountsModel(interstitialAdsIntervalCount: map['interstitial_ads_interval']);
  }
}

class AdsStatusModel extends Equatable {
  final bool? isBannerShow;
  final bool? isInterstitialShow;
  final bool? isNativeShow;
  final bool? isNativeVideoShow;
  final bool? isOpenAppAdShow;
  final bool? isRewardedInterstitialShow;
  final bool? isRewardAdShow;
  final bool? showAdsInApp;

  @override
  List<Object?> get props => [
    isBannerShow,
    isInterstitialShow,
    isNativeShow,
    isNativeVideoShow,
    isOpenAppAdShow,
    isRewardedInterstitialShow,
    isRewardAdShow,
    showAdsInApp,
  ];

  const AdsStatusModel({
    this.isBannerShow,
    this.isInterstitialShow,
    this.isNativeShow,
    this.isNativeVideoShow,
    this.isOpenAppAdShow,
    this.isRewardedInterstitialShow,
    this.isRewardAdShow,
    this.showAdsInApp,
  });

  Map<String, dynamic> toJson() {
    return {
      'banner_show': isBannerShow,
      'interstitial_show': isInterstitialShow,
      'native_show': isNativeShow,
      'native_video_show': isNativeVideoShow,
      'openad_show': isOpenAppAdShow,
      'rewarded_interstitial_show': isRewardedInterstitialShow,
      'rewarded_show': isRewardAdShow,
      'show_ads_in_app': showAdsInApp,
    };
  }

  factory AdsStatusModel.fromJson(Map<String, dynamic> map) {
    return AdsStatusModel(
      isBannerShow: map['banner_show'] ?? false,
      isInterstitialShow: map['interstitial_show'] ?? false,
      isNativeShow: map['native_show'] ?? false,
      isNativeVideoShow: map['native_video_show'] ?? false,
      isOpenAppAdShow: map['openad_show'] ?? false,
      isRewardedInterstitialShow: map['rewarded_interstitial_show'] ?? false,
      isRewardAdShow: map['rewarded_show'] ?? false,
      showAdsInApp: map['show_ads_in_app'] ?? false,
    );
  }

  AdsStatusModel copyWith({
    bool? isBannerShow,
    bool? isInterstitialShow,
    bool? isNativeShow,
    bool? isNativeVideoShow,
    bool? isOpenAdShow,
    bool? isRewardedInterstitialShow,
    bool? isRewardAdShow,
    bool? showAdsInApp,
  }) {
    return AdsStatusModel(
      isBannerShow: isBannerShow ?? this.isBannerShow,
      isInterstitialShow: isInterstitialShow ?? this.isInterstitialShow,
      isNativeShow: isNativeShow ?? this.isNativeShow,
      isNativeVideoShow: isNativeVideoShow ?? this.isNativeVideoShow,
      isOpenAppAdShow: isOpenAdShow ?? this.isOpenAppAdShow,
      isRewardedInterstitialShow: isRewardedInterstitialShow ?? this.isRewardedInterstitialShow,
      isRewardAdShow: isRewardAdShow ?? this.isRewardAdShow,
      showAdsInApp: showAdsInApp ?? this.showAdsInApp,
    );
  }
}
