part of 'read_news.dart';

final class ReadNewsProvider extends BaseProvider{
  ReadNewsProvider({required super.context});

  @override
  void initState() {
    super.initState();
    resolveAdUnitId(
      slot: NativeAdTyped.detail,
      isThisAdPlaceEnable: preference.adsConfig?.adPlaceConfig?.onBoardingNativeAd ?? false,
    );
  }
}