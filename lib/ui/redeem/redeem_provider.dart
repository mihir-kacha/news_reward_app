part of 'redeem.dart';

final class RedeemProvider extends BaseProvider {
  final WithdrawalRepository withdrawalRepository;
  final LoadingDialogHandler loadingDialogHandler;

  RedeemProvider({required super.context, required this.withdrawalRepository, required this.loadingDialogHandler});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController coinController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();

  int amount = 1;
  int coins = 0;
  int minCoins = 0;

  @override
  void initState() {
    super.initState();
    coins = preference.coins;
    minCoins = preference.minCoins;
  }

  String getCurrencyValue(int coins) {
    final amount = coins / preference.coins;

    return '\$${amount.toStringAsFixed(2)}';
  }

  Future<void> withDraw({required int coins}) async {
    if (formKey.currentState?.validate() ?? false) {
      if ((int.parse(coinController.text.trim())) < minCoins) {
        context.showErrorMessage(title: "Please enter valid amount of coins");
        return;
      }
      if ((int.parse(coinController.text.trim())) > (coins)) {
        context.showErrorMessage(title: "Please enter valid amount of coins");
        return;
      }
      final result = await processApi(
        request: () async {
          return await withdrawalRepository.withdraw(
            redeemDoc: WithdrawalsDocument(
              claimedBy: preference.userId ?? "",
              currencyCode: 'usd',
              paymentId: paymentController.text.trim(),
              withdrawCoin: int.parse(coinController.text.trim()),
              withdrawAmount: getCurrencyValue(int.parse(coinController.text)),
            ),
          );
        },
        onLoading: loadingDialogHandler.handleLoading,
      );
      if (result != null && context.mounted) {
        CommonFunc.closeKeyboard();
        coinController.clear();
        paymentController.clear();
        notifyListeners();
        context.showSuccessMessage(title: "Withdrawal Successful");
      }
    }
  }
}
