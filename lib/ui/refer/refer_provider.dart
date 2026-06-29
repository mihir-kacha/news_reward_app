part of 'refer.dart';

final class ReferProvider extends BaseProvider {
  final UserRepository userRepository;
  final ReferralsRepository referralsRepository;
  final LoadingDialogHandler loadingDialogHandler;

  ReferProvider({
    required super.context,
    required this.referralsRepository,
    required this.loadingDialogHandler,
    required this.userRepository,
  });

  final formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();

  String? inviterReferralCode;

  List<ReferFriendModel> list = [];
  int referralCount = 0;
  Set<String> claimedIds = {};
  bool isLoading = false;
  int earningCoins = 0;

  @override
  void initState() {
    super.initState();
    _init();
    Log.debug(referralCount);
  }

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();
    claimedIds = preference.claimedReferFriendIds;
    await Future.wait([_getInviterReferralCode(), _getReferralCount(), _loadDailyTask()]);
    _calculateEarningCoins();
    isLoading = false;
    notifyListeners();
  }

  Future<void> _loadDailyTask() async {
    final raw = await processApi(request: () async => await rootBundle.loadString(Assets.json.referFriend));
    if (raw == null) return;
    final decoded = json.decode(raw);
    final jsonList = decoded['daily_task'] as List;
    final result = jsonList.map((e) => ReferFriendModel.fromJson(e)).toList();
    list = result;
  }

  Future<void> onInvite() async {
    await SharePlus.instance.share(ShareParams(text: 'Check out this awesome app!', subject: 'My App'));
  }

  void _calculateEarningCoins() {
    earningCoins = 0;

    for (final task in list) {
      if (claimedIds.contains(task.id)) {
        earningCoins += task.coins ?? 0;
      }
    }
  }

  ClaimStatus buttonStatus({required String id, required int total}) {
    if (id.isEmpty) return ClaimStatus.locked;
    if (claimedIds.contains(id)) return ClaimStatus.claimed;
    if (referralCount >= (total)) return ClaimStatus.claim;
    return ClaimStatus.locked;
  }

  Future<void> _getInviterReferralCode() async {
    final result = await processApi(
      request: () async {
        return await referralsRepository.getReferralCodeOfInviter(currentUserId: preference.userId ?? "");
      },
    );

    if (result != null) {
      inviterReferralCode = result;
      notifyListeners();
    }
  }

  Future<void> onContinue() async {
    CommonFunc.closeKeyboard();
    if (formKey.currentState?.validate() ?? false) {
      await processApi(
        request: () async {
          await referralsRepository.addReferralCode(
            referralCode: codeController.text,
            currentUserId: preference.userId ?? "",
          );
        },
        onLoading: loadingDialogHandler.handleLoading,
      );
      await _getInviterReferralCode();
      notifyListeners();
    }
  }

  Future<void> _getReferralCount() async {
    final result = await processApi(
      request: () async {
        return await referralsRepository.getReferralCount(currentUserId: preference.userId ?? "");
      },
    );

    if (result != null) {
      referralCount = result;
    }
  }

  Future<void> getCoinForReferFriend({required ReferFriendModel refer}) async {
    await _processReward(coins: refer.coins ?? 0);
    claimedIds.add(refer.id!);
    preference.claimedReferFriendIds = claimedIds;
    _calculateEarningCoins();
    notifyListeners();
  }

  Future<void> _processReward({required int coins}) async {
    await processApi(
      request: () async {
        return await userRepository.addCoins(coins: coins);
      },
      onLoading: loadingDialogHandler.handleLoading,
    );
  }
}
