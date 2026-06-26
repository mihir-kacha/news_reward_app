part of '../core.dart';

abstract class LoadingHandler {
  const LoadingHandler();

  void startLoading({String? message, bool? showBookLoader});

  void stopLoading();

  void handleLoading(bool loading, {String? message, bool showBookLoading = false}) {
    if (loading) {
      startLoading(message: message, showBookLoader: showBookLoading);
    } else {
      stopLoading();
    }
  }
}

class LoadingDialogHandler extends LoadingHandler {
  LoadingDialogHandler({required BuildContext context}) : _context = context;

  final BuildContext _context;
  Route? _dialogRoutes;

  Route _buildDialogRoute(BuildContext context) {
    assert(debugCheckHasCupertinoLocalizations(context));
    final CapturedThemes themes = InheritedTheme.capture(from: context, to: context.navigator.context);
    return DialogRoute(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      themes: themes,
      builder: (context) => PopScope(child: LoadingIndicator()),
    );
  }

  @override
  void startLoading({String? message, bool? showBookLoader}) {
    if (_dialogRoutes != null) return;
    _dialogRoutes = _buildDialogRoute(_context);
    _context.navigator.push(_dialogRoutes!);
  }

  @override
  void stopLoading() {
    if (_dialogRoutes != null && _context.mounted) _context.navigator.removeRoute(_dialogRoutes!);
    _dialogRoutes = null;
  }
}
