import 'dart:async';

import 'package:flutter/foundation.dart';

const _noticeDuration = Duration(seconds: 3);

/// What every demo needs to remember. Extend it with the data of your app and fill [resetData] to put that data
/// back at the start.
///
/// A demo has a story. When the visitor reaches the end, call [finish]: the demo offers to start over, and if
/// the visitor keeps looking around it starts over by itself at the next [begin].
abstract class ShowcaseState({final bool highlightsEnabled = true}) extends ChangeNotifier {
  /// Creates a [ShowcaseState].
  this;

  final Set<String> _seenHighlights = {};
  bool _isFinished = false;
  bool _isFinishPromptPending = false;
  Timer? _noticeTimer;

  /// A short message for the visitor, shown above everything else for a moment.
  final ValueNotifier<String?> notice = ValueNotifier(null);

  /// Whether the visitor reached the end of the story.
  bool get isFinished => _isFinished;

  /// Puts the data of the demo back at the start. Called by [reset].
  @protected
  void resetData();

  /// Starts over right away.
  void reset() {
    resetData();
    _isFinished = false;
    _isFinishPromptPending = false;
    notifyListeners();
  }

  /// Call when a visitor starts a flow, so a demo that was finished starts from the beginning again.
  void begin() {
    if (_isFinished) reset();
  }

  /// Marks the end of the story. The demo will offer to start over.
  @protected
  void finish() {
    _isFinished = true;
    _isFinishPromptPending = true;
    notifyListeners();
  }

  /// Returns whether the "demo finished" dialog still has to be shown, and marks it as shown.
  bool takeFinishPrompt() {
    final isPending = _isFinishPromptPending;
    _isFinishPromptPending = false;

    return isPending;
  }

  /// Highlights explain a page once. After that they wait behind a small button instead of opening again.
  /// This is kept when the demo starts over.
  bool hasSeenHighlights(String id) => _seenHighlights.contains(id);

  /// Remembers that the highlights of page [id] have been shown.
  void markHighlightsSeen(String id) => _seenHighlights.add(id);

  /// Shows [text] as [notice] for a moment.
  void showNotice(String text) {
    _noticeTimer?.cancel();
    notice.value = text;
    _noticeTimer = Timer(_noticeDuration, () => notice.value = null);
  }

  @override
  void dispose() {
    _noticeTimer?.cancel();
    notice.dispose();
    super.dispose();
  }
}
