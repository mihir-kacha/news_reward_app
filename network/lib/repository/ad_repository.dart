part of '../network.dart';

class AdRepository {
  final _adsConfigRef = Env().isDevMode
      ? FireStoreHelper.devAdsConfigCollectionRef
      : FireStoreHelper.adsConfigCollectionRef;
  final _adsIdsRef = Env().isDevMode ? FireStoreHelper.devAdsIdsCollectionRef : FireStoreHelper.adsIdsCollectionRef;

  Future<AdsConfigModel?> getAdsConfig() async {
    try {
      final snapshot = await _adsConfigRef.get();

      AdsCountsModel? counts;
      AdsStatusModel? status;
      AdPlaceConfig? adPlaceConfig;

      for (var doc in snapshot.docs) {
        if (doc.id == ' ads_count') {
          counts = AdsCountsModel.fromJson(doc.data());
        } else if (doc.id == 'ads_status') {
          status = AdsStatusModel.fromJson(doc.data());
        } else if (doc.id == "ad_place") {
          adPlaceConfig = AdPlaceConfig.fromJson(doc.data());
        }
      }
      return AdsConfigModel(adsCountsModel: counts, adPlaceConfig: adPlaceConfig, adsStatusModel: status);
    } catch (e) {
      Log.error("Error while fetching ads config data :: $e");
      return null;
    }
  }

  Future<AdsIdsModel?> getAdsIds() async {
    try {
      final snapshot = await _adsIdsRef.get();

      AdsIdsModel? adsIdsModel;

      for (var doc in snapshot.docs) {
        if (doc.id == 'google_ads') {
          adsIdsModel = AdsIdsModel.fromJson(doc.data());
        }
      }
      return adsIdsModel;
    } catch (e) {
      Log.error("Error while fetching ads ids :: $e");
      return null;
    }
  }
}
