part of 'ads.dart';

abstract class BaseAdLoader<T> {
  AdType get adType;

  List<String> Function() unitIdsResolver = () => [];

  AdLoadState _state = AdLoadState.idle;

  AdLoadState get state => _state;

  bool get isLoading => _state == .loading;

  bool get isLoaded => _state == .loaded;

  bool get isFailed => _state == .failed;

  T? _ad;

  T? get ad => _ad;

  int _unitIndex = 0;
  int _attemptCount = 0;

  Completer<AdLoadResult>? _loadCompleter;

  String get _currentUnitId {
    final ids = unitIdsResolver();
    if (ids.isEmpty) return '';
    return ids[_unitIndex % ids.length];
  }

  Future<AdLoadResult> load() async {
    if (_loadCompleter != null && !_loadCompleter!.isCompleted) {
      Log.error('${adType.name} Load already in progress.');
      return _loadCompleter!.future;
    }

    if (_state == .loaded && _ad != null) {
      Log.debug("${adType.name} Already loaded -- skipping");
      return AdLoadResult.success(_currentUnitId);
    }

    _loadCompleter = Completer<AdLoadResult>();
    _attemptCount = 0;
    _state = .loaded;

    await _tryLoad();
    return _loadCompleter!.future;
  }

  Future<void> _tryLoad() async {
    final ids = unitIdsResolver();
    if (ids.isEmpty) {
      Log.error('${adType.name.toUpperCase()} no unit ids configured.');
      _state = .failed;
      _loadCompleter?.complete(const AdLoadResult.failure('No ad IDs available'));
      return;
    }

    final maxTries = ids.length < kMaxAdRetries ? ids.length : kMaxAdRetries;

    if (_attemptCount >= maxTries) {
      Log.error('${adType.name.toUpperCase()} All retries failed');
      _state = .failed;
      _loadCompleter?.complete(AdLoadResult.failure('All $maxTries ad units failed'));
      return;
    }

    final unitId = ids[_unitIndex % ids.length];

    try {
      await loadAdFroUnit(unitId);
    } catch (e) {
      onFailed(unitId, e.toString());
    }
  }

  Future<void> loadAdFroUnit(String unitId);

  void onFailed(String unitId, String errorMessage) {
    Log.error('${adType.name.toUpperCase()} Failed $errorMessage');
    _attemptCount++;
    _unitIndex++;
    Future.microtask(_tryLoad);
  }

  void onLoaded(T loadedAd, String unitId) {
    _ad = loadedAd;
    _state = .loaded;
    Log.success('${adType.name.toUpperCase()} Loaded');
    _loadCompleter?.complete(AdLoadResult.success(unitId));
  }

  void dispose() {
    _disposesAd(_ad);
    _ad = null;
    _state = .disposed;
    _unitIndex = 0;
    _attemptCount = 0;
    _loadCompleter = null;
    Log.debug('${adType.name.toUpperCase()} Disposed');
  }

  void _disposesAd(T? ad) {
    if (ad == null) return;
    try {
      disposeAdObject(ad);
    } catch (e) {
      Log.error('${adType.name} Error during dispose : $e');
    }
  }

  void disposeAdObject(T? ad);

  void clearAd() {
    _disposesAd(_ad);
    _ad = null;
    _state = .idle;
  }
}
