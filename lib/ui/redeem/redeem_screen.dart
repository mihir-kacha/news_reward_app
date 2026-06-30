part of 'redeem.dart';

class RedeemScreen extends StatelessWidget {
  const RedeemScreen({super.key});

  static const String routeName = '/redeem';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RedeemProvider(
        context: context,
        loadingDialogHandler: LoadingDialogHandler(context: context),
        withdrawalRepository: WithdrawalRepository(),
      ),
      child: RedeemScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsPayAppbar(title: Text("Withdraw Coins"), showBack: false),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(Spacing.normal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewsPayCoinCard(),
            Gap(Spacing.medium),
            _RedeemCoins(),
          ],
        ),
      ),
    );
  }
}
