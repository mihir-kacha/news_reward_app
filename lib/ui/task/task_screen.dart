part of 'task.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  static const String routeName = '/task';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(
        context: context,
        loadingDialogHandler: LoadingDialogHandler(context: context),
        userRepository: UserRepository(uid: Preference().userId ?? ""),
      ),
      child: TaskScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsPayAppbar(title: Text("Daily Task"), showBack: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: Spacing.normal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
              child: NewsPayCoinCard(),
            ),
            Gap(Spacing.medium),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
              child: Text(
                "Read News & Earn Rewards",
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.shadow,
                  fontWeight: FontWeight.w700,
                ),
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
