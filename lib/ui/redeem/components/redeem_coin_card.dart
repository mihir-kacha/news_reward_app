part of '../redeem.dart';

class _RedeemCoins extends StatelessWidget {
  const _RedeemCoins();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RedeemProvider>();
    final coins = context.select<UserProvider, int>((value) => value.userData.coins ?? 0);
    return Form(
      key: provider.formKey,
      child: Container(
        padding: EdgeInsets.all(Spacing.normal),
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          borderRadius: ShapeBorderRadius.normal,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.secondary.withColorOpacity(.08),
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: Spacing.normal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(Spacing.normal),
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondary.withColorOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Assets.icons.icGift.svg(
                    height: 26,
                    width: 26,
                    colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Withdraw Rewards",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.colorScheme.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Convert your points into real rewards",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.colorScheme.surfaceTint,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(Spacing.large),
            Text(
              "Withdrawal Amount",
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap(Spacing.normal),
            AppInputField(
              controller: provider.coinController,
              fillColor: context.colorScheme.outlineVariant.withColorOpacity(.5),
              filled: true,
              keyboardType: TextInputType.number,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
                child: Assets.images.imgCoinGroup.image(height: 20, width: 20),
              ),
              hintText: "Enter Reward Points (Min. ${provider.minCoins})",
              hintStyle: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.tertiary,
                fontWeight: FontWeight.w500,
              ),
              borderColor: context.colorScheme.outline,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Enter withdrawal amount";
                }
                if (value.toInt() > (coins)) {
                  return "Insufficient balance";
                }
                if (value.toInt() < provider.minCoins) {
                  return "Minimum withdrawal amount is ${provider.minCoins}";
                }
                return null;
              },
            ),
            Gap(Spacing.normal),
            Container(
              padding: EdgeInsets.all(Spacing.normal),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withColorOpacity(.06),
                borderRadius: ShapeBorderRadius.normal,
                border: Border.all(color: context.colorScheme.primary.withColorOpacity(.2)),
              ),
              child: Row(
                children: [
                  Assets.icons.icInfo.svg(
                    height: 18,
                    width: 18,
                    colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
                  ),
                  Gap(Spacing.normal),
                  Expanded(
                    child: Text(
                      "${provider.coins} Coins = \$${provider.amount.toStringAsFixed(2)} (min ${provider.minCoins})",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Gap(Spacing.normal),
            Text(
              "Withdrawal Method",
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap(Spacing.normal),
            AppInputField(
              controller: provider.paymentController,
              fillColor: context.colorScheme.outlineVariant.withColorOpacity(.5),
              filled: true,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
                child: Assets.icons.icBank.svg(height: 24, width: 24),
              ),
              hintText: "PayPal",
              hintStyle: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.tertiary,
                fontWeight: FontWeight.w500,
              ),
              borderColor: context.colorScheme.outline,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "UPI ID is required";
                }
                if (!AppConstants.upiRegex.hasMatch(provider.paymentController.text.trim())) {
                  return 'Enter a valid PayPal email';
                }
                return null;
              },
            ),
            Gap(Spacing.xLarge),
            FilledButton(
              onPressed: () => provider.withDraw(coins: coins),
              style: FilledButton.styleFrom(
                fixedSize: Size.fromWidth(context.width),
                shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.normal),
              ),
              child: Text(
                "Withdraw",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
