import 'package:dcc_toolkit/pagination/pagination_interface.dart';
import 'package:dcc_toolkit/pagination/pagination_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Mixin for pagination.
///
/// This mixin is used to handle pagination in a bloc.
/// It provides a method to fetch the items for a given page and a method to initialize the pagination state.
/// It also provides a method to load the next page.
///
/// Example:
/// ```dart
/// class MyBloc extends Bloc<MyEvent, MyState> with PaginationMixin<MyItem, MyState> {
///   @override
///   Future<List<MyItem>?> fetchPageItems(int page, String? searchQuery) async {
///     // Fetch items logic
///   }
///
///   @override
///   Future<void> initializeState({String? searchQuery}) async {
///     // Initialize state logic
///   }
///
///   @override
///   Future<void> loadNextPage(void Function(PaginationState<T>) emitState) async {
///     // Load next page logic
///   }
/// }
/// ```
mixin PaginationMixin<T, S extends PaginationInterface<T>> on Cubit<S> {
  /// Fetches the items for the given page
  Future<List<T>?> fetchPageItems({required int page, String? searchQuery});

  /// Initializes the pagination state
  Future<void> initializeState({String? searchQuery});

  /// Loads the next page
  Future<void> loadNextPage(void Function(PaginationState<T>) emitState) async {
    final paginationState = state.paginationState;
    if (paginationState.currentPage < paginationState.lastPage) {
      emitState(paginationState.copyWith(isLoading: true));
      final nextPage = paginationState.currentPage + 1;
      final nextItems = await fetchPageItems(page: nextPage, searchQuery: paginationState.searchQuery);
      if (nextItems?.isNotEmpty ?? false) {
        emitState(
          paginationState.copyWith(
            items: [...paginationState.items, ...nextItems!],
            currentPage: nextPage,
            isLoading: false,
          ),
        );
      }
    }
  }
}
