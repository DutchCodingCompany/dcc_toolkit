import 'package:dcc_toolkit/showcase/showcase_state.dart';
import 'package:dcc_toolkit/showcase/showcase_strings.dart';
import 'package:material_ui/material_ui.dart';

/// Gives the widgets of the kit, and your own, access to the [ShowcaseState]. Put it above the app.
class const ShowcaseScope({
  required final ShowcaseState state,
  required super.child,
  final ShowcaseStrings strings = const ShowcaseStrings(),

  /// The font of the explanations and notices, which follow the style of Dutch Coding Company: DM Sans, declared
  /// in the pubspec of the demo. Without it they use the font of the app.
  final String? fontFamily,
  super.key,
}) extends InheritedNotifier<ShowcaseState> {
  /// Creates a [ShowcaseScope].
  this : super(notifier: state);

  /// The state, as the type of your own demo state. Pass `listen: false` from callbacks.
  static T of<T extends ShowcaseState>(BuildContext context, {bool listen = true}) =>
      _scopeOf(context, listen: listen).state as T;

  /// The texts of the kit.
  static ShowcaseStrings stringsOf(BuildContext context) => _scopeOf(context, listen: false).strings;

  /// The font of the explanations, if any.
  static String? fontFamilyOf(BuildContext context) => _scopeOf(context, listen: false).fontFamily;

  static ShowcaseScope _scopeOf(BuildContext context, {required bool listen}) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<ShowcaseScope>()
        : context.getInheritedWidgetOfExactType<ShowcaseScope>();
    assert(scope != null, 'No ShowcaseScope found above this context.');

    return scope!;
  }
}
