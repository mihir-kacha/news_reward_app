part of 'refer.dart';

class ReferScreen extends StatelessWidget {
  const ReferScreen({super.key});

  static const String routeName = '/refer';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReferProvider(context: context),
      child: ReferScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLow,
      appBar: InshortsAppbar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Refer & Earn", style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            Text(
              "Invite friend & earn exciting rewards",
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.surfaceTint,
              ),
            ),
          ],
        ),
        autoLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _DataCell(
                    icon: Assets.icons.profile.icCoin.path,
                    title: "0",
                    subTitle: "Earning",
                    info: "Total points earned",
                    color: Color(0XFFee9f10),
                  ),
                ),
                Gap(Spacing.normal),
                Expanded(
                  child: _DataCell(
                    icon: Assets.icons.profile.icPeoples.path,
                    title: "0",
                    subTitle: "Referrals",
                    info: "Total friend invited",
                    color: Color(0XFF8d59ff),
                  ),
                ),
              ],
            ),
            Gap(Spacing.medium),
            _ReferCodeCell(),
            Gap(Spacing.medium),
            _ReferCells(),
            Gap(Spacing.medium),
            FilledButton(
              // style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium)),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.icons.profile.icShare.svg(
                    height: 18,
                    colorFilter: ColorFilter.mode(context.colorScheme.onPrimary, BlendMode.srcIn),
                  ),
                  Gap(Spacing.medium),
                  Text(
                    "Invite Now",
                    style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
            Gap(Spacing.normal),
            Text(
              "Read News & Earn Rewards",
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap(Spacing.small),
            DynamicHeightGridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 14,
              builder: (context, index) {
                final count = index + 1;
                final coins = count * (5000);
                return ReadingNewsTask(
                  total: count * 10,
                  coins: coins,
                  title: "Invite ${count * 10} friends",
                  subtitle: "Earn ${coins.formattedIndian} Points",
                  onTap: () {},
                  isPercentage: true,
                  icon: Assets.icons.profile.icPeoples.svg(
                    height: 24,
                    colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
                  ),
                );
              },
              padding: EdgeInsets.only(bottom: context.padding.bottom + Spacing.xLarge),
              crossAxisCount: 1,
            ),
          ],
        ),
      ),
    );
  }
}
