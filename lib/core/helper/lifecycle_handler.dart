part of '../core.dart';

class LifecycleHandler extends StatefulWidget {
  final Widget child;
  final VoidCallback onStart;
  final VoidCallback onStop;

  const LifecycleHandler({super.key, required this.child, required this.onStart, required this.onStop});

  @override
  LifecycleHandlerState createState() => LifecycleHandlerState();
}

class LifecycleHandlerState extends State<LifecycleHandler> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      widget.onStop.call();
    }
    if (state == AppLifecycleState.resumed) {
      widget.onStart.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
