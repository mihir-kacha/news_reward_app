part of '../network.dart';

class ReferralsRepository {
  final _referralsRef = FireStoreHelper.referralsRef;
  final _userRef = FireStoreHelper.userRef;

  Future<ReferralsDocument?> addReferralCode({required String currentUserId, required String referralCode}) async {
    try {
      final response = await _userRef.where(UserModelFields.referCode, isEqualTo: referralCode).limit(1).get();

      if (response.docs.isEmpty) {
        throw DefaultException(message: "Invalid Referral Code! Please Try With Correct one!");
      }

      final ref = ReferralsDocument(referBy: response.docs.first.data().id, referTo: currentUserId);
      final docRef = await _referralsRef.add(ref);
      final snapshot = await docRef.get();
      return snapshot.data();
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getReferralCount({required String currentUserId}) async {
    try {
      final snapshot = await _referralsRef
          .where(ReferralsDocumentFiled.referBy, isEqualTo: currentUserId)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getReferralCodeOfInviter({required String currentUserId}) async {
    try {
      final referralSnapshot = await _referralsRef
          .where(ReferralsDocumentFiled.referTo, isEqualTo: currentUserId)
          .limit(1)
          .get();

      if (referralSnapshot.docs.isEmpty) {
        return null;
      }
      final referral = referralSnapshot.docs.first.data();
      final userSnapshot = await _userRef.doc(referral.referBy).get();
      if (!userSnapshot.exists) {
        return null;
      }
      return userSnapshot.data()?.referCode;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getReferralCodeOfInviterId({required String currentUserId}) async {
    try {
      final referralSnapshot = await _referralsRef
          .where(ReferralsDocumentFiled.referTo, isEqualTo: currentUserId)
          .limit(1)
          .get();

      if (referralSnapshot.docs.isEmpty) {
        return null;
      }
      final referral = referralSnapshot.docs.first.data();
      final userSnapshot = await _userRef.doc(referral.referBy).get();
      if (!userSnapshot.exists) {
        return null;
      }
      return userSnapshot.data()?.id;
    } catch (e) {
      rethrow;
    }
  }
}
