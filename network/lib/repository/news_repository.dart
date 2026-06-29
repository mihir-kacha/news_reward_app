part of '../network.dart';

class NewsRepository {
  final _apiManager = ApiManager();
  final _newsRef = FireStoreHelper.newsRef;

  final Random _random = Random();

  int _generateCode() {
    return 1000 + _random.nextInt(9000);
  }

  Future<PaginatedListResult<NewsData>> getNewsFromApi() async {
    try {
      final response = await _apiManager.callGet(
        url: ApiUrl.baseUrl,
        params: {ApiKeys.apiKeys: ApiUrl.apiKey, ApiKeys.language: 'en'},
      );
      final data = NewsModel.fromJson(response?.data);
      await saveNewsToFirebase(data.results);
      return PaginatedListResult(data: [...data.results], totalCount: data.totalResults ?? 0, hasMore: false);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveNewsToFirebase(List<NewsData> newsList) async {
    try {
      for (final news in newsList) {
        if (news.articleId == null) continue;

        final newsWithCode = news.copyWith(code: _generateCode());

        await _newsRef.doc(news.articleId).set(newsWithCode);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PaginatedListResult<NewsData>> getNewsFromFirebase({
    DocumentSnapshot? lastDocument,
    int limit = NetworkConstants.pageSize,
  }) async {
    try {
      bool hasMore = false;

      Query<NewsData> query = _newsRef.orderBy(NewsDataFields.createdAt, descending: true);
      if (lastDocument != null) query = query.startAfterDocument(lastDocument);

      final newsSnapshot = await query.limit(limit).get().then((value) => value.docs);

      hasMore = newsSnapshot.length == limit;
      lastDocument = newsSnapshot.lastOrNull;

      return PaginatedListResult(
        data: newsSnapshot.map((e) => e.data()).toList(),
        lastDocument: lastDocument,
        hasMore: hasMore,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<PaginatedListResult<NewsData>> getNewsByCategory({
    required String category,
    DocumentSnapshot? lastDocument,
    int limit = NetworkConstants.pageSize,
  }) async {
    try {
      bool hasMore = false;

      Query<NewsData> query = _newsRef
          .where(NewsDataFields.category, arrayContains: category.toLowerCase())
          .orderBy(NewsDataFields.createdAt, descending: true);
      if (lastDocument != null) query = query.startAfterDocument(lastDocument);

      final newsSnapshot = await query.limit(limit).get().then((value) => value.docs);

      hasMore = newsSnapshot.length == limit;
      lastDocument = newsSnapshot.lastOrNull;

      return PaginatedListResult(
        data: newsSnapshot.map((e) => e.data()).toList(),
        lastDocument: lastDocument,
        hasMore: hasMore,
      );
    } catch (e) {
      rethrow;
    }
  }
}
