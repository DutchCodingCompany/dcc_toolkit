import 'package:dcc_toolkit/showcase.dart';

/// A minimal demo state: counts the steps of the visitor and finishes after the third.
class TestState extends ShowcaseState {
  new({super.highlightsEnabled});

  int steps = 0;

  @override
  void resetData() => steps = 0;

  void step() {
    steps++;
    if (steps == 3) finish();
    notifyListeners();
  }
}
