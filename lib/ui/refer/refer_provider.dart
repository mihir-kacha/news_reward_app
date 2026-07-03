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
  String? referralById;

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
    resolveAdUnitId(
      slot: NativeAdTyped.detail,
      isThisAdPlaceEnable: preference.adsConfig?.adPlaceConfig?.referAd ?? false,
    );
  }

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();
    claimedIds = {...preference.claimedReferFriendIds};
    await Future.wait([_getInviterReferralCode(), _getInviterReferralId(), _getReferralCount(), _loadDailyTask()]);
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

  Future<void> _getInviterReferralId() async {
    final result = await processApi(
      request: () async {
        return await referralsRepository.getReferralCodeOfInviterId(currentUserId: preference.userId ?? "");
      },
    );

    if (result != null) {
      referralById = result;
      notifyListeners();
    }
  }

  Future<void> onContinue() async {
    CommonFunc.closeKeyboard();
    if (formKey.currentState?.validate() ?? false) {
      final result = await processApi(
        request: () async {
          return await referralsRepository.addReferralCode(
            referralCode: codeController.text,
            currentUserId: preference.userId ?? "",
          );
        },
        onLoading: loadingDialogHandler.handleLoading,
      );
      if (result ?? false) {
        await _getInviterReferralCode();
        await _getInviterReferralId();
        await _processReward(coins: preference.referralCoinsConfig.referralToCoins);
        await _processReward(coins: preference.referralCoinsConfig.referralByCoins, userId: referralById);
        notifyListeners();
      }
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
    await _addClaimedIdsToFirebase(refer: refer);
    claimedIds.add(refer.id!);
    preference.claimedReferFriendIds = claimedIds;
    _calculateEarningCoins();
    notifyListeners();
  }

  Future<void> _addClaimedIdsToFirebase({required ReferFriendModel refer}) async {
    await processApi(
      request: () async {
        await userRepository.addClaimedReferFriendId(id: refer.id!);
      },
    );
  }

  Future<void> _processReward({required int coins, String? userId}) async {
    await processApi(
      request: () async {
        return await userRepository.addCoins(coins: coins, referralById: userId);
      },
      onLoading: loadingDialogHandler.handleLoading,
    );
  }

  Future<void> loadRewardAd({
    required VoidCallback onRewardEarned,
    required VoidCallback onRewardFailed,
    required bool isThisAdPlaceEnable,
    required int coins,
  }) async {
    if (!isThisAdPlaceEnable ||
        !(preference.adsConfig?.adsStatusModel?.showAdsInApp ?? false) ||
        !(preference.adsConfig?.adsStatusModel?.isRewardAdShow ?? false)) {
      return;
    }

    final res = await RewardAdWatchDialog.show(context: context, coins: coins);
    if (!res) return;

    loadingDialogHandler.handleLoading(
      true,
      message:
          (preference.adsConfig?.adsStatusModel?.showAdsInApp ?? false) &&
              (preference.adsConfig?.adsStatusModel?.isRewardAdShow ?? false)
          ? "Ad Loading"
          : "",
    );

    final result = await AdHelper.instance.loadRewarded(isThisAdPlaceEnable: isThisAdPlaceEnable);

    if (result.success) {
      NavigationAdHelper.instance.isRewardAdActive = true;
      AdHelper.instance.setRewardedCallbacks(
        onRewardEarned: (_) => onRewardEarned(),
        onFailed: (_) => onRewardFailed(),
        onDismissed: () {
          NavigationAdHelper.instance.isRewardAdActive = false;
          loadingDialogHandler.handleLoading(false);
          onRewardEarned();
        },
      );
      await AdHelper.instance.showRewarded();
    } else {
      onRewardEarned.call();
      loadingDialogHandler.handleLoading(false);
    }
  }
}
