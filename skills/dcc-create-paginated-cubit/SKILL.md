---
name: dcc-create-paginated-cubit
description: Scaffold a paginated Cubit using PaginationMixin and PaginationState with PaginatedScrollView and PaginationStateView widgets. Use when adding pagination, implementing infinite scroll, loading more items on scroll, or creating a paginated list.
metadata:
  last_modified: 2025-06-18
---

# Create a Paginated Cubit

## Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Core Concepts](#core-concepts)
- [Workflow](#workflow)
- [Complete Example](#complete-example)
- [Common Patterns](#common-patterns)
- [Feedback Loop](#feedback-loop)

## Overview

The DCC pagination module provides a complete solution for paginated lists:

1. **`PaginationState<T>`** -- immutable state holding items, page info, loading/error flags
2. **`PaginationInterface<T>`** -- interface your Cubit state must implement
3. **`PaginationMixin<T, S>`** -- mixin on `Cubit<S>` that handles `loadNextPage()` logic
4. **`PaginatedScrollView<T>`** -- widget that detects scroll-to-bottom and triggers loading
5. **`PaginationStateView<T>`** -- widget that switches between loading/empty/error/success states

The mixin handles page advancement, item appending, and loading state automatically. You only implement `fetchPageItems()` and `initializeState()`.

## Prerequisites

```dart
// From the main barrel file
import 'package:dcc_toolkit/dcc_toolkit.dart';

// PaginationStateView is NOT exported from the barrel -- import directly
import 'package:dcc_toolkit/pagination/pagination_state_view.dart';
```

Dependencies required in the consuming project:
- `flutter_bloc` (for `Cubit`)
- `dcc_toolkit`

## Core Concepts

| Class/Mixin | Role |
|-------------|------|
| `PaginationState<T>` | Immutable state: `items`, `currentPage`, `lastPage`, `isLoading`, `loadingInitialPage`, `hasError`, `total`, `searchQuery`. Getter: `hasNextPage` |
| `PaginationInterface<T>` | Interface with single getter: `PaginationState<T> get paginationState` |
| `PaginationMixin<T, S>` | Mixin on `Cubit<S extends PaginationInterface<T>>`. Provides `loadNextPage()`. Requires implementing `fetchPageItems()` and `initializeState()` |
| `PaginatedScrollView<T>` | `CustomScrollView` with scroll detection. Props: `state`, `itemBuilder`, `onLoadMore`, `topWidget`, `bottomWidget` |
| `PaginationStateView<T>` | State-switching widget. Props: `state`, `loadingWidget`, `emptyWidget`, `errorWidget`, `builder`, `onRefresh` |

### PaginationState Fields

| Field | Type | Default | Purpose |
|-------|------|---------|---------|
| `items` | `List<T>` | `[]` | Accumulated items from all loaded pages |
| `currentPage` | `int` | `1` | Current loaded page number |
| `lastPage` | `int` | `1` | Total number of pages available |
| `isLoading` | `bool` | `false` | Whether the next page is currently loading |
| `loadingInitialPage` | `bool` | `true` | Whether the first page is loading |
| `hasError` | `bool` | `false` | Whether an error occurred |
| `total` | `int` | `0` | Total item count from the API |
| `searchQuery` | `String?` | `null` | Active search filter |

### How `loadNextPage()` Works

The mixin's `loadNextPage(emitState)` method:
1. Checks `currentPage < lastPage` -- if not, does nothing
2. Sets `isLoading: true` via the `emitState` callback
3. Calls your `fetchPageItems(page: nextPage, searchQuery: ...)`
4. If items returned are non-empty, appends them to existing items, advances `currentPage`, sets `isLoading: false`

**Important**: `loadNextPage()` takes an `emitState` callback (not `emit()` directly) because it updates the pagination sub-state, not the full Cubit state. You must bridge this to your actual `emit()`.

## Workflow

**Task Progress:**
- [ ] 1. Create Cubit state class implementing `PaginationInterface<T>`
- [ ] 2. Create Cubit with `PaginationMixin<T, State>`
- [ ] 3. Implement `fetchPageItems()` to call the repository/API
- [ ] 4. Implement `initializeState()` to load the first page
- [ ] 5. Build UI with `PaginationStateView` and `PaginatedScrollView`
- [ ] 6. Wire `onLoadMore` to the Cubit's `loadNextPage()`
- [ ] 7. Verify with `dart analyze` and tests

### Step 1: Create State Class

Your Cubit state must implement `PaginationInterface<T>`:

```dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter/foundation.dart';

@immutable
class ProductListState implements PaginationInterface<Product> {
  const ProductListState({
    this.paginationState = const PaginationState(),
  });

  @override
  final PaginationState<Product> paginationState;

  ProductListState copyWith({
    PaginationState<Product>? paginationState,
  }) {
    return ProductListState(
      paginationState: paginationState ?? this.paginationState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductListState && other.paginationState == paginationState;

  @override
  int get hashCode => paginationState.hashCode;
}
```

### Step 2: Create Cubit with PaginationMixin

```dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListCubit extends Cubit<ProductListState>
    with PaginationMixin<Product, ProductListState> {
  ProductListCubit(this._repository) : super(const ProductListState());

  final ProductRepository _repository;

  @override
  Future<List<Product>?> fetchPageItems({
    required int page,
    String? searchQuery,
  }) async {
    final result = await _repository.getProducts(page: page, query: searchQuery);
    return result.when(
      success: (response) => response.items,
      error: (_) => null, // Return null to signal failure
    );
  }

  @override
  Future<void> initializeState({String? searchQuery}) async {
    emit(state.copyWith(
      paginationState: const PaginationState(loadingInitialPage: true),
    ));

    final result = await _repository.getProducts(page: 1, query: searchQuery);
    result.when(
      success: (response) {
        emit(state.copyWith(
          paginationState: PaginationState(
            items: response.items,
            currentPage: 1,
            lastPage: response.lastPage,
            total: response.total,
            loadingInitialPage: false,
            searchQuery: searchQuery,
          ),
        ));
      },
      error: (_) {
        emit(state.copyWith(
          paginationState: const PaginationState(
            hasError: true,
            loadingInitialPage: false,
          ),
        ));
      },
    );
  }

  void onLoadMore() {
    loadNextPage((paginationState) {
      emit(state.copyWith(paginationState: paginationState));
    });
  }

  void search(String query) {
    initializeState(searchQuery: query);
  }
}
```

### Step 3: Build the UI

```dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/pagination/pagination_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListCubit(context.read<ProductRepository>())
        ..initializeState(),
      child: const _ProductListView(),
    );
  }
}

class _ProductListView extends StatelessWidget {
  const _ProductListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          return PaginationStateView<Product>(
            state: state.paginationState,
            loadingWidget: const Center(child: CircularProgressIndicator()),
            emptyWidget: const Center(child: Text('No products found')),
            errorWidget: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Something went wrong'),
                  ElevatedButton(
                    onPressed: () => context.read<ProductListCubit>().initializeState(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            onRefresh: () => context.read<ProductListCubit>().initializeState(),
            builder: (context) => PaginatedScrollView<Product>(
              state: state.paginationState,
              onLoadMore: () => context.read<ProductListCubit>().onLoadMore(),
              itemBuilder: (context, product) => ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
              ),
            ),
          );
        },
      ),
    );
  }
}
```

## Complete Example

Full feature from state to UI:

```dart
// product_list_state.dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter/foundation.dart';

@immutable
class ProductListState implements PaginationInterface<Product> {
  const ProductListState({
    this.paginationState = const PaginationState(),
  });

  @override
  final PaginationState<Product> paginationState;

  ProductListState copyWith({PaginationState<Product>? paginationState}) =>
      ProductListState(paginationState: paginationState ?? this.paginationState);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductListState && other.paginationState == paginationState;

  @override
  int get hashCode => paginationState.hashCode;
}
```

```dart
// product_list_cubit.dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListCubit extends Cubit<ProductListState>
    with PaginationMixin<Product, ProductListState> {
  ProductListCubit(this._repository) : super(const ProductListState());

  final ProductRepository _repository;

  @override
  Future<List<Product>?> fetchPageItems({
    required int page,
    String? searchQuery,
  }) async {
    final result = await _repository.getProducts(page: page, query: searchQuery);
    return result.getOrNull?.items;
  }

  @override
  Future<void> initializeState({String? searchQuery}) async {
    emit(state.copyWith(
      paginationState: const PaginationState(loadingInitialPage: true),
    ));

    final result = await _repository.getProducts(page: 1, query: searchQuery);
    result.when(
      success: (response) => emit(state.copyWith(
        paginationState: PaginationState(
          items: response.items,
          currentPage: 1,
          lastPage: response.lastPage,
          total: response.total,
          loadingInitialPage: false,
          searchQuery: searchQuery,
        ),
      )),
      error: (_) => emit(state.copyWith(
        paginationState: const PaginationState(hasError: true, loadingInitialPage: false),
      )),
    );
  }

  void onLoadMore() {
    loadNextPage((paginationState) {
      emit(state.copyWith(paginationState: paginationState));
    });
  }
}
```

```dart
// product_list_page.dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/pagination/pagination_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductListCubit(context.read<ProductRepository>())..initializeState(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: BlocBuilder<ProductListCubit, ProductListState>(
          builder: (context, state) => PaginationStateView<Product>(
            state: state.paginationState,
            loadingWidget: const Center(child: CircularProgressIndicator()),
            emptyWidget: const Center(child: Text('No products found')),
            errorWidget: const Center(child: Text('Error loading products')),
            onRefresh: () => context.read<ProductListCubit>().initializeState(),
            builder: (context) => PaginatedScrollView<Product>(
              state: state.paginationState,
              onLoadMore: () => context.read<ProductListCubit>().onLoadMore(),
              itemBuilder: (context, product) => ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price}'),
                leading: CircleAvatar(child: Text(product.name[0])),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

## Common Patterns

### Adding Search to Pagination

Use `searchQuery` in `PaginationState` and re-initialize when the query changes:

```dart
// In your Cubit:
void search(String query) {
  initializeState(searchQuery: query.isEmpty ? null : query);
}

// The searchQuery is automatically passed to fetchPageItems() by loadNextPage()
```

Debounce search input using the toolkit's `Debouncer`:

```dart
import 'package:dcc_toolkit/debouncer/debouncer.dart';

class ProductListCubit extends Cubit<ProductListState>
    with PaginationMixin<Product, ProductListState> {
  ProductListCubit(this._repository) : super(const ProductListState());

  final ProductRepository _repository;
  final _debouncer = Debouncer(); // 400ms default

  void onSearchChanged(String query) {
    _debouncer.run(() => initializeState(searchQuery: query.isEmpty ? null : query));
  }

  @override
  Future<void> close() {
    _debouncer.dispose();
    return super.close();
  }
  // ... rest of implementation
}
```

### Adding a Top or Bottom Widget to PaginatedScrollView

```dart
PaginatedScrollView<Product>(
  state: state.paginationState,
  onLoadMore: () => cubit.onLoadMore(),
  topWidget: Padding(
    padding: Paddings.all16,
    child: Text('${state.paginationState.total} products'),
  ),
  bottomWidget: const SizedBox(height: 80), // Extra space above FAB
  itemBuilder: (context, product) => ProductTile(product: product),
)
```

### Using PaginationState with Freezed

If your state uses `freezed`, implement `PaginationInterface` on the generated class:

```dart
@freezed
sealed class ProductListState with _$ProductListState implements PaginationInterface<Product> {
  const factory ProductListState({
    @Default(PaginationState()) PaginationState<Product> paginationState,
  }) = _ProductListState;
}
```

### Scroll Detection Behavior

`PaginatedScrollView` triggers `onLoadMore` when:
- `metrics.extentAfter == metrics.minScrollExtent` (user reached the bottom)
- `state.hasNextPage` is `true`
- `state.isLoading` is `false`

It automatically shows a `CircularProgressIndicator` at the bottom when `hasNextPage` is true.

## Feedback Loop

After implementing:

1. Run `dart analyze` -- ensure no lint errors.
2. Run `flutter test` -- verify pagination logic with unit tests:
   - Test `loadNextPage()` appends items and advances page
   - Test `loadNextPage()` does nothing when `currentPage >= lastPage`
   - Test `initializeState()` resets state and loads first page
3. Run the app -- verify:
   - Initial loading state appears
   - Items render after first page loads
   - Scrolling to bottom triggers next page load
   - Progress indicator appears while loading next page
   - Pull-to-refresh works (if `onRefresh` is set)
   - Empty and error states display correctly
