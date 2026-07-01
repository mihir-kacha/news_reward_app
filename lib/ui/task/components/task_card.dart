part of '../task.dart';

class _TaskChallengeList extends StatelessWidget {
  const _TaskChallengeList();

  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ChallengeType.values.length,
      builder: (context, index) => _TaskCard(type: ChallengeType.values[index]),
      crossAxisCount: 1,
    );
  }
}

class _TaskCard extends StatelessWidget {
  final ChallengeType type;

  const _TaskCard({required this.type});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TaskProvider>();
    final remaining = context.select<TaskProvider, Duration?>((v) => v.remainingFor(type));
    final isRunning = remaining != null && remaining > Duration.zero;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
      child: Container(
        width: context.width,
        padding: EdgeInsets.all(Spacing.medium),
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withColorOpacity(.08),
              offset: Offset(0, 2),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
          borderRadius: ShapeBorderRadius.medium,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.shadow.withColorOpacity(.1),
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Image.asset(type.emoji, height: 30, width: 30),
            ),
            Gap(Spacing.small),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.label(context),
                    style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.shadow),
                  ),
                  Text(
                    isRunning ? "Next reward in : \n${CommonFunc.formatDuration(remaining)}" : type.desc(context),
                    style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.surfaceTint),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(Spacing.xSmall),
                  if (!(type == ChallengeType.luck)) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Assets.images.imgCoin.image(height: 12),
                        Gap(Spacing.xSmall),
                        Text(
                          type.coins.formattedIndian,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.shadow,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Gap(Spacing.normal),
            CommonButton.cupertino(
              onTap: isRunning
                  ? null
                  : () => provider.loadRewardAd(
                      onRewardEarned: () => provider.onChallengeTap(type),
                      onRewardFailed: () => RewardAdFailedDialog.show(context),
                      isThisAdPlaceEnable: Preference().adsConfig?.adPlaceConfig?.dailyActivityReward ?? false,
                      coins: type.coins,
                    ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.normal),
                decoration: BoxDecoration(
                  boxShadow: isRunning
                      ? null
                      : [
                          BoxShadow(
                            color: context.colorScheme.primary.withColorOpacity(.8),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0, 0),
                          ),
                        ],
                  color: isRunning ? context.colorScheme.primary.withColorOpacity(.3) : context.colorScheme.primary,
                  borderRadius: ShapeBorderRadius.small,
                ),
                child: Text(
                  "Claim",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
