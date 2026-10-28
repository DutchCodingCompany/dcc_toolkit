import 'dart:async';

import 'package:dcc_toolkit/showcase/showcase_config.dart';
import 'package:dcc_toolkit/showcase/showcase_tour.dart';
import 'package:flutter/foundation.dart';

const _noticeDuration = Duration(seconds: 3);

/// What every demo needs to remember. Extend it with the data of your app, and call [notifyListeners] when that
/// data changes so the screens follow.
class ShowcaseState({
  /// How the website configured the demo, usually `ShowcaseConfig.fromUri(Uri.base)`.
  final ShowcaseConfig config = const ShowcaseConfig(),
}) extends ChangeNotifier {
  /// Creates a [ShowcaseState].
  this;

  Timer? _noticeTimer;

  /// A short message for the visitor, shown above everything else for a moment.
  final ValueNotifier<String?> notice = ValueNotifier(null);

  final TourController _tour = TourController();

  /// The explanation of the page on screen.
  ShowcaseTour get tour => _tour;

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
    _tour.dispose();
    super.dispose();
  }
}
