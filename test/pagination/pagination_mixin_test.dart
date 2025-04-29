// Ignored because its more descriptive to specify the arguments in the test.
// Immutable warning is ignored for testing purposes.
//ignore_for_file: avoid_redundant_argument_values, avoid_equals_and_hash_code_on_mutable_classes
import 'package:dcc_toolkit/pagination/pagination_interface.dart';
import 'package:dcc_toolkit/pagination/pagination_mixin.dart';
import 'package:dcc_toolkit/pagination/pagination_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group('pagination_state tests', () {
    parameterizedTest(
      'hasNextPage',
      [
        [1, 1, false],
        [2, 2, false],
        [2, 1, false],
        [1, -1, false],
        [-1, 1, true],
        [1, 2, true],
      ],
      (int currentPage, int lastPage, bool expected) =>
          expect(PaginationState<int>(items: [], currentPage: currentPage, lastPage: lastPage).hasNextPage, expected),
    );
  });

  group('PaginationMixin tests', () {
    late _TestCubit cubit;

    setUp(() {
      cubit = _TestCubit();
    });

    test('loadNextPage emits new state with next page items when current page is less than last page', () async {
      const paginationState = PaginationState<int>(items: [1, 2, 3], currentPage: 1, lastPage: 3);
      cubit.emit(_TestState(paginationState));

      final nextPaginationStates = <PaginationState<int>?>[];
      await cubit.loadNextPage(nextPaginationStates.add);

      expect(nextPaginationStates.first!.isLoading, isTrue);
      expect(nextPaginationStates.length, 2);
      expect(nextPaginationStates.last!.items, equals([1, 2, 3, 1, 2, 3]));
      expect(nextPaginationStates.last!.currentPage, equals(2));
      expect(nextPaginationStates.last!.isLoading, isFalse);
    });

    test('loadNextPage does not emit new state when current page is equal to last page', () async {
      const paginationState = PaginationState<int>(items: [1, 2, 3], currentPage: 3, lastPage: 3);
      cubit.emit(_TestState(paginationState));

      final nextPaginationStates = <PaginationState<int>?>[];
      await cubit.loadNextPage(nextPaginationStates.add);

      expect(nextPaginationStates, isEmpty);
    });

    test('loadNextPage does not emit new state when next page items are empty', () async {
      const paginationState = PaginationState<int>(items: [1, 2, 3], currentPage: 1, lastPage: 3);
      cubit
        ..emit(_TestState(paginationState))
        ..returnPages = [];

      final nextPaginationStates = <PaginationState<int>?>[];
      await cubit.loadNextPage(nextPaginationStates.add);

      expect(nextPaginationStates.first!.isLoading, isTrue);
      expect(nextPaginationStates.length, 1);
    });
  });
}

class _TestState implements PaginationInterface<int> {
  _TestState(this.paginationState);

  @override
  final PaginationState<int> paginationState;

  @override
  int get hashCode => paginationState.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _TestState && other.paginationState == paginationState;
  }
}

class _TestCubit extends Cubit<_TestState> with PaginationMixin<int, _TestState> {
  _TestCubit() : super(_TestState(const PaginationState()));

  List<int> returnPages = [1, 2, 3];

  @override
  Future<List<int>?> fetchPageItems({required int page, String? searchQuery}) async => returnPages;

  @override
  Future<void> initializeState({String? searchQuery}) async {}
}
