import 'dart:async';
import 'dart:ui';

const _debounceTime = Duration(milliseconds: 400);

/// A debouncer is a utility class that allows you to debounce a function call.
/// It is useful to prevent a function from being called too frequently.
/// For example, if you have a function that is called when the user types in a search box,
/// you can use a debouncer to prevent the function from being called too frequently.
/// This is useful to prevent the server from being overwhelmed by too many requests.
///
/// Example:
/// ```dart
/// class SearchCubit extends Cubit<SearchState> {
///   SearchCubit() : super(const SearchState());
///
///   late final Debouncer _debouncer = Debouncer();
///
///   void debouncedSearch(String searchQuery) {
///     _debouncer.run(() => emit(state.copyWith(searchQuery: searchQuery.trim())));
///   }
///
///   @override
///   Future<void> close() {
///     _debouncer.dispose();
///     return super.close();
///   }
// }
/// ```
class Debouncer {
  /// Creates a new [Debouncer] with the given delay.
  /// If no delay is provided, the default delay of 400 milliseconds is used.
  Debouncer({Duration? delay}) : delay = delay ?? _debounceTime;

  Timer? _timer;

  /// The delay for the debouncer.
  final Duration delay;

  /// Runs the given action after the delay.
  void run(VoidCallback action) {
    _timer?.cancel();

    _timer = Timer(delay, action);
  }

  /// Disposes the debouncer.
  void dispose() {
    _timer?.cancel();
  }
}
