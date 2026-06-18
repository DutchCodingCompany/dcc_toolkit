---
name: dcc-create-blocful-page
description: Create a full page using BlocfulWidget with BlocPresentationMixin for one-shot events, Cubit state management, and native dialogs. Use when creating a new screen with BLoC, adding presentation events, wiring up a Cubit to a page, or showing platform-adaptive dialogs.
metadata:
  last_modified: 2025-06-18
---

# Create a BlocfulWidget Page

## Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Core Concepts](#core-concepts)
- [Workflow](#workflow)
- [Complete Example](#complete-example)
- [Common Patterns](#common-patterns)
- [Feedback Loop](#feedback-loop)

## Overview

`BlocfulWidget` is the DCC toolkit's opinionated page widget that combines three BLoC concepts into one class:

1. **BlocProvider** -- optionally creates and provides the Cubit
2. **BlocPresentationListener** -- listens for one-shot "presentation events" (snackbars, navigation, dialogs)
3. **BlocConsumer** -- rebuilds UI on state changes + provides a listener for side effects

This eliminates the boilerplate of nesting `BlocProvider` > `BlocPresentationListener` > `BlocConsumer` manually.

Additionally, the toolkit provides `showNativeDialog()` for platform-adaptive dialogs (Cupertino on iOS, Material on Android).

## Prerequisites

```dart
import 'package:dcc_toolkit/dcc_toolkit.dart'; // BlocfulWidget, showNativeDialog, DialogAction
```

Dependencies required in the consuming project:
- `flutter_bloc` (for `Cubit`, `BlocPresentationMixin`)
- `bloc_presentation` (for `BlocPresentationMixin`, `emitPresentation()`)
- `dcc_toolkit`

Optional but common:
- `freezed_annotation` + `freezed` (for state classes)
- `injectable` (for DI)

## Core Concepts

| Class | Role |
|-------|------|
| `BlocfulWidget<BLOC, STATE, EVENT>` | Abstract `StatelessWidget`. Combines `BlocProvider` + `BlocPresentationListener` + `BlocConsumer` |
| `BlocPresentationMixin<STATE, EVENT>` | Mixin from `bloc_presentation`. Adds `emitPresentation(event)` for one-shot events |
| `showNativeDialog<T>()` | Shows `CupertinoAlertDialog` on iOS, `AlertDialog` on Android. Auto-closes after action tap |
| `DialogAction<T>` | Action for native dialog: `text`, `onTap` (returns `FutureOr<T?>`), `isDestructiveAction`, `textStyle` |

### BlocfulWidget API

| Method | Purpose | Required |
|--------|---------|----------|
| `builder(context, bloc, state)` | Build the page UI. Called on every state change | Yes |
| `onPresentationEvent(context, event)` | Handle one-shot events (show snackbar, navigate, show dialog) | No (default is no-op) |
| `listener(context, bloc, state)` | BlocConsumer listener for state-based side effects | No (default is no-op) |

### Constructor Parameter

| Parameter | Purpose |
|-----------|---------|
| `onCreateBloc` | `BLOC Function(BuildContext)?`. If provided, wraps the widget in `BlocProvider`. If null, expects the Bloc to already exist in the widget tree |

### Presentation Events vs State

| Concept | Use For | Delivery |
|---------|---------|----------|
| **State** (emit) | UI that should rebuild: loading indicators, data display, form fields | Persistent -- last emitted state is always available |
| **Presentation Events** (emitPresentation) | One-shot side effects: show snackbar, navigate, show dialog, trigger animation | Fire-and-forget -- only delivered once to active listeners |

## Workflow

**Task Progress:**
- [ ] 1. Create presentation event class(es)
- [ ] 2. Create Cubit state (with freezed or manual)
- [ ] 3. Create Cubit with `BlocPresentationMixin`
- [ ] 4. Create page extending `BlocfulWidget`
- [ ] 5. Override `builder()` for UI
- [ ] 6. Override `onPresentationEvent()` for one-shot actions
- [ ] 7. (Optional) Add `showNativeDialog()` for confirmations
- [ ] 8. Verify with `dart analyze`

### Step 1: Create Presentation Events

Define a sealed class hierarchy for events:

```dart
// user_event.dart
sealed class UserEvent {
  String get message;
}

class UserLoaded implements UserEvent {
  const UserLoaded();

  @override
  String get message => 'User loaded successfully';
}

class UserSaveFailed implements UserEvent {
  const UserSaveFailed(this.reason);

  final String reason;

  @override
  String get message => 'Save failed: $reason';
}

class NavigateToProfile implements UserEvent {
  const NavigateToProfile(this.userId);

  final String userId;

  @override
  String get message => '';
}
```

### Step 2: Create Cubit State

Using freezed (recommended):

```dart
// user_state.dart
part of 'user_cubit.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState({
    User? user,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
  }) = _UserState;
}
```

Or manually:

```dart
import 'package:flutter/foundation.dart';

@immutable
class UserState {
  const UserState({this.user, this.isLoading = false, this.hasError = false});

  final User? user;
  final bool isLoading;
  final bool hasError;

  UserState copyWith({User? user, bool? isLoading, bool? hasError}) => UserState(
    user: user ?? this.user,
    isLoading: isLoading ?? this.isLoading,
    hasError: hasError ?? this.hasError,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          other.user == user &&
          other.isLoading == isLoading &&
          other.hasError == hasError;

  @override
  int get hashCode => Object.hash(user, isLoading, hasError);
}
```

### Step 3: Create Cubit with BlocPresentationMixin

```dart
// user_cubit.dart
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_cubit.freezed.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState>
    with BlocPresentationMixin<UserState, UserEvent> {
  UserCubit(this._repository) : super(const UserState());

  final UserRepository _repository;

  Future<void> loadUser(String id) async {
    emit(state.copyWith(isLoading: true));

    final result = await _repository.getUser(id);
    result.when(
      success: (user) {
        emit(state.copyWith(user: user, isLoading: false));
        emitPresentation(const UserLoaded());
      },
      error: (error) {
        emit(state.copyWith(hasError: true, isLoading: false));
        emitPresentation(UserSaveFailed(error.toString()));
      },
    );
  }

  Future<void> deleteUser() async {
    final result = await _repository.deleteUser(state.user!.id);
    result.when(
      success: (_) => emitPresentation(NavigateToProfile(state.user!.id)),
      error: (error) => emitPresentation(UserSaveFailed(error.toString())),
    );
  }
}
```

### Step 4: Create the Page with BlocfulWidget

```dart
// user_page.dart
import 'package:dcc_toolkit/ui/blocful_widget.dart';
import 'package:flutter/material.dart';

class UserPage extends BlocfulWidget<UserCubit, UserState, UserEvent> {
  const UserPage({required this.onCreateCubit, super.key})
    : super(onCreateBloc: onCreateCubit);

  final UserCubit Function(BuildContext)? onCreateCubit;

  @override
  void onPresentationEvent(BuildContext context, UserEvent event) {
    switch (event) {
      case UserLoaded():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(event.message)),
        );
      case UserSaveFailed():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(event.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      case NavigateToProfile(:final userId):
        Navigator.of(context).pop(userId);
    }
  }

  @override
  Widget builder(BuildContext context, UserCubit bloc, UserState state) {
    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(state.user?.name ?? 'User')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.user?.email ?? ''),
            Text(state.user?.phone ?? ''),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _confirmDelete(context, bloc),
              child: const Text('Delete User'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, UserCubit bloc) {
    showNativeDialog(
      context,
      title: 'Delete User',
      content: 'Are you sure you want to delete this user? This action cannot be undone.',
      actions: [
        DialogAction(
          text: 'Cancel',
          onTap: () {},
        ),
        DialogAction(
          text: 'Delete',
          onTap: () => bloc.deleteUser(),
          isDestructiveAction: true,
          textStyle: const TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
```

### Step 5: Navigate to the Page

```dart
// From another widget:
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => UserPage(
      onCreateCubit: (context) => getIt<UserCubit>()..loadUser('123'),
    ),
  ),
);
```

Or if the Cubit is already provided higher in the tree:

```dart
// No onCreateBloc needed -- Cubit already exists in widget tree
class UserDetailPage extends BlocfulWidget<UserCubit, UserState, UserEvent> {
  const UserDetailPage({super.key}) : super(onCreateBloc: null);

  @override
  Widget builder(BuildContext context, UserCubit bloc, UserState state) {
    return Text(state.user?.name ?? '');
  }
}
```

## Complete Example

A full feature with Cubit, events, state, and page:

```dart
// feature/profile/presentation/cubit/profile_event.dart
sealed class ProfileEvent {
  String get message;
}

class ProfileLoaded implements ProfileEvent {
  const ProfileLoaded();
  @override
  String get message => 'Profile loaded';
}

class ProfileUpdateSuccess implements ProfileEvent {
  const ProfileUpdateSuccess();
  @override
  String get message => 'Profile updated successfully';
}

class ProfileError implements ProfileEvent {
  const ProfileError(this.error);
  final String error;
  @override
  String get message => error;
}
```

```dart
// feature/profile/presentation/cubit/profile_cubit.dart
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState>
    with BlocPresentationMixin<ProfileState, ProfileEvent> {
  ProfileCubit(this._repository) : super(const ProfileState());

  final ProfileRepository _repository;

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true));
    final result = await _repository.getProfile();
    result.when(
      success: (profile) {
        emit(state.copyWith(profile: profile, isLoading: false));
        emitPresentation(const ProfileLoaded());
      },
      error: (error) {
        emit(state.copyWith(isLoading: false));
        emitPresentation(ProfileError(error.toString()));
      },
    );
  }

  Future<void> updateName(String name) async {
    final result = await _repository.updateProfile(name: name);
    result.when(
      success: (profile) {
        emit(state.copyWith(profile: profile));
        emitPresentation(const ProfileUpdateSuccess());
      },
      error: (error) => emitPresentation(ProfileError(error.toString())),
    );
  }
}
```

```dart
// feature/profile/presentation/cubit/profile_state.dart
part of 'profile_cubit.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState({
    Profile? profile,
    @Default(false) bool isLoading,
  }) = _ProfileState;
}
```

```dart
// feature/profile/presentation/profile_page.dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/ui/blocful_widget.dart';
import 'package:dcc_toolkit/ui/native_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends BlocfulWidget<ProfileCubit, ProfileState, ProfileEvent> {
  const ProfilePage({super.key})
    : super(onCreateBloc: _createCubit);

  static ProfileCubit _createCubit(BuildContext context) =>
      context.read<ProfileCubit>()..loadProfile();

  @override
  void onPresentationEvent(BuildContext context, ProfileEvent event) {
    switch (event) {
      case ProfileLoaded():
        // No action needed for initial load
        break;
      case ProfileUpdateSuccess():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(event.message)),
        );
      case ProfileError(:final error):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: context.colors.error,
          ),
        );
    }
  }

  @override
  Widget builder(BuildContext context, ProfileCubit bloc, ProfileState state) {
    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final profile = state.profile;
    if (profile == null) {
      return const Scaffold(body: Center(child: Text('No profile data')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: Paddings.all16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(profile.name, style: context.katjasBoekwerk.titleLarge),
            Margins.vertical8,
            Text(profile.email, style: context.katjasBoekwerk.bodyMedium),
            Margins.vertical24,
            ElevatedButton(
              onPressed: () => _showEditDialog(context, bloc, profile),
              child: const Text('Edit Name'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, ProfileCubit bloc, Profile profile) {
    final controller = TextEditingController(text: profile.name);

    showNativeDialog<void>(
      context,
      title: 'Edit Name',
      content: 'Enter a new name:',
      actions: [
        DialogAction(text: 'Cancel', onTap: () {}),
        DialogAction(
          text: 'Save',
          onTap: () => bloc.updateName(controller.text),
        ),
      ],
    );
  }
}
```

## Common Patterns

### showNativeDialog with Return Values

`showNativeDialog<T>` returns `Future<T?>`, so you can get results from dialog actions:

```dart
final confirmed = await showNativeDialog<bool>(
  context,
  title: 'Confirm',
  content: 'Proceed with payment?',
  actions: [
    DialogAction(text: 'No', onTap: () => false),
    DialogAction(text: 'Yes', onTap: () => true),
  ],
);

if (confirmed == true) {
  bloc.processPayment();
}
```

### Testing Presentation Events

Use the toolkit's `catchEventIn()` helper:

```dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emits UserLoaded on successful fetch', () async {
    final cubit = UserCubit(mockRepository);
    final events = <UserEvent>[];
    catchEventIn(cubit, events);

    await cubit.loadUser('123');

    expect(events, contains(isA<UserLoaded>()));
  });
}
```

### Combining BlocfulWidget with BlocfulWidget (Nested Blocs)

If a page needs multiple Cubits, nest `BlocProvider`s above the `BlocfulWidget`:

```dart
class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CartCubit>()),
      ],
      child: const _OrderContent(),
    );
  }
}

class _OrderContent extends BlocfulWidget<OrderCubit, OrderState, OrderEvent> {
  const _OrderContent() : super(onCreateBloc: _create);

  static OrderCubit _create(BuildContext context) => getIt<OrderCubit>()..load();

  @override
  Widget builder(BuildContext context, OrderCubit bloc, OrderState state) {
    // Can also access CartCubit here via context.read<CartCubit>()
    return Text('Order: ${state.orderId}');
  }
}
```

## Feedback Loop

After implementing:

1. Run `dart analyze` -- ensure no lint errors.
2. Verify the type parameters are correct: `BlocfulWidget<MyCubit, MyState, MyEvent>`.
3. Run the app:
   - Confirm the page renders with the initial state.
   - Trigger a presentation event (e.g., load data) -- verify snackbar/navigation fires.
   - Verify events are one-shot (navigating away and back doesn't replay them).
4. If using `showNativeDialog()`:
   - Test on iOS simulator -- confirm `CupertinoAlertDialog` appears.
   - Test on Android emulator -- confirm `AlertDialog` appears.
   - Verify dialog auto-closes after tapping an action.
5. Run unit tests for the Cubit:
   - Test state emissions with `bloc_test` or manual `expect` on `cubit.state`.
   - Test presentation events with `catchEventIn()`.
