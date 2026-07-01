part of 'congratulation.dart';

final class CongratulationProvider extends BaseProvider implements PaginationProvider<NewsData> {
  final int oldCoins;

  final NewsRepository newsRepository;

  CongratulationProvider({required super.context, required this.newsRepository, required this.oldCoins});

  List<NewsData> _list = [];
  bool _loading = false;
  bool _reachAtEnd = false;
  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();
    _getNews();
    resolveAdUnitId(
      slot: NativeAdTyped.feed,
      isThisAdPlaceEnable: preference.adsConfig?.adPlaceConfig?.congratulationNewsAd ?? false,
    );
  }

  Future<void> _getNews() async {
    final result = await processApi(
      request: () async {
        return await newsRepository.getNewsFromFirebase();
      },
      onLoading: (loading) {
        _loading = loading;
        notifyListeners();
      },
    );
    if (result != null && context.mounted) {
      _lastDocument = result.lastDocument;
      _list = [..._list, ...result.data];
      _reachAtEnd = !result.hasMore;
      notifyListeners();
    }
  }

  @override
  List<NewsData> get list => _list;

  @override
  bool get loading => _loading;

  @override
  Future<void> onLoadMore() async {
    if (_loading || _reachAtEnd) return;
    return _getNews();
  }

  @override
  Future<void> onRefresh() async {
    if (_loading) return;
    _list = [];
    _lastDocument = null;
    _reachAtEnd = false;
    notifyListeners();
    return _getNews();
  }

  @override
  bool get reachAtEnd => _reachAtEnd;
}
