part of '../redeem.dart';

class _GiftCardGrid extends StatelessWidget {
  const _GiftCardGrid();

  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      crossAxisCount: 2,
      mainAxisSpacing: Spacing.medium,
      crossAxisSpacing: Spacing.normal,
      builder: (context, index) => _CouponsCard(),
    );
  }
}

class _CouponsCard extends StatelessWidget {
  const _CouponsCard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: Spacing.large),
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary,
            borderRadius: ShapeBorderRadius.xLarge,
            boxShadow: [
              BoxShadow(color: context.colorScheme.shadow.withColorOpacity(.2), blurRadius: 6, offset: Offset(0, 0)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(Spacing.xxxLarge),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.medium),
                decoration: BoxDecoration(color: Color(0xFF003087), borderRadius: ShapeBorderRadius.small),
                child: Text(
                  'PayPal',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Gap(Spacing.small),
              Text(
                'Paypal Gift Card',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
              ),
              Gap(Spacing.medium),
              Container(
                padding: EdgeInsets.symmetric(vertical: Spacing.small),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceTint.withColorOpacity(.2),
                  borderRadius: BorderRadius.vertical(bottom: RadiusValues.xLarge),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.imgCoin.image(height: 18),
                    Gap(Spacing.xSmall),
                    Text('250,000', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Spacing.large, vertical: Spacing.small),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [context.colorScheme.primary, context.colorScheme.secondary],
                begin: Alignment.centerLeft,
                end: AlignmentGeometry.centerRight,
              ),
              borderRadius: ShapeBorderRadius.normal,
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.primary.withColorOpacity(.25),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Text(
              '\$50.00',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
