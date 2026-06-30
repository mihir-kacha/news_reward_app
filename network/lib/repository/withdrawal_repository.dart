part of '../network.dart';

class WithdrawalRepository {
  final _redeemRef = FireStoreHelper.withdrawalsRef;
  final _userRef = FireStoreHelper.userRef;

  Future<bool> withdraw({required WithdrawalsDocument redeemDoc}) async {
    try {
      final docRef = _redeemRef.doc();
      final updatedDoc = redeemDoc.copyWith(id: docRef.id, createdAt: DateTime.now());
      await docRef.set(updatedDoc);

      await _userRef.doc(redeemDoc.claimedBy).update({
        UserModelFields.coins: FieldValue.increment(-(redeemDoc.withdrawCoin ?? 0)),
        UserModelFields.updatedAt: DateTime.now().toUtc(),
      });

      eventBus.fire(OnWithdrawCoinEvent(withdrawCoin: redeemDoc.withdrawCoin ?? 0));
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
