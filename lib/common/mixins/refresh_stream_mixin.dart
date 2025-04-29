import 'dart:async';

import 'package:flutter/foundation.dart';

/// A mixin that provides a stream of update events.
///
/// This mixin is used to notify listeners when an update occurs.
/// It is used in the [RefreshStreamMixin] class.
///
/// Example:
/// ```dart
/// class MyRepository with RefreshNotifierMixin {
///   void create() {
///     // Execute create logic
///     refreshListeners(RefreshType.create);
///   }
///
///   void update() {
///     // Execute update logic
///     refreshListeners(RefreshType.update);
///   }
/// }
/// ```
///
/// Then you can listen to the refresh stream like this:
/// ```dart
/// myRepository.listen((event) {
///   switch (event) {
///     case RefreshType.create:
///       // Execute create logic
///       break;
///     case RefreshType.update:
///       // Execute update logic
///       break;
///   }
/// });
/// ```
mixin RefreshStreamMixin {
  final _refreshStream = StreamController<RefreshType>.broadcast();

  /// Adds a new refresh event to the stream.
  @protected
  void refreshListeners(RefreshType event) => _refreshStream.add(event);

  /// Listener function for the refresh stream.
  StreamSubscription<RefreshType> listen(void Function(RefreshType event) events) {
    return _refreshStream.stream.listen(events);
  }

  /// Closes the refresh stream.
  Future<void> close() async {
    await _refreshStream.close();
  }
}

/// The type of refresh event.
enum RefreshType {
  /// The [RefreshType.create] event should be used when a new object is created.
  create,

  /// The [RefreshType.update] event should be used when an object is updated.
  update,

  /// The [RefreshType.delete] event should be used when an object is deleted.
  delete,

  /// The [RefreshType.custom] event should be used when a custom event occurs,
  /// if the refresh should trigger different logic than a normal create/update/delete event.
  /// This way you can separate behaviour in the place where you are listening to the events
  custom,
}
