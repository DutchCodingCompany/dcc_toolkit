import 'package:dcc_toolkit/showcase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

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
      TextButton(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          useRootNavigator: true,
          builder: (_) => const SizedBox(height: 200, child: Text('Sheet')),
        ),
        child: const Text('sheet'),
      ),
    ],
  ),
);

Future<ShowcaseState> _pumpApp(WidgetTester tester, {ShowcaseHighlightsBuilder<_Page>? highlights}) async {
  final state = ShowcaseState();
  await tester.pumpWidget(
    ShowcaseScope(
      state: state,
      child: MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: ShowcaseNavigator<_Page>(home: _Page.home, builder: _pageFor, highlights: highlights),
      ),
    ),
  );
  await _settle(tester);

  return state;
}

/// An open highlight follows its target on every frame, so waiting for the frames to settle would take forever.
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
    final state = await _pumpApp(
      tester,
      highlights: (context, page, state) => [Highlight(title: 'About ${page.name}', body: 'Explanation')],
    );
    state.tour.start();
    await _settle(tester);
    expect(find.text('About home'), findsOneWidget);

    // Without a target the whole page is dimmed, and so out of reach until the explanation is closed.
    await _tap(tester, 'Done');
    await _tap(tester, 'push first');
    state.tour.start();
    await _settle(tester);

    expect(find.text('About first'), findsOneWidget);
    expect(find.text('About home'), findsNothing);
  });

  testWidgets('cannot start the explanation below a sheet in the root navigator', (tester) async {
    final state = await _pumpApp(
      tester,
      highlights: (context, page, state) => [Highlight(title: 'About ${page.name}', body: 'Explanation')],
    );

    expect(state.tour.canStart, isTrue);

    await _tap(tester, 'sheet');

    expect(find.text('Sheet'), findsOneWidget);
    expect(state.tour.canStart, isFalse);

    await tester.tapAt(const Offset(10, 10));
    await _settle(tester);

    expect(find.text('Sheet'), findsNothing);
    expect(state.tour.canStart, isTrue);
  });
}
