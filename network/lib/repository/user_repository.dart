part of '../network.dart';

class UserRepository {
  final String uid;

  UserRepository({required this.uid});

  final _userRef = FireStoreHelper.userRef;

  Stream<UserModel?> get userInfoStream {
    return _userRef.doc(uid).snapshots().map((event) {
      return event.data();
    });
  }

  Future<void> _updateUserField({required Map<String, dynamic> data, String? referralById}) async {
    try {
      final userId = referralById ?? uid;
      data[UserModelFields.updatedAt] = Timestamp.now();
      await _userRef.doc(userId).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addCoins({required int coins, String? referralById}) async {
    try {
      final userId = referralById ?? uid;
      final snapshot = await _userRef.doc(userId).get();
      final currentCoins = snapshot.data()?.coins ?? 0;
      await _updateUserField(data: {UserModelFields.coins: currentCoins + coins}, referralById: referralById);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUserDetails() async {
    try {
      if (uid.isEmpty) {
        return null;
      }
      final snapshot = await _userRef.doc(uid).get();
      if (!snapshot.exists) {
        return null;
      }
      return snapshot.data();
    } catch (e, s) {
      '$e\n$s'.error();
      return null;
    }
  }

  Future<void> addClaimedReferFriendId({required String id}) async {
    try {
      await _updateUserField(
        data: {
          UserModelFields.claimedIds: FieldValue.arrayUnion([id]),
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
