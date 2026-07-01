part of 'ads.dart';

enum AdLoadState { idle, loading, loaded, showing, failed, disposed }

class AdLoadResult {
  final bool success;
  final String? loadedUnitId;
  final String? errorMessage;

  const AdLoadResult.success(this.loadedUnitId) : success = true, errorMessage = null;

  const AdLoadResult.failure(this.errorMessage) : success = false, loadedUnitId = null;

  @override
  String toString() =>
      success ? 'AdLoadResult(success, unitId: $loadedUnitId)' : 'AdLoadResult(failure, error: $errorMessage)';
}

class AdReward {
  final String type;
  final num amount;

  AdReward({required this.type, required this.amount});

  @override
  String toString() {
    return 'AdReward(type : $type, amount : $amount)';
  }
}
