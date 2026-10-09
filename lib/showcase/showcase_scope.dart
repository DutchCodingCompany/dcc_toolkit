import 'package:dcc_toolkit/showcase/showcase_state.dart';
import 'package:dcc_toolkit/showcase/showcase_strings.dart';
import 'package:material_ui/material_ui.dart';

/// Gives the widgets of the kit, and your own, access to the [ShowcaseState]. Put it above the app.
class const ShowcaseScope({
  required final ShowcaseState state,
  required super.child,
  final ShowcaseStrings strings = const ShowcaseStrings(),

  /// Builds the notice of [ShowcaseState.showNotice], for when it has to look like the rest of the app.
  final Widget Function(BuildContext context, String text)? noticeBuilder,
  super.key,
}) extends InheritedNotifier<ShowcaseState> {
  /// Creates a [ShowcaseScope].
  this : super(notifier: state);

  /// The state, as the type of your own demo state. Pass `listen: false` from callbacks.
  static T of<T extends ShowcaseState>(BuildContext context, {bool listen = true}) =>
      _scopeOf(context, listen: listen).state as T;

  /// The texts of the kit.
  static ShowcaseStrings stringsOf(BuildContext context) => _scopeOf(context, listen: false).strings;

  /// The custom notice builder, if any.
  static Widget Function(BuildContext context, String text)? noticeBuilderOf(BuildContext context) =>
      _scopeOf(context, listen: false).noticeBuilder;

  static ShowcaseScope _scopeOf(BuildContext context, {required bool listen}) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<ShowcaseScope>()
        : context.getInheritedWidgetOfExactType<ShowcaseScope>();
    assert(scope != null, 'No ShowcaseScope found above this context.');

    return scope!;
  }
}
