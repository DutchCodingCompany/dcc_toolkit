import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:material_ui/material_ui.dart';

/// Decides whether [widget] is the target of a [Highlight].
typedef WidgetMatcher = bool Function(Widget widget);

/// One explanation shown on top of a screen.
///
/// The real views are not changed for the showcase, so a [target] finds the widget to mark in the widget tree
/// of the screen. Without a target only the explanation is shown. A highlight whose target is not built (yet)
/// waits until it appears, for example behind a loading state.
class const Highlight({
  required final String title,
  required final String body,
  final WidgetMatcher? target,

  /// Space between the target and the ring around it.
  final EdgeInsets padding = Paddings.all8,
}) {
  /// Creates a [Highlight].
  this;

  /// Matches the first widget of type [T] on the screen.
  static WidgetMatcher type<T extends Widget>() =>
      (widget) => widget is T;
}
