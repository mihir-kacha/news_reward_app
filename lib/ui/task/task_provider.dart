part of 'task.dart';

final class TaskProvider extends BaseProvider with SubscriptionHelper {
  final UserRepository userRepository;
  final LoadingDialogHandler loadingDialogHandler;

  TaskProvider({required super.context, required this.userRepository, required this.loadingDialogHandler});

  final _luckDuration = Duration(hours: 24);
  final _drinkWaterDuration = Duration(hours: 1);
  final _walkDuration = Duration(hours: 1);
  final _exerciseDuration = Duration(hours: 1);
  final _prayDuration = Duration(hours: 6);

  List<NewsReadModel> list = [];
  int readNews = 0;
  Set<String> claimedIds = {};
  bool isLoading = false;

  Timer? _challengeTimer;

  Duration? luckRemaining;
  Duration? drinkWaterRemaining;
  Duration? walkRemaining;
  Duration? exerciseRemaining;
  Duration? prayRemaining;

  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();
    _checkAndResetDailyData();
    subscriptions.addAll([eventBus.on<SurveyCompletedEvet>().listen(onSurveyCompleted)]);
    await Future.wait([_loadDailyTask()]);
    readNews = preference.readNews;
    claimedIds = preference.claimedSurveyIds;
    _updateRemaining();
    _startChallengeTimer();
    isLoading = false;
    notifyListeners();
  }

  Future<void> _loadDailyTask() async {
    final raw = await processApi(request: () async => await rootBundle.loadString(Assets.json.newsRead));
    if (raw == null) return;
    final decoded = json.decode(raw);
    final jsonList = decoded['daily_task'] as List;
    final result = jsonList.map((e) => NewsReadModel.fromJson(e)).toList();
    list = result;
    notifyListeners();
  }

  void onSurveyCompleted(SurveyCompletedEvet event) {
    readNews = preference.readNews;
    notifyListeners();
  }

  void _checkAndResetDailyData() {
    final now = DateTime.now();
    final lastReset = preference.surveyResetDate;

    final bool isNewDay =
        lastReset == null || lastReset.year != now.year || lastReset.month != now.month || lastReset.day != now.day;

    if (!isNewDay) return;

    preference.readNews = 0;
    preference.claimedSurveyIds = {};
    preference.surveyResetDate = DateTime(now.year, now.month, now.day);

    readNews = 0;
    claimedIds.clear();
  }

  ClaimStatus buttonStatus({required String id, required int total}) {
    if (id.isEmpty) return ClaimStatus.locked;
    if (claimedIds.contains(id)) return ClaimStatus.claimed;
    if (readNews >= (total)) return ClaimStatus.claim;
    return ClaimStatus.locked;
  }

  Duration? remainingFor(ChallengeType type) {
    return switch (type) {
      ChallengeType.luck => luckRemaining,
      ChallengeType.drinkWater => drinkWaterRemaining,
      ChallengeType.walk => walkRemaining,
      ChallengeType.exercise => exerciseRemaining,
      ChallengeType.pray => prayRemaining,
    };
  }

  Duration _durationFor(ChallengeType type) {
    return switch (type) {
      ChallengeType.luck => _luckDuration,
      ChallengeType.drinkWater => _drinkWaterDuration,
      ChallengeType.walk => _walkDuration,
      ChallengeType.exercise => _exerciseDuration,
      ChallengeType.pray => _prayDuration,
    };
  }

  DateTime? _timerFor(ChallengeType type) {
    return switch (type) {
      ChallengeType.luck => preference.luckTimer,
      ChallengeType.drinkWater => preference.drinkWaterTimer,
      ChallengeType.walk => preference.walkTimer,
      ChallengeType.exercise => preference.exerciseTimer,
      ChallengeType.pray => preference.prayTimer,
    };
  }

  void _setChallengeTimer(ChallengeType type, DateTime? value) {
    switch (type) {
      case ChallengeType.luck:
        preference.luckTimer = value;
        break;
      case ChallengeType.drinkWater:
        preference.drinkWaterTimer = value;
        break;

      case ChallengeType.walk:
        preference.walkTimer = value;
        break;

      case ChallengeType.exercise:
        preference.exerciseTimer = value;
        break;

      case ChallengeType.pray:
        preference.prayTimer = value;
        break;
    }
  }

  Future<void> onChallengeTap(ChallengeType type) async {
    final startedAt = _timerFor(type);

    if (startedAt != null) {
      final endTime = startedAt.add(_durationFor(type));

      if (DateTime.now().isBefore(endTime)) {
        return;
      }
    }

    await _processReward(coins: type.coins);
    _setChallengeTimer(type, DateTime.now());
    _updateRemaining();
    notifyListeners();
    // if (type == ChallengeType.luck) {
    //   return context.showSuccessMessage(title: "You received ${type.coins} coins.");
    // }
  }

  void _updateRemaining() {
    if (_disposed) return;

    luckRemaining = _calculateRemaining(preference.luckTimer, _luckDuration);
    drinkWaterRemaining = _calculateRemaining(preference.drinkWaterTimer, _drinkWaterDuration);
    walkRemaining = _calculateRemaining(preference.walkTimer, _walkDuration);
    exerciseRemaining = _calculateRemaining(preference.exerciseTimer, _exerciseDuration);
    prayRemaining = _calculateRemaining(preference.prayTimer, _prayDuration);

    if (!_disposed) {
      notifyListeners();
    }
  }

  Duration? _calculateRemaining(DateTime? startedAt, Duration duration) {
    if (startedAt == null) return null;

    final endTime = startedAt.add(duration);
    final remaining = endTime.difference(DateTime.now());

    if (remaining <= Duration.zero) {
      return null;
    }

    return remaining;
  }

  void _startChallengeTimer() {
    _challengeTimer?.cancel();

    _challengeTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_disposed) return;
      _updateRemaining();
    });
  }

  Future<void> getCoinForReadNews({required NewsReadModel news}) async {
    await _processReward(coins: news.coins ?? 0);
    claimedIds.add(news.id!);
    preference.claimedSurveyIds = claimedIds;
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

  @override
  void dispose() {
    _disposed = true;
    _challengeTimer?.cancel();
    super.dispose();
  }
}
