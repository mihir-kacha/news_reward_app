part of '../core.dart';

base mixin SubscriptionHelper on BaseProvider {
  @visibleForTesting
  @protected
  final List<StreamSubscription> subscriptions = [];

  @override
  void dispose() {
    debugPrint("DISPOSE STREAM :: :::");

    cancelAllSubscriptions();
    super.dispose();
  }

  @protected
  void cancelAllSubscriptions() {
    if (subscriptions.isNotEmpty) {
      for (final subscription in subscriptions) {
        subscription.cancel();
      }
    }
  }
}
