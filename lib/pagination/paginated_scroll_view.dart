import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter/material.dart';

/// A widget that displays a list of items with pagination.
///
/// This widget is a [CustomScrollView] that displays a paginated list of items.
/// It uses a [PaginationState] to manage the behavior of the widget.
/// It also uses a [NotificationListener] to listen for scroll events and load more items when the user scrolls to the bottom of the list.
class PaginatedScrollView<T> extends StatelessWidget {
  /// Creates a new [PaginatedScrollView].
  const PaginatedScrollView({
    required this.state,
    required this.itemBuilder,
    this.onLoadMore,
    this.topWidget,
    this.bottomWidget,
    super.key,
  });

  /// The state of the pagination.
  final PaginationState<T> state;

  /// The builder for the items.
  final Widget Function(BuildContext, T) itemBuilder;

  /// The function to call when the user scrolls to the bottom of the list, to load more items.
  final void Function()? onLoadMore;

  /// Optional widget to display at the top of the list.
  final Widget? topWidget;

  /// Optional widget to display at the bottom of the list.
  final Widget? bottomWidget;

  int get _itemCount => state.items.length;

  T _fetchItem(int index) {
    return state.items[index];
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification:
          onLoadMore != null
              ? (notification) {
                final metrics = notification.metrics;
                if (metrics.extentAfter == metrics.minScrollExtent) {
                  // We don't trigger loading if no next page is available or while we are already fetching more
                  if (state.hasNextPage && !state.isLoading) {
                    onLoadMore?.call();
                    return true;
                  }
                }
                return false;
              }
              : null,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (topWidget != null) SliverToBoxAdapter(child: topWidget),
          SliverList.builder(
            itemCount: _itemCount,
            itemBuilder: (context, index) => itemBuilder(context, _fetchItem(index)),
          ),
          if (state.hasNextPage)
            const SliverToBoxAdapter(
              child: Padding(padding: EdgeInsets.all(Sizes.px16), child: Center(child: CircularProgressIndicator())),
            ),
          if (bottomWidget != null) SliverToBoxAdapter(child: bottomWidget),
          //Bottom insets to be able to scroll the entire content above the FloatingActionButton
          const SliverPadding(padding: Paddings.vertical48),
        ],
      ),
    );
  }
}
