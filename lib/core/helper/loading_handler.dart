part of '../core.dart';

abstract class LoadingHandler {
  const LoadingHandler();

  void startLoading({String? message, bool? showAdLoader});

  void stopLoading();

  void handleLoading(bool loading, {String? message, bool showAdLoading = false}) {
    if (loading) {
      startLoading(message: message, showAdLoader: showAdLoading);
    } else {
      stopLoading();
    }
  }
}

class LoadingDialogHandler extends LoadingHandler {
  LoadingDialogHandler({required BuildContext context}) : _context = context;

  final BuildContext _context;
  Route? _dialogRoutes;

  Route _buildDialogRoute(BuildContext context, {String? message, bool? showAdLoader}) {
    assert(debugCheckHasCupertinoLocalizations(context));
    final CapturedThemes themes = InheritedTheme.capture(from: context, to: context.navigator.context);
    return DialogRoute(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      themes: themes,
      builder: (context) => PopScope(child: LoadingIndicator(showAdLoading: showAdLoader ?? false)),
    );
  }

  @override
  void startLoading({String? message, bool? showAdLoader}) {
    if (_dialogRoutes != null) return;
    _dialogRoutes = _buildDialogRoute(_context, showAdLoader: showAdLoader);
    _context.navigator.push(_dialogRoutes!);
  }

  @override
  void stopLoading() {
    if (_dialogRoutes != null && _context.mounted) _context.navigator.removeRoute(_dialogRoutes!);
    _dialogRoutes = null;
  }
}
