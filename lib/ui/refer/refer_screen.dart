part of 'refer.dart';

class ReferScreen extends StatelessWidget {
  const ReferScreen({super.key});

  static const String routeName = '/refer';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReferProvider(
        context: context,
        loadingDialogHandler: LoadingDialogHandler(context: context),
        referralsRepository: ReferralsRepository(),
        userRepository: UserRepository(uid: Preference().userId ?? ""),
      ),
      child: ReferScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLow,
      appBar: NewsPayAppbar(
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
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ReferProvider>();
    final list = context.select<ReferProvider, List<ReferFriendModel>>((value) => value.list);
    final referCode = context.select<ReferProvider, String?>((value) => value.inviterReferralCode);
    final referralCount = context.select<ReferProvider, int?>((value) => value.referralCount);
    final earningCoins = context.select<ReferProvider, int?>((value) => value.earningCoins);
    final isLoading = context.select<ReferProvider, bool>((value) => value.isLoading);
    if (isLoading) {
      return LoadingIndicator();
    }
    return SingleChildScrollView(
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
                  title: "$earningCoins",
                  subTitle: "Earning",
                  info: "Total points earned",
                  color: Color(0XFFee9f10),
                ),
              ),
              Gap(Spacing.normal),
              Expanded(
                child: _DataCell(
                  icon: Assets.icons.profile.icPeoples.path,
                  title: "$referralCount",
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
          if (referCode == null) ...[_ReferCells()] else ...[_ReferCompletedCell()],
          Gap(Spacing.medium),
          FilledButton(
            onPressed: () {
              CommonFunc.inviteFriends(referralCode: referCode ?? "");
            },
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
            "Referral Rewards",
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.shadow,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(Spacing.small),
          DynamicHeightGridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: list.length,
            builder: (context, index) {
              final data = list[index];
              final status = context.select<ReferProvider, ClaimStatus>(
                (value) => value.buttonStatus(id: data.id ?? "", total: data.total ?? 0),
              );
              return ReadingNewsTask(
                referFriends: referralCount,
                status: status,
                total: data.total ?? 0,
                coins: data.coins ?? 0,
                title: data.title ?? "",
                subtitle: data.desc ?? "",
                onTap: () {
                  provider.getCoinForReferFriend(refer: data);
                },
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
    );
  }
}
