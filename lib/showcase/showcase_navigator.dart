import 'package:dcc_toolkit/showcase/highlight.dart';
import 'package:dcc_toolkit/showcase/highlighted_page.dart';
import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:dcc_toolkit/showcase/showcase_state.dart';
import 'package:flutter/cupertino.dart';

/// Builds the screen for a page, with the arguments it was opened with.
typedef ShowcasePageBuilder<P extends Enum> = Widget Function(BuildContext context, P page, Object? args);

/// The highlights of a page, which may depend on how far the visitor has come.
typedef ShowcaseHighlightsBuilder<P extends Enum> = List<Highlight> Function(
  BuildContext context,
  P page,
  ShowcaseState state,
);

/// Navigation of the demo, with the plain Flutter [Navigator]. The pages are the values of an enum [P], opened
/// with `context.showcase`, and every page gets its highlights.
///
/// The url of the browser does not change, so the demo stays where the website embedded it. Put it as the
/// `home` of a [WidgetsApp] or `MaterialApp`, or anywhere below a [ShowcaseScope].
class const ShowcaseNavigator<P extends Enum>({
  required final P home,
  required final ShowcasePageBuilder<P> builder,
  final ShowcaseHighlightsBuilder<P>? highlights,
  super.key,
}) extends StatefulWidget {
  /// Creates a [ShowcaseNavigator].
  this;

  @override
  State<ShowcaseNavigator<P>> createState() => _ShowcaseNavigatorState<P>();
}

class _ShowcaseNavigatorState<P extends Enum> extends State<ShowcaseNavigator<P>> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  Route<Object?> _route(P page, Object? args) {
    final widget = this.widget;

    return CupertinoPageRoute(
      settings: RouteSettings(name: page.name, arguments: _PageArguments(page, args)),
      builder: (context) {
        final child = widget.builder(context, page, args);
        final highlightsBuilder = widget.highlights;
        if (highlightsBuilder == null) return child;

        final highlights = highlightsBuilder(context, page, ShowcaseScope.of<ShowcaseState>(context));

        // A page explains itself once for each variant of its content, which the first title identifies.
        return HighlightedPage(
          id: '${page.name}:${highlights.firstOrNull?.title}',
          highlights: highlights,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ShowcaseNavigatorScope(
      controller: ShowcaseNavigation._(_navigatorKey, (page, args) => _route(page as P, args)),
      child: Navigator(
        key: _navigatorKey,
        onGenerateInitialRoutes: (_, _) => [_route(widget.home, null)],
        onGenerateRoute: (settings) {
          final arguments = settings.arguments;
          if (arguments is! _PageArguments) return null;

          return _route(arguments.page as P, arguments.args);
        },
      ),
    );
  }
}

class const _PageArguments(final Enum page, final Object? args);

/// Opens and closes the pages of the demo. Get it with `context.showcase`.
class ShowcaseNavigation._(
  final GlobalKey<NavigatorState> _navigatorKey,
  final Route<Object?> Function(Enum page, Object? args) _route,
) {
  NavigatorState get _navigator => _navigatorKey.currentState!;

  /// Opens [page] on top of the current one.
  Future<void> push(Enum page, {Object? args}) => _navigator.push(_route(page, args));

  /// Opens [page] instead of the current one.
  Future<void> replace(Enum page, {Object? args}) => _navigator.pushReplacement(_route(page, args));

  /// Closes the current page, unless it is the first one.
  Future<bool> pop([Object? result]) => _navigator.maybePop(result);

  /// Closes every page above the first one, usually home.
  void popToHome() => _navigator.popUntil((route) => route.isFirst);

  /// Opens [page] right on top of home, closing everything in between. For the end of a flow, where going back
  /// should lead home instead of into the flow again.
  Future<void> pushOnHome(Enum page, {Object? args}) =>
      _navigator.pushAndRemoveUntil(_route(page, args), (route) => route.isFirst);
}

class const _ShowcaseNavigatorScope({required final ShowcaseNavigation controller, required super.child})
    extends InheritedWidget {
  @override
  bool updateShouldNotify(_ShowcaseNavigatorScope oldWidget) => false;
}

/// Gives access to the navigation of the demo.
extension ShowcaseNavigationX on BuildContext {
  /// The navigation of the demo. Use it from any page that [ShowcaseNavigator] opened.
  ShowcaseNavigation get showcase {
    final scope = getInheritedWidgetOfExactType<_ShowcaseNavigatorScope>();
    assert(scope != null, 'No ShowcaseNavigator found above this context.');

    return scope!.controller;
  }
}
