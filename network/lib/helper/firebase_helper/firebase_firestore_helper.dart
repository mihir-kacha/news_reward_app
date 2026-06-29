part of '../../network.dart';

class FireStoreHelper {
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  ///------------------------------- Collection Name -------------------------------///

  static const userCollection = "users";
  static const newsCollection = "news";
  static const configCollection = 'config';
  static const referralsCollection = "referrals";

  ///------------------------------- Collection Reference -------------------------------///

  static final userCollectionRef = fireStore.collection(userCollection);
  static final newsCollectionRef = fireStore.collection(newsCollection);
  static final configCollectionRef = fireStore.collection(configCollection);
  static final referralsCollectionRef = fireStore.collection(referralsCollection);

  ///------------------------------- Reference -------------------------------///

  static final userRef = userCollectionRef.withConverter(
    fromFirestore: (snapshot, options) => UserModel.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
    toFirestore: (value, options) => value.toJson(),
  );

  static final newsRef = newsCollectionRef.withConverter(
    fromFirestore: (snapshot, options) => NewsData.fromJson(snapshot.data()!).copyWith(articleId: snapshot.id),
    toFirestore: (value, options) => value.toJson(),
  );

  static final referralsRef = referralsCollectionRef.withConverter(
    fromFirestore: (snapshot, options) => ReferralsDocument.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
    toFirestore: (value, options) => value.toJson(),
  );
}
