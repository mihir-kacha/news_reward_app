part of 'home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(
        context: context,
        newsRepository: NewsRepository(),
      ),
      child: HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsPayAppbar(title: Text("NewsPay"), showBack: false),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();
    final list = context.select<HomeProvider, List<NewsData>>((value) => value.list);
    final isLoading = context.select<HomeProvider, bool>((value) => value.loading);
    if (provider.list.isEmpty) {
      if (isLoading) {
        return Center(child: LoadingIndicator());
      }
      return SizedBox();
    }
    return PaginationListener(
      onRefresh: (context) => provider.onRefresh(),
      onScrollToEnd: (context) => provider.onLoadMore(),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final newsData = list[index];
          return NewsCell(newsData: newsData);
        },
      ),
    );
  }
}
