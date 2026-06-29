import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/components/loading_indicator.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:network/helper/pagination_helper/pagination_helper.dart';
import 'package:provider/provider.dart';

typedef PaginationRefreshCallback = Future<void> Function(BuildContext context);
typedef PaginationScrollToEnd = void Function(BuildContext context);

class PaginationListener extends StatelessWidget {
  const PaginationListener({
    super.key,
    required this.onRefresh,
    required this.onScrollToEnd,
    required this.child,
  });

  final PaginationRefreshCallback? onRefresh;
  final PaginationScrollToEnd onScrollToEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget child = this.child;
    child = NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >= notification.metrics.maxScrollExtent) {
          onScrollToEnd(context);
        }
        return false;
      },
      child: child,
    );
    if (onRefresh != null) {
      return RefreshIndicator.adaptive(
        onRefresh: () => onRefresh!.call(context),
        child: child,
      );
    }
    return child;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('child', child));
    properties.add(ObjectFlagProperty<PaginationRefreshCallback>.has('onRefresh', onRefresh));
    properties.add(ObjectFlagProperty<PaginationScrollToEnd>.has('onScrollToEnd', onScrollToEnd));
  }
}

class SliverLoadMoreIndicator extends StatelessWidget {
  const SliverLoadMoreIndicator({
    super.key,
    required this.loading,
    required this.reachAtEnd,
  });

  final bool loading;
  final bool reachAtEnd;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: reachAtEnd
          ? SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.symmetric(vertical: Spacing.normal),
              child: LoadingIndicator(),
            ),
    );
  }
}

class PaginatedListView<P extends PaginationProvider<T>, T extends Object> extends StatelessWidget {
  const PaginatedListView({
    super.key,
    this.separatorBuilder,
    required this.itemBuilder,
    required this.emptyViewBuilder,
    this.loadingBuilder,
    this.minimumPadding = EdgeInsets.zero,
  });

  final Widget? Function(BuildContext context, int index, T element) itemBuilder;
  final NullableIndexedWidgetBuilder? separatorBuilder;
  final WidgetBuilder emptyViewBuilder;
  final WidgetBuilder? loadingBuilder;
  final EdgeInsets minimumPadding;

  @override
  Widget build(BuildContext context) {
    return PaginationListener(
      onRefresh: (context) => context.read<P>().onRefresh(),
      onScrollToEnd: (context) => context.read<P>().onLoadMore(),
      child: Builder(
        builder: (context) {
          final list = context.select<P, List<T>>((value) => value.list);

          if (list.isEmpty) {
            bool isLoading = context.select<P, bool>((value) => value.loading);
            if (isLoading) {
              return Builder(builder: loadingBuilder ?? (context) => const LoadingIndicator());
            }

            return Builder(builder: emptyViewBuilder);
          }

          return CustomScrollView(
            slivers: [
              SliverSafeArea(
                top: false,
                bottom: false,
                minimum: minimumPadding.copyWith(bottom: 0),
                sliver: Builder(
                  builder: (context) {
                    if (separatorBuilder == null) {
                      return SliverList.builder(
                        itemBuilder: (context, index) => itemBuilder(context, index, list[index]),
                        itemCount: list.length,
                      );
                    } else {
                      return SliverList.separated(
                        itemBuilder: (context, index) => itemBuilder(context, index, list[index]),
                        separatorBuilder: separatorBuilder!,
                        itemCount: list.length,
                      );
                    }
                  },
                ),
              ),
              SliverSafeArea(
                top: false,
                bottom: false,
                minimum: minimumPadding.copyWith(bottom: 0, top: 0),
                sliver: Builder(
                  builder: (context) {
                    final data = context.select<P, ({bool loading, bool reachAtEnd})>((value) {
                      return (loading: value.loading, reachAtEnd: value.reachAtEnd);
                    });
                    return SliverLoadMoreIndicator(
                      loading: data.loading,
                      reachAtEnd: data.reachAtEnd,
                    );
                  },
                ),
              ),
              SliverGap(context.padding.bottom + minimumPadding.bottom),
            ],
          );
        },
      ),
    );
  }
}
