import 'package:dcc_toolkit/pagination/pagination_state.dart';

/// Interface for pagination which is used on your bloc state.
abstract interface class PaginationInterface<T> {
  /// The current pagination state.
  PaginationState<T> get paginationState;
}
