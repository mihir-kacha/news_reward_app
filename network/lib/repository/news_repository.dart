part of '../network.dart';

class NewsRepository {
  final _apiManager = ApiManager();
  final _newsRef = FireStoreHelper.newsRef;

  Future<PaginatedListResult<NewsData>> getNewsFromApi() async {
    try {
      final response = await _apiManager.callGet(url: ApiUrl.baseUrl, params: {ApiKeys.apiKeys: ApiUrl.apiKey});
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
        await _newsRef.doc(news.articleId).set(news);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsData>> getNewsFromFirebase() async {
    try {
      final response = await _newsRef.orderBy(NewsDataFields.createdAt, descending: true).get();

      final data = response.docs.map((e) => e.data()).toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsData>> getNewsByCategory({required String category}) async {
    try {
      final response = await _newsRef
          .where(NewsDataFields.category, arrayContains: category.toLowerCase())
          .orderBy(NewsDataFields.createdAt, descending: true)
          .get();

      final data = response.docs.map((e) => e.data()).toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
