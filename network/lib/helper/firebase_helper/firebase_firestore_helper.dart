part of '../../network.dart';

class FireStoreHelper {
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFunctions functions = FirebaseFunctions.instance;

  ///------------------------------- Collection Name -------------------------------///

  static const newsCollection = "news";

  ///------------------------------- Collection Reference -------------------------------///

  static final newsCollectionRef = fireStore.collection(newsCollection);

  ///------------------------------- Reference -------------------------------///

  static final newsRef = newsCollectionRef.withConverter(
    fromFirestore: (snapshot, options) => NewsData.fromJson(snapshot.data()!).copyWith(articleId: snapshot.id),
    toFirestore: (value, options) => value.toJson(),
  );
}
