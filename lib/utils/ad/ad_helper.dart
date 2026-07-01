part of 'ads.dart';

enum NativeAdTyped { feed, detail, nativeVideo }

class AdHelper {
  AdHelper._();

  static final AdHelper instance = AdHelper._();

  late final InterstitialAdsLoader _interstitialAdLoader;
  late final RewardedInterstitialAdsLoader _rewardedInterstitialAdLoader;
  late final RewardAdsLoader _rewardAdsLoader;
  late final BannerAdsLoader _bannerAdsLoader;
  late final AppOpenAdsLoader _appOpenAdsLoader;

  final Map<NativeAdTyped, NativeAdLoader> _nativeLoader = {};

  AdsStatusModel? get _status => Preference().adsConfig?.adsStatusModel;

  bool get _adsEnabled => _status?.showAdsInApp ?? false;

  bool _initialized = false;

  AdsIdsModel? get _ids => Preference().adsIds;

  List<String> _resolveIds(List<String>? Function(AdsIdsModel) pick) {
    final ids = _ids;
    if (ids == null) return [];
    return pick(ids) ?? [];
  }

  /// ads init

  Future<void> initialized({bool preloadOnInit = true}) async {
    if (!_adsEnabled) {
      Log.debug("Ads disabled → skipping initialization.");
      return;
    }

    if (_initialized) {
      Log.debug("Already initialized - ignoring");
      return;
    }

    GmaMediationUnity().setGDPRConsent(true);
    GmaMediationUnity().setCCPAConsent(true);

    await MobileAds.instance.initialize();

    _appOpenAdsLoader = AppOpenAdsLoader()
      ..unitIdsResolver = () {
        return _resolveIds((ids) => ids.openAppAdsIds);
      }
      ..onAdLoaded = (_) {
        Log.success('App Open Ready ✓');
      }
      ..onAdFailed = (err) {
        Log.error('App Open: All units failed: $err');
      }
      ..onAdDismissed = () {
        Log.debug('App Open Dismissed');
      };

    _interstitialAdLoader = InterstitialAdsLoader()
      ..unitIdsResolver = () {
        return _resolveIds((ids) => ids.interstitialAdsIds);
      }
      ..onAdLoaded = (unitId) {
        Log.success('Interstitial Ready ✓');
      }
      ..onAdFailed = (err) {
        Log.error('Interstitial: All units failed: $err');
      }
      ..onAdDismissed = () {
        Log.debug('Interstitial Dismissed');
      };

    _rewardedInterstitialAdLoader = RewardedInterstitialAdsLoader()
      ..unitIdsResolver = () {
        return _resolveIds((ids) => ids.rewardInterstitialAdsIds);
      }
      ..onAdLoaded = (_) {
        Log.success('Rewarded Interstitial Ready ✓');
      }
      ..onAdFailed = (err) {
        Log.error('Rewarded Interstitial: All units failed: $err');
      }
      ..onAdDismissed = () {
        Log.debug('Rewarded Interstitial Dismissed');
      }
      ..onRewardEarned = (reward) {
        Log.success('Rewarded Interstitial Reward: $reward');
      };

    _rewardAdsLoader = RewardAdsLoader()
      ..unitIdsResolver = () {
        return _resolveIds((ids) => ids.rewardAdsIds);
      }
      ..onAdLoaded = (unitId) {
        Log.success('Rewarded Ready ✓');
      }
      ..onAdFailed = (err) {
        Log.error('Rewarded: All units failed: $err');
      }
      ..onAdDismissed = () {
        Log.debug('Rewarded Dismissed');
      }
      ..onRewardEarned = (reward) {
        Log.success('Reward Earned: $reward');
      };

    _bannerAdsLoader = BannerAdsLoader()
      ..unitIdsResolver = () {
        return _resolveIds((ids) => ids.bannerAdsIds);
      }
      ..onAdLoaded = (unitId) {
        Log.success('Banner Ready ✓');
      }
      ..onAdFailed = (err) {
        Log.error('Banner: All units failed: $err');
      };

    for (final slot in NativeAdTyped.values) {
      _nativeLoader[slot] = NativeAdLoader(slot: slot)
        ..unitIdsResolver = () {
          return _resolveIds((ids) {
            return switch (slot) {
              NativeAdTyped.feed => ids.nativeAdsIds,
              NativeAdTyped.detail => ids.nativeAdsIds,
              NativeAdTyped.nativeVideo => ids.nativeVideoAdsIds,
            };
          });
        }
        ..onNativeAdLoaded = (ad, unitId) {
          Log.success('Native[${slot.name}] Ready ✓');
        }
        ..onAdFailed = (err) {
          Log.error('Native[${slot.name}] All units failed: $err');
        };
    }

    _initialized = true;
    Log.success('✅ AdMob SDK initialized.');

    if (preloadOnInit) {
      unawaited(Future.wait([loadInterstitial(), loadAppOpen()]));
    }
  }

  /// app open ads

  Future<AdLoadResult> loadAppOpen() {
    if (!_canUseAds() || !(_status?.isOpenAppAdShow ?? false)) {
      return Future.value(AdLoadResult.failure(""));
    }
    return _appOpenAdsLoader.load();
  }

  Future<bool> showAppOpen() {
    if (!_canUseAds() || !(_status?.isOpenAppAdShow ?? false)) {
      return Future.value(false);
    }
    return _appOpenAdsLoader.show();
  }

  AdLoadState get appOpenState => _appOpenAdsLoader.state;

  void setAppOpenCallbacks({
    OnAdLoaded? onLoaded,
    OnAdFailed? onFailed,
    OnAdDismissed? onDismissed,
    OnAdShown? onShown,
  }) {
    _appOpenAdsLoader
      ..onAdLoaded = onLoaded
      ..onAdFailed = onFailed
      ..onAdDismissed = onDismissed
      ..onAdShown = onShown;
  }


  /// banner ads

  Future<AdLoadResult> loadBanner({BuildContext? context}) async {
    if (!_canUseAds() || !(_status?.isBannerShow ?? false)) {
      return AdLoadResult.failure("");
    }

    if (context != null) await _bannerAdsLoader.resolveAdaptiveSize(context);
    return _bannerAdsLoader.load();
  }

  Widget bannerWidget() {
    if (!_canUseAds() || !(_status?.isBannerShow ?? false)) {
      return const SizedBox.shrink();
    }
    return _bannerAdsLoader.buildWidget();
  }

  AdLoadState get bannerState => _bannerAdsLoader.state;

  /// interstitial ads

  Future<AdLoadResult> loadInterstitial() {
    if (!_canUseAds() || !(_status?.isInterstitialShow ?? false)) {
      return Future.value(AdLoadResult.failure(""));
    }
    return _interstitialAdLoader.load();
  }

  Future<bool> showInterstitial({required VoidCallback onAdClosed}) {
    if (!_canUseAds() || !(_status?.isInterstitialShow ?? false)) {
      onAdClosed();
      return Future.value(false);
    }

    _interstitialAdLoader.onAdDismissed = () {
      Log.debug('Interstitial Dismissed');
      onAdClosed();
    };

    return _interstitialAdLoader.show();
  }

  AdLoadState get interstitialState => _interstitialAdLoader.state;

  void setInterstitialCallbacks({
    OnAdLoaded? onLoaded,
    OnAdFailed? onFailed,
    OnAdDismissed? onDismissed,
    OnAdShown? onShown,
  }) {
    _interstitialAdLoader
      ..onAdLoaded = onLoaded
      ..onAdFailed = onFailed
      ..onAdDismissed = onDismissed
      ..onAdShown = onShown;
  }

  /// rewarded interstitial ads — NEW

  Future<AdLoadResult> loadRewardedInterstitial() {
    if (!_canUseAds() || !(_status?.isInterstitialShow ?? false)) {
      return Future.value(AdLoadResult.failure(""));
    }
    return _rewardedInterstitialAdLoader.load();
  }

  Future<bool> showRewardedInterstitial({OnRewardEarned? onRewardEarned}) {
    if (!_canUseAds() || !(_status?.isInterstitialShow ?? false)) {
      return Future.value(false);
    }
    if (onRewardEarned != null) {
      _rewardedInterstitialAdLoader.onRewardEarned = onRewardEarned;
    }
    return _rewardedInterstitialAdLoader.show();
  }

  AdLoadState get rewardedInterstitialState => _rewardedInterstitialAdLoader.state;

  /// rewarded ads

  Future<AdLoadResult> loadRewarded({required bool isThisAdPlaceEnable}) {
    if (!_canUseAds() || !(_status?.isRewardAdShow ?? false) || !isThisAdPlaceEnable) {
      return Future.value(AdLoadResult.failure(""));
    }
    return _rewardAdsLoader.load();
  }

  Future<bool> showRewarded() {
    if (!_canUseAds() || !(_status?.isRewardAdShow ?? false)) {
      return Future.value(false);
    }
    return _rewardAdsLoader.show();
  }

  AdLoadState get rewardedState => _rewardAdsLoader.state;

  void setRewardedCallbacks({
    OnAdLoaded? onLoaded,
    OnAdFailed? onFailed,
    OnAdDismissed? onDismissed,
    OnRewardEarned? onRewardEarned,
  }) {
    _rewardAdsLoader
      ..onAdLoaded = onLoaded
      ..onAdFailed = onFailed
      ..onAdDismissed = onDismissed
      ..onRewardEarned = onRewardEarned;
  }

  /// native ads

  static const MethodChannel _nativePreloadChannel = MethodChannel('native_ad_preload');

  Future<void> preloadNativeAd({required String adUnitId, String adSlot = 'feed'}) async {
    if (!_canUseAds()) return;
    try {
      await _nativePreloadChannel.invokeMethod('preload', {'adUnitId': adUnitId, 'adSlot': adSlot});
    } catch (e) {
      Log.error('Failed to preload native ad: $e');
    }
  }

  NativeAdLoader createNativeLoader(NativeAdTyped slot) {
    final loader = NativeAdLoader(slot: slot)
      ..unitIdsResolver = () {
        return resolveNativeIds(slot);
      }
      ..onNativeAdLoaded = (ad, unitId) {
        Log.success('Native[${slot.name}] Ready ✓');
      }
      ..onAdFailed = (err) {
        Log.error('Native[${slot.name}] Failed: $err');
      };

    loader.load();
    return loader;
  }

  List<String> resolveNativeIds(NativeAdTyped slot) {
    return _resolveIds((ids) {
      return switch (slot) {
        NativeAdTyped.feed => ids.nativeAdsIds,
        NativeAdTyped.detail => ids.nativeAdsIds,
        NativeAdTyped.nativeVideo => ids.nativeVideoAdsIds,
      };
    });
  }

  bool isNativeEnabled({required NativeAdTyped slot, required bool isThisAdPlaceEnable}) {
    if (!_canUseAds() || !isThisAdPlaceEnable) return false;
    return switch (slot) {
      NativeAdTyped.nativeVideo => _status?.isNativeVideoShow ?? false,
      _ => _status?.isNativeShow ?? false,
    };
  }

  final ValueNotifier<AdLoadState> _emptyNotifier = ValueNotifier(AdLoadState.failed);

  ValueNotifier<AdLoadState> nativeStateNotifier({NativeAdTyped slot = NativeAdTyped.feed}) {
    final isEnabled = switch (slot) {
      NativeAdTyped.nativeVideo => _status?.isNativeVideoShow ?? false,
      _ => _status?.isNativeShow ?? false,
    };

    if (!_canUseAds() || !isEnabled) {
      return _emptyNotifier;
    }

    final loader = _nativeLoader[slot]!;

    if (loader.state == AdLoadState.idle || loader.state == AdLoadState.failed) {
      loader.load();
    }

    return loader.stateNotifier;
  }

  Future<AdLoadResult> loadNative({NativeAdTyped slot = NativeAdTyped.feed}) {
    final isEnabled = switch (slot) {
      NativeAdTyped.nativeVideo => _status?.isNativeVideoShow ?? false,
      _ => _status?.isNativeShow ?? false,
    };

    if (!_canUseAds() || !isEnabled) {
      return Future.value(AdLoadResult.failure(""));
    }

    return _nativeLoader[slot]!.load();
  }

  Widget? nativeWidget({NativeAdTyped slot = NativeAdTyped.feed, double height = 120}) {
    final isEnabled = switch (slot) {
      NativeAdTyped.nativeVideo => _status?.isNativeVideoShow ?? false,
      _ => _status?.isNativeShow ?? false,
    };

    if (!_canUseAds() || !isEnabled) {
      return null;
    }

    return _nativeLoader[slot]?.buildWidget(height: height);
  }

  AdLoadState nativeState({NativeAdTyped slot = NativeAdTyped.feed}) => _nativeLoader[slot]?.state ?? AdLoadState.idle;

  String? nativeAdUnitId({required NativeAdTyped slot, required bool isThisAdPlaceEnable}) {
    if (!isNativeEnabled(slot: slot, isThisAdPlaceEnable: isThisAdPlaceEnable)) return null;
    final ids = resolveNativeIds(slot);
    return ids.isNotEmpty ? ids.first : null;
  }

  void disposeAll() {
    _interstitialAdLoader.dispose();
    _rewardAdsLoader.dispose();
    _bannerAdsLoader.dispose();
    _appOpenAdsLoader.dispose();
    _rewardedInterstitialAdLoader.dispose();
    for (final loader in _nativeLoader.values) {
      loader.dispose();
    }
  }

  bool _canUseAds() {
    if (!_adsEnabled) {
      Log.debug('Ads disabled globally.');
      return false;
    }
    if (!_initialized) {
      Log.debug('AdHelper not initialized.');
      return false;
    }
    return true;
  }
}
