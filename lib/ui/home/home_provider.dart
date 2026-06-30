part of 'home.dart';

final class HomeProvider extends BaseProvider implements PaginationProvider<NewsData> {
  final NewsRepository newsRepository;

  HomeProvider({required super.context, required this.newsRepository});

  List<NewsData> _list = [];
  bool _loading = false;
  bool _reachAtEnd = false;
  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNews();
    });
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
