import 'package:flutter/foundation.dart';

/// State for pagination.
@immutable
class PaginationState<T> {
  /// Creates a new [PaginationState] with the given values.
  const PaginationState({
    this.items = const [],
    this.currentPage = 1,
    this.lastPage = 1,
    this.isLoading = false,
    this.loadingInitialPage = true,
    this.hasError = false,
    this.total = 0,
    this.searchQuery,
  });

  /// All items fetched so far for the loaded pages.
  final List<T> items;

  /// The current page in the pagination process.
  final int currentPage;

  /// The last page in the pagination process.
  final int lastPage;

  /// Whether the current page is being loaded.
  final bool isLoading;

  /// Whether the initial page is being loaded.
  final bool loadingInitialPage;

  /// Whether there is an error loading the current page.
  final bool hasError;

  /// The total number of items.
  final int total;

  /// The search query to filter the items.
  final String? searchQuery;

  /// Checks if there is a next page to load for the current [PaginationState].
  bool get hasNextPage => currentPage < lastPage;

  /// Copies the current state with the given values.
  PaginationState<T> copyWith({
    List<T>? items,
    int? currentPage,
    int? lastPage,
    bool? isLoading,
    bool? loadingInitialPage,
    bool? hasError,
    int? total,
    String? searchQuery,
  }) {
    return PaginationState<T>(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      isLoading: isLoading ?? this.isLoading,
      loadingInitialPage: loadingInitialPage ?? this.loadingInitialPage,
      hasError: hasError ?? this.hasError,
      total: total ?? this.total,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaginationState<T> &&
        listEquals(other.items, items) &&
        other.currentPage == currentPage &&
        other.lastPage == lastPage &&
        other.isLoading == isLoading &&
        other.loadingInitialPage == loadingInitialPage &&
        other.hasError == hasError &&
        other.total == total &&
        other.searchQuery == searchQuery;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      Object.hashAll(items),
      currentPage,
      lastPage,
      isLoading,
      loadingInitialPage,
      hasError,
      total,
      searchQuery,
    ]);
  }
}
