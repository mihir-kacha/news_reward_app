part of '../network.dart';

class AuthRepository {
  final _userRef = FireStoreHelper.userRef;

  Future<UserModel?> signInWithGoogle({required int coins, required String referCode}) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(serverClientId: EnvHelper.instance.googleServerClientId);
      final googleUser = await googleSignIn.authenticate(scopeHint: ['email']);
      final authorization = await googleSignIn.authorizationClient.authorizationForScopes(['email']);
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;
      if (idToken == null) {
        throw DefaultException(message: "Google Sign In Failed");
      }
      final authCredential = GoogleAuthProvider.credential(idToken: idToken, accessToken: authorization?.accessToken);
      final userCredential = await FireStoreHelper.auth.signInWithCredential(authCredential);
      final user = userCredential.user;
      final userDoc = await _userRef.where(UserModelFields.email, isEqualTo: user?.email).limit(1).get();
      final users = userDoc.docs.firstOrNull?.data();
      if (users != null) {
        await googleSignIn.signOut();
        return users;
      }

      final userDocument = UserModel(
        id: user?.uid ?? '',
        email: user?.email ?? "",
        name: user?.displayName ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        coins: coins,
        referCode: referCode,
        claimedIds: {},
      );
      await _userRef.doc(userDocument.id).set(userDocument);
      await googleSignIn.signOut();
      return userDocument;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      throw DefaultException(message: "Google Sign In Failed");
    } catch (e) {
      throw DefaultException(message: "Google Sign In Failed");
    }
  }

  Future<void> logout() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.signOut();
      await FireStoreHelper.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> generateUniqueReferCode() async {
    while (true) {
      final code = ReferCodeGenerator.generate();

      final exists = await _userRef.where(UserModelFields.referCode, isEqualTo: code).limit(1).get();

      if (exists.docs.isEmpty) {
        return code;
      }
    }
  }
}
