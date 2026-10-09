String _featureOutOfScope(String feature) => '$feature is outside this demo.';

/// All texts the kit shows itself. The defaults are English, pass your own to `ShowcaseScope` for another language.
class const ShowcaseStrings({
  /// Moves a highlight to the next step.
  final String next = 'Next',

  /// Moves the last highlight of a page away.
  final String done = 'Done',

  /// Tooltip of the button that brings back an explanation that was closed.
  final String explanation = 'Explanation',

  /// Notice for a part of the app that is not in the demo.
  final String outOfScope = 'This part is outside this demo.',

  /// Notice for a named part of the app that is not in the demo.
  final String Function(String feature) featureOutOfScope = _featureOutOfScope,
  final String finishTitle = 'Demo finished',
  final String finishMessage = 'You have seen the whole story. Do you want to start over?',
  final String keepLooking = 'Keep looking around',
  final String startOver = 'Start over',
}) {
  /// Creates a [ShowcaseStrings].
  this;
}
