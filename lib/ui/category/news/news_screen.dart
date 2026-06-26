part of 'news.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  static const String routeName = '/news';

  static Widget builder(BuildContext context) {
    final category = context.args as Category;
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(
        context: context,
        category: category,
        newsRepository: NewsRepository(),
        loadingDialogHandler: LoadingDialogHandler(context: context),
      ),
      child: NewsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewsProvider>();

    return Scaffold(
      appBar: InshortsAppbar(title: Text(provider.category.label)),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewsProvider>();
    final currentIndex = context.select<NewsProvider, int>((provider) => provider.currentIndex);
    final isDraggingDown = context.select<NewsProvider, bool>((provider) => provider.isDraggingDown);
    final news = context.select<NewsProvider, List<NewsData>>((value) => value.news);
    final progress = context.select<NewsProvider, double>((value) => value.dragProgress);
    if (provider.currentNews == null) {
      return SizedBox.shrink();
    }
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(Spacing.small),
        child: Stack(
          children: [
            if (isDraggingDown) ...[
              if (currentIndex > 0)
                BackgroundCard(
                  index: currentIndex - 1,
                  type: CardPosition.previous,
                  data: news[currentIndex - 1],
                  progress: progress,
                ),
              Positioned.fill(
                child: DraggableNewsCard(
                  key: ValueKey(currentIndex),
                  index: currentIndex,
                  data: news[currentIndex],
                  changeNews: provider.changeNews,
                  setDirection: provider.setDirection,
                  updateProgress: provider.updateProgress,
                  currentIndex: currentIndex,
                  newsLength: provider.news.length,
                ),
              ),
            ] else ...[
              if (currentIndex < provider.news.length - 1)
                BackgroundCard(
                  index: currentIndex + 1,
                  type: CardPosition.next,
                  data: news[currentIndex + 1],
                  progress: progress,
                ),
              Positioned.fill(
                child: DraggableNewsCard(
                  key: ValueKey(currentIndex),
                  index: currentIndex,
                  data: news[currentIndex],
                  changeNews: provider.changeNews,
                  setDirection: provider.setDirection,
                  updateProgress: provider.updateProgress,
                  currentIndex: currentIndex,
                  newsLength: provider.news.length,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
