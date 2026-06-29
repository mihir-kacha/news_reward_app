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

  Future<void> _updateUserField(Map<String, dynamic> data) async {
    try {
      data[UserModelFields.updatedAt] = Timestamp.now();
      await _userRef.doc(uid).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addCoins({required int coins}) async {
    try {
      final snapshot = await _userRef.doc(uid).get();
      final currentCoins = snapshot.data()?.coins ?? 0;
      await _updateUserField({UserModelFields.coins: currentCoins + coins});

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


}
