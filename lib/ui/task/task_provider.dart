part of 'task.dart';

final class TaskProvider extends BaseProvider {
  TaskProvider({required super.context});

  final _luckDuration = Duration(hours: 24);
  final _drinkWaterDuration = Duration(hours: 1);
  final _walkDuration = Duration(hours: 1);
  final _exerciseDuration = Duration(hours: 1);
  final _prayDuration = Duration(hours: 6);

  Timer? _challengeTimer;

  Duration? luckRemaining;
  Duration? drinkWaterRemaining;
  Duration? walkRemaining;
  Duration? exerciseRemaining;
  Duration? prayRemaining;

  bool _disposed = false;

  final List<int> coins = [1000, 2000, 3000, 5000, 7000, 10000, 12000, 15000, 17000, 20000];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _updateRemaining();
    _startChallengeTimer();
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

    // await _processReward(coins: type.coins);
    _setChallengeTimer(type, DateTime.now());
    _updateRemaining();
    notifyListeners();
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

  @override
  void dispose() {
    _disposed = true;
    _challengeTimer?.cancel();
    super.dispose();
  }
}
