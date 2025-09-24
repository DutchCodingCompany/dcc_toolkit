import 'package:dcc_toolkit/pagination/pagination_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaginationState', () {
    group('hasNextPage', () {
      test('returns true when current page is less than last page', () {
        const state = PaginationState<String>(currentPage: 2, lastPage: 5);

        expect(state.hasNextPage, true);
      });

      test('returns false when current page equals last page', () {
        const state = PaginationState<String>(currentPage: 5, lastPage: 5);

        expect(state.hasNextPage, false);
      });

      test('returns false when current page is greater than last page', () {
        const state = PaginationState<String>(currentPage: 6, lastPage: 5);

        expect(state.hasNextPage, false);
      });
    });

    group('equality', () {
      test('returns true for identical instances', () {
        const state = PaginationState<String>();

        expect(state == state, true);
        expect(state.hashCode == state.hashCode, true);
      });

      test('returns true for instances with same values', () {
        const items = ['item1', 'item2'];
        const state1 = PaginationState<String>(
          items: items,
          currentPage: 2,
          lastPage: 5,
          isLoading: true,
          loadingInitialPage: false,
          hasError: true,
          total: 50,
          searchQuery: 'test',
        );
        const state2 = PaginationState<String>(
          items: items,
          currentPage: 2,
          lastPage: 5,
          isLoading: true,
          loadingInitialPage: false,
          hasError: true,
          total: 50,
          searchQuery: 'test',
        );

        expect(state1 == state2, true);
        expect(state1.hashCode == state2.hashCode, true);
      });

      test('returns false for instances with different items', () {
        const state1 = PaginationState<String>(items: ['item1']);
        const state2 = PaginationState<String>(items: ['item2']);

        expect(state1 == state2, false);
        expect(state1.hashCode == state2.hashCode, false);
      });

      test('returns false for instances with different currentPage', () {
        const state1 = PaginationState<String>();
        const state2 = PaginationState<String>(currentPage: 2);

        expect(state1 == state2, false);
        expect(state1.hashCode == state2.hashCode, false);
      });

      test('returns false for instances with different lastPage', () {
        const state1 = PaginationState<String>(lastPage: 3);
        const state2 = PaginationState<String>(lastPage: 5);

        expect(state1 == state2, false);
        expect(state1.hashCode == state2.hashCode, false);
      });

      test('returns false for instances with different isLoading', () {
        const state1 = PaginationState<String>(isLoading: true);
        const state2 = PaginationState<String>();

        expect(state1 == state2, false);
        expect(state1.hashCode == state2.hashCode, false);
      });

      test('returns false for instances with different loadingInitialPage', () {
        const state1 = PaginationState<String>();
        const state2 = PaginationState<String>(loadingInitialPage: false);

        expect(state1 == state2, false);
        expect(state1.hashCode == state2.hashCode, false);
      });

      test('returns false for instances with different hasError', () {
        const state1 = PaginationState<String>(hasError: true);
        const state2 = PaginationState<String>();

        expect(state1 == state2, false);
        expect(state1.hashCode == state2.hashCode, false);
      });

      test('returns false for instances with different generic types', () {
        const stringState = PaginationState<String>();
        const intState = PaginationState<int>();

        expect(stringState.runtimeType == intState.runtimeType, false);
      });
    });
  });
}
