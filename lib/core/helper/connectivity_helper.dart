part of '../core.dart';

final class ConnectivityHelper {
  ConnectivityHelper._();

  static final ConnectivityHelper instance = ConnectivityHelper._();

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isDialogOpen = false;
  BuildContext? _context;
  Completer<void>? _internetCompleter;

  void initialize(BuildContext context) {
    _context = context;

    _subscription?.cancel();

    _subscription = Connectivity().onConnectivityChanged.listen((results) async {
      if (_context == null || !_context!.mounted) return;

      final current = (await Connectivity().checkConnectivity());
      final hasInternet = current.any(
        (r) => r == ConnectivityResult.wifi || r == ConnectivityResult.mobile || r == ConnectivityResult.ethernet,
      );

      if (!hasInternet) {
        _showNoInternet();
      } else {
        _hideNoInternet();
        if (_internetCompleter != null && !_internetCompleter!.isCompleted) {
          _internetCompleter!.complete();
          _internetCompleter = null;
        }
      }
    });

    Log.success('[ConnectivityHelper] ✅ Listening for connectivity changes');
  }

  Future<void> waitForInternet() async {
    final current = await Connectivity().checkConnectivity();
    final hasInternet = current.any(
      (r) => r == ConnectivityResult.wifi || r == ConnectivityResult.mobile || r == ConnectivityResult.ethernet,
    );

    if (hasInternet) return;

    _showNoInternet();
    _internetCompleter = Completer<void>();
    await _internetCompleter!.future;
  }

  void updateContext(BuildContext context) {
    _context = context;
  }

  void _showNoInternet() {
    if (_isDialogOpen || _context == null || !_context!.mounted) return;
    _isDialogOpen = true;

    NetworkDialog.show(onRefresh: _onRetry, context: _context!).then((_) => _isDialogOpen = false);

    Log.error('[ConnectivityHelper] 📵 No internet — dialog shown');
  }

  void _hideNoInternet() {
    if (!_isDialogOpen || _context == null || !_context!.mounted) return;
    if (_context?.navigator.canPop() ?? false) {
      _context?.navigator.pop();
      _isDialogOpen = false;
    }

    Log.success('[ConnectivityHelper] ✅ Internet restored — dialog dismissed');
  }

  Future<void> _onRetry() async {
    final results = await Connectivity().checkConnectivity();
    final hasInternet = results.any(
      (r) => r == ConnectivityResult.wifi || r == ConnectivityResult.mobile || r == ConnectivityResult.ethernet,
    );

    if (hasInternet) {
      _hideNoInternet();
    }
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _context = null;
    _isDialogOpen = false;
    Log.error('[ConnectivityHelper] 🛑 Disposed');
  }
}
