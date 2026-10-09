import 'package:dcc_toolkit/showcase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'test_state.dart';

enum _Page { home, first, second, end }

Widget _pageFor(BuildContext context, _Page page, Object? args) => Scaffold(
  appBar: AppBar(title: Text('Page ${page.name}${args == null ? '' : ' $args'}')),
  body: Column(
    children: [
      TextButton(onPressed: () => context.showcase.push(_Page.first), child: const Text('push first')),
      TextButton(onPressed: () => context.showcase.push(_Page.second, args: 42), child: const Text('push second')),
      TextButton(onPressed: () => context.showcase.replace(_Page.second), child: const Text('replace second')),
      TextButton(onPressed: () => context.showcase.pushOnHome(_Page.end), child: const Text('end')),
      TextButton(onPressed: context.showcase.popToHome, child: const Text('home')),
      TextButton(onPressed: () => Navigator.maybePop(context), child: const Text('back')),
    ],
  ),
);

Future<void> _pumpApp(WidgetTester tester, {ShowcaseHighlightsBuilder<_Page>? highlights}) async {
  await tester.pumpWidget(
    ShowcaseScope(
      state: TestState(),
      child: MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: ShowcaseNavigator<_Page>(home: _Page.home, builder: _pageFor, highlights: highlights),
      ),
    ),
  );
  await _settle(tester);
}

/// Highlights keep animating, so waiting for the frames to settle would take forever.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  await tester.pump(const Duration(milliseconds: 600));
}

Future<void> _tap(WidgetTester tester, String text) async {
  await tester.tap(find.text(text).last);
  await _settle(tester);
}

void main() {
  testWidgets('starts at home', (tester) async {
    await _pumpApp(tester);

    expect(find.text('Page home'), findsOneWidget);
  });

  testWidgets('pushes a page, with its arguments, and goes back', (tester) async {
    await _pumpApp(tester);

    await _tap(tester, 'push second');
    expect(find.text('Page second 42'), findsOneWidget);

    await _tap(tester, 'back');
    expect(find.text('Page home'), findsOneWidget);
  });

  testWidgets('replaces the current page', (tester) async {
    await _pumpApp(tester);

    await _tap(tester, 'push first');
    await _tap(tester, 'replace second');
    expect(find.text('Page second'), findsOneWidget);

    await _tap(tester, 'back');
    expect(find.text('Page home'), findsOneWidget);
  });

  testWidgets('goes back to home from deep in a flow', (tester) async {
    await _pumpApp(tester);

    await _tap(tester, 'push first');
    await _tap(tester, 'push second');
    await _tap(tester, 'home');

    expect(find.text('Page home'), findsOneWidget);
    expect(find.text('Page first'), findsNothing);
  });

  testWidgets('opens the end of a flow on top of home', (tester) async {
    await _pumpApp(tester);

    await _tap(tester, 'push first');
    await _tap(tester, 'push second');
    await _tap(tester, 'end');
    expect(find.text('Page end'), findsOneWidget);

    await _tap(tester, 'back');
    expect(find.text('Page home'), findsOneWidget);
  });

  testWidgets('does not leave home when going back', (tester) async {
    await _pumpApp(tester);

    await _tap(tester, 'back');

    expect(find.text('Page home'), findsOneWidget);
  });

  testWidgets('explains only the page on top', (tester) async {
    await _pumpApp(
      tester,
      highlights: (context, page, state) => [Highlight(title: 'About ${page.name}', body: 'Explanation')],
    );
    expect(find.text('About home'), findsOneWidget);

    await _tap(tester, 'push first');

    expect(find.text('About first'), findsOneWidget);
    expect(find.text('About home'), findsNothing);
  });
}
