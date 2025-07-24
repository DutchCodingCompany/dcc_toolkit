import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter/material.dart';

/// A widget that displays a different widget based on the state of the pagination
///
/// [state] is the state of the pagination
/// [loadingWidget] is the widget to display when [state] is [PaginationState.isLoading]
/// [emptyWidget] is the widget to display when [state] is [PaginationState.items] is empty
/// [errorWidget] is the widget to display when [state] is [PaginationState.hasError]
/// [builder] is the builder for the actual success view (usually [PaginatedScrollView])
/// [onRefresh] is the refresh callback for [RefreshIndicator]
class PaginationStateView<T> extends StatelessWidget {
  /// Constructor
  const PaginationStateView({
    required this.state,
    required this.loadingWidget,
    required this.emptyWidget,
    required this.errorWidget,
    required this.builder,
    this.onRefresh,
    super.key,
  });

  /// The state of the pagination
  final PaginationState<T> state;

  /// Custom widget for [PaginationState.isLoading]
  final Widget loadingWidget;

  /// Custom widget for [PaginationState.items] is empty
  final Widget emptyWidget;

  /// Custom widget for [PaginationState.hasError]
  final Widget errorWidget;

  /// Builder for the actual success view (usually [PaginatedScrollView])
  final WidgetBuilder builder;

  /// Optional: refresh callback for [RefreshIndicator]
  final RefreshCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    // If there is a refresh callback and the state is not loading, enable the refresh indicator
    return onRefresh != null && !state.isLoading
        ? RefreshIndicator(
          onRefresh: onRefresh!,
          child: switch (state) {
            PaginationState(isLoading: true) => loadingWidget,
            PaginationState(hasError: true) => errorWidget,
            PaginationState(items: const []) => emptyWidget,
            PaginationState() => builder(context),
          },
        )
        : switch (state) {
          PaginationState(isLoading: true) => loadingWidget,
          PaginationState(hasError: true) => errorWidget,
          PaginationState(items: const []) => emptyWidget,
          PaginationState() => builder(context),
        };
  }
}
