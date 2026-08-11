part of 'verify.dart';

final class VerifyProvider extends BaseProvider {
  VerifyProvider({required super.context});

  @override
  void initState() {
    super.initState();
    resolveAdUnitId(
      slot: NativeAdTyped.detail,
      isThisAdPlaceEnable: preference.adsConfig?.adPlaceConfig?.onBoardingNativeAd ?? false,
    );
  }
}
