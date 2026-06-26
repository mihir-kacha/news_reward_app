part of 'redeem.dart';

class RedeemScreen extends StatelessWidget {
  const RedeemScreen({super.key});

  static const String routeName = '/redeem';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RedeemProvider(context: context),
      child: RedeemScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InshortsAppbar(title: Text("Gift Card Coupons"), showBack: false),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(Spacing.normal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InshortsCoinCard(),
            Gap(Spacing.medium),
            _RedeemCoins(),
            // Text(
            //   "PayPal Gift Cards",
            //   style: context.textTheme.titleLarge?.copyWith(
            //     color: context.colorScheme.shadow,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            // Gap(Spacing.small),
            // _GiftCardGrid(),
          ],
        ),
      ),
    );
  }
}
