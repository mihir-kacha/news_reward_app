part of 'ads.dart';

class BannerAdsLoader extends BaseAdLoader<BannerAd> {
  OnAdLoaded? onAdLoaded;
  OnAdFailed? onAdFailed;

  AdSize? _resolveSize;

  @override
  AdType get adType => .banner;

  @override
  void disposeAdObject(BannerAd? ad) => ad?.dispose();

  @override
  Future<void> loadAdFroUnit(String unitId) async {
    final size = _resolveSize ?? AdSize.banner;
    final banner = BannerAd(
      size: size,
      adUnitId: unitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          onLoaded(ad as BannerAd, unitId);
          onAdLoaded?.call(unitId);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          onFailed(unitId, error.message);
        },
        onAdOpened: (ad) => Log.debug("Banner Ad Opened"),
        onAdClosed: (ad) => Log.debug('${adType.name} Banner closed'),
        onAdImpression: (ad) => Log.debug('${adType.name} Banner impression'),
      ),
      request: const AdRequest(),
    );
    await banner.load();
  }

  Future<void> resolveAdaptiveSize(BuildContext context) async {
    final width = context.width.truncate();
    _resolveSize = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
  }

  Widget buildWidget() {
    if (!isLoaded || ad == null) return const SizedBox.shrink();
    return SizedBox(
      width: ad!.size.width.toDouble(),
      height: ad!.size.height.toDouble(),
      child: AdWidget(ad: ad!),
    );
  }
}
