part of 'home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(
        context: context,
        loadingDialogHandler: LoadingDialogHandler(context: context),
        newsRepository: NewsRepository(),
      ),
      child: HomeScreen(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final provider = context.read<HomeProvider>();
  //   return Scaffold(
  //     backgroundColor: context.colorScheme.shadow,
  //     body: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(8),
  //         child: PageView.builder(
  //           controller: provider.controller,
  //           scrollDirection: Axis.vertical,
  //           itemCount: provider.news.length,
  //           itemBuilder: (context, index) {
  //             return AnimatedBuilder(
  //               animation: provider.controller,
  //               builder: (context, child) {
  //                 double page = 0;
  //
  //                 if (provider.controller.hasClients) {
  //                   page = provider.controller.page ?? provider.controller.initialPage.toDouble();
  //                 }
  //
  //                 return _AnimatedNewsCard(index: index, difference: index - page);
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();
    final currentIndex = context.select<HomeProvider, int>((provider) => provider.currentIndex);
    final isDraggingDown = context.select<HomeProvider, bool>((provider) => provider.isDraggingDown);
    final news = context.select<HomeProvider, List<NewsData>>((value) => value.news);
    final progress = context.select<HomeProvider, double>((value) => value.dragProgress);
    if (provider.currentNews == null) {
      return const SizedBox();
    }
    return Scaffold(
      appBar: InshortsAppbar(title: Text("Inshorts"),showBack: false,),
      // backgroundColor: context.colorScheme.shadow.withColorOpacity(.08),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.small),
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
      ),
    );
  }
}

// class _AnimatedNewsCard extends StatelessWidget {
//   const _AnimatedNewsCard({required this.index, required this.difference});
//
//   final int index;
//   final double difference;
//
//   @override
//   Widget build(BuildContext context) {
//     final distance = difference.abs().clamp(0.0, 1.0);
//
//     /// 0 → current page
//     /// 1 → adjacent page
//
//     final revealProgress = 1 - distance;
//
//     /// Overshoot animation
//     final curved = Curves.easeOutBack.transform(revealProgress);
//
//     /// Start smaller → become slightly bigger → settle at 1
//     final scale = lerpDouble(.82, 1.0, curved)!;
//
//     /// Fade in
//     final opacity = lerpDouble(.0, 1.0, revealProgress)!;
//
//     double translateY;
//
//     if (difference > 0) {
//       /// next page (scrolling up)
//       translateY = lerpDouble(context.height * .18, 0, curved)!;
//     } else {
//       /// previous page (scrolling down)
//       translateY = lerpDouble(-context.height * .18, 0, curved)!;
//     }
//
//     return Transform.translate(
//       offset: Offset(0, translateY),
//       child: Transform.scale(
//         alignment: Alignment.center,
//         scale: scale,
//         child: Opacity(
//           opacity: opacity,
//           child: NewsCard(index: index),
//         ),
//       ),
//     );
//   }
// }
