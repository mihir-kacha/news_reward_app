part of 'task.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  static const String routeName = '/task';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(context: context),
      child: TaskScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InshortsAppbar(title: Text("Daily Task"),showBack: false,),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(Spacing.normal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InshortsCoinCard(),
            Gap(Spacing.medium),
            Text(
              "Read News & Earn Rewards",
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap(Spacing.small),
            _TaskChallengeList(),
            Gap(Spacing.small),
            _DailyNewsReadingTask(),
          ],
        ),
      ),
    );
  }
}
