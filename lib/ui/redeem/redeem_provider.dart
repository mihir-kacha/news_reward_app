part of 'redeem.dart';

final class RedeemProvider extends BaseProvider{
  RedeemProvider({required super.context});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController coinController = TextEditingController();
  final TextEditingController upiController = TextEditingController();

  int amount = 1;
  int coins = 0;
  int minCoins = 0;
}