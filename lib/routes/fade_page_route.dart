part of 'routes.dart';

class FadePageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  FadePageRoute({required this.builder, required RouteSettings settings}) : super(settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // if (Platform.isIOS) {
    //   // Default iOS transition
    //   return CupertinoPageTransitionsBuilder().buildTransitions(
    //     this, // Reference to the current route
    //     context,
    //     animation,
    //     secondaryAnimation,
    //     child,
    //   );
    // }

    // Fade transition for other platforms
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
