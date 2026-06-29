part of '../task.dart';

class _DailyNewsReadingTask extends StatelessWidget {
  const _DailyNewsReadingTask();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TaskProvider>();
    final list = context.select<TaskProvider, List<NewsReadModel>>((value) => value.list);
    return DynamicHeightGridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      builder: (context, index) {
        final data = list[index];
        final status = context.select<TaskProvider, ClaimStatus>(
          (value) => value.buttonStatus(id: data.id ?? "", total: data.total ?? 0),
        );
        return ReadingNewsTask(
          status: status,
          total: data.total ?? 0,
          coins: data.coins ?? 0,
          title: data.title ?? '',
          subtitle: data.desc ?? '',
          onTap: () {
            provider.getCoinForReadNews(news: data);
          },
          icon: Image.asset(Assets.images.challangeImages.imgNewspaper.path, height: 30, width: 30),
        );
      },
      padding: EdgeInsets.only(bottom: context.padding.bottom + Spacing.xLarge),
      crossAxisCount: 1,
    );
  }
}
