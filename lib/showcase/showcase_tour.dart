import 'package:flutter/foundation.dart';

/// The explanation of the page on screen: whether there is one to start.
///
/// Explanations never open by themselves. A visitor starts one with the info button in the app, or with a
/// button on the website when the website controls the tour (`?tour=host`).
abstract interface class ShowcaseTour implements Listenable {
  /// Whether the page on screen has an explanation that is not open yet.
  bool get canStart;

  /// Opens the explanation of the page on screen, if it has one.
  void start();
}

/// The [ShowcaseTour] of a demo, which the page on screen keeps up to date. Not exported: only the pages update it.
class TourController extends ChangeNotifier implements ShowcaseTour {
  Object? _page;
  VoidCallback? _start;
  bool _isOpen = false;

  @override
  bool get canStart => _page != null && !_isOpen;

  @override
  void start() {
    if (canStart) _start?.call();
  }

  /// Called by the page on screen whenever its explanation opens or closes. [start] opens it.
  void show(Object page, {required bool isOpen, required VoidCallback start}) {
    _start = start;
    if (identical(_page, page) && _isOpen == isOpen) return;

    _page = page;
    _isOpen = isOpen;
    notifyListeners();
  }

  /// Called by a page that is no longer on screen.
  void hide(Object page) {
    if (!identical(_page, page)) return;

    _page = null;
    _start = null;
    _isOpen = false;
    notifyListeners();
  }
}
