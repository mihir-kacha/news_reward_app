part of 'news.dart';

final class NewsProvider extends BaseProvider {
  final Category category;
  final NewsRepository newsRepository;
  final LoadingDialogHandler loadingDialogHandler;

  NewsProvider({
    required super.context,
    required this.category,
    required this.newsRepository,
    required this.loadingDialogHandler,
  });

  List<NewsData> news = [];

  int currentIndex = 0;
  bool isDraggingDown = false;
  double dragProgress = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNews();
    });
  }

  void updateProgress(double progress) {
    dragProgress = progress.clamp(0.0, 1.0);
    notifyListeners();
  }

  void setDirection(bool draggingDown) {
    if (isDraggingDown == draggingDown) return;

    isDraggingDown = draggingDown;
    notifyListeners();
  }

  void changeNews(int index) {
    if (index < 0 || index >= news.length) return;

    currentIndex = index;
    dragProgress = 0;
    isDraggingDown = false;
    notifyListeners();

    preloadAround(context);
  }

  NewsData? get currentNews => news.isEmpty ? null : news[currentIndex];

  void preloadAround(BuildContext context) {
    final indexes = [currentIndex - 2, currentIndex - 1, currentIndex + 1, currentIndex + 2];

    for (final index in indexes) {
      if (index < 0 || index >= news.length) {
        continue;
      }

      final imageUrl = news[index].imageUrl;

      if (imageUrl?.isNotEmpty == true) {
        precacheImage(NetworkImage(imageUrl!), context);
      }
    }
  }

  Future<void> getNews() async {
    final result = await processApi(
      request: () async {
        return await newsRepository.getNewsByCategory(category: category.name);
      },
      onLoading: loadingDialogHandler.handleLoading,
    );
    if (result != null && context.mounted) {
      news = [...result];
      notifyListeners();
      preloadAround(context);
    }
  }
}
