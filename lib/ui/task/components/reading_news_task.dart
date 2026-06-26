part of '../task.dart';

class _DailyNewsReadingTask extends StatelessWidget {
  const _DailyNewsReadingTask();

  @override
  Widget build(BuildContext context) {
    final list = context.select<TaskProvider, List<int>>((value) => value.coins);
    return DynamicHeightGridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      builder: (context, index) {
        final coins = list[index];
        return ReadingNewsTask(
          total: index + 1,
          coins: coins,
          title: "Read ${index + 1} news daily",
          subtitle: "Read News Daily & Earn ${coins.formattedIndian} Points",
          onTap: () {},
          icon: Image.asset(Assets.images.challangeImages.imgNewspaper.path, height: 30, width: 30),
        );
      },
      padding: EdgeInsets.only(bottom: context.padding.bottom + Spacing.xLarge),
      crossAxisCount: 1,
    );
  }
}
