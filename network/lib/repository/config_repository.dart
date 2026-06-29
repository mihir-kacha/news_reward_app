part of '../network.dart';

class ConfigRepository {
  final _configRef = FireStoreHelper.configCollectionRef;

  Future<WithDrawConfig> getWithdrawConfig() async {
    try {
      final doc = await _configRef.doc('withdraw_config').get();
      return WithDrawConfig.fromJson(doc.data() ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<CoinsConfig> getCoinConfig() async {
    try {
      final doc = await _configRef.doc('coin_config').get();
      return CoinsConfig.fromJson(doc.data() ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<ReferralConfig> getReferralCoinConfig() async {
    try {
      final doc = await _configRef.doc('referral_coin').get();
      return ReferralConfig.fromJson(doc.data() ?? {});
    } catch (e) {
      rethrow;
    }
  }
}
