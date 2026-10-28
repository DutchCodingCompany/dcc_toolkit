import 'dart:async';

import 'package:dcc_toolkit/showcase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _app(ShowcaseState state, Widget home) => ShowcaseScope(
  state: state,
  child: MaterialApp(localizationsDelegates: GlobalMaterialLocalizations.delegates, home: home),
);

Widget _page(List<Highlight> highlights) => HighlightedPage(
  id: 'page',
  highlights: highlights,
  child: const Scaffold(body: Center(child: Text('Page'))),
);

Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> _open(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.info_outline));
  await _settle(tester);
}

const _first = Highlight(title: 'First', body: 'About the first');
const _second = Highlight(title: 'Second', body: 'About the second');

void main() {
  testWidgets('does not open by itself, and opens from the button', (tester) async {
    await tester.pumpWidget(_app(ShowcaseState(), _page(const [_first])));
    await _settle(tester);

    expect(find.text('Page'), findsOneWidget);
    expect(find.text('First'), findsNothing);

    await _open(tester);

    expect(find.text('First'), findsOneWidget);
    expect(find.text('About the first'), findsOneWidget);
  });

  testWidgets('walks through the steps and closes after the last', (tester) async {
    await tester.pumpWidget(_app(ShowcaseState(), _page(const [_first, _second])));
    await _settle(tester);
    await _open(tester);

    await tester.tap(find.text('Next'));
    await _settle(tester);

    expect(find.text('Second'), findsOneWidget);

    await tester.tap(find.text('Done'));
    await _settle(tester);

    expect(find.text('Second'), findsNothing);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
  });

  testWidgets('starts at the first step again when opened again', (tester) async {
    await tester.pumpWidget(_app(ShowcaseState(), _page(const [_first, _second])));
    await _settle(tester);
    await _open(tester);
    await tester.tap(find.text('Next'));
    await _settle(tester);
    await tester.tap(find.byIcon(Icons.close));
    await _settle(tester);

    await _open(tester);

    expect(find.text('First'), findsOneWidget);
  });

  testWidgets('closing the explanation leaves the page usable', (tester) async {
    await tester.pumpWidget(_app(ShowcaseState(), _page(const [_first])));
    await _settle(tester);
    await _open(tester);

    await tester.tap(find.byIcon(Icons.close));
    await _settle(tester);

    expect(find.text('First'), findsNothing);
    expect(find.text('Page'), findsOneWidget);
  });

  testWidgets('shows nothing when highlights are switched off', (tester) async {
    final state = ShowcaseState(config: const ShowcaseConfig(highlightsEnabled: false));
    await tester.pumpWidget(_app(state, _page(const [_first])));
    await _settle(tester);

    expect(find.text('Page'), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsNothing);
    expect(state.tour.canStart, isFalse);
  });

  testWidgets('waits for a target that is not on the page', (tester) async {
    final highlight = Highlight(title: 'Missing', body: 'Not there', target: Highlight.type<Icon>());
    final state = ShowcaseState();
    await tester.pumpWidget(_app(state, _page([highlight])));
    await _settle(tester);
    state.tour.start();
    await _settle(tester);

    expect(find.text('Missing'), findsNothing);
  });

  testWidgets('only lets touches through to the target', (tester) async {
    var targetTaps = 0;
    var otherTaps = 0;
    final state = ShowcaseState();
    await tester.pumpWidget(
      _app(
        state,
        HighlightedPage(
          id: 'page',
          highlights: [
            Highlight(title: 'About the target', body: 'This is it', target: Highlight.type<FilledButton>()),
          ],
          child: Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 300),
                FilledButton(onPressed: () => targetTaps++, child: const Text('Target')),
                const SizedBox(height: 200),
                OutlinedButton(onPressed: () => otherTaps++, child: const Text('Other')),
              ],
            ),
          ),
        ),
      ),
    );
    await _settle(tester);
    state.tour.start();
    await _settle(tester);

    expect(find.text('About the target'), findsOneWidget);

    await tester.tap(find.text('Other'), warnIfMissed: false);
    await tester.tap(find.text('Target'));

    expect(otherTaps, 0);
    expect(targetTaps, 1);
  });

  testWidgets('hides the explanation while another page is on top', (tester) async {
    late BuildContext context;
    final state = ShowcaseState();
    await tester.pumpWidget(
      _app(
        state,
        HighlightedPage(
          id: 'page',
          highlights: const [_first],
          child: Builder(
            builder: (builderContext) {
              context = builderContext;

              return const Scaffold(body: Text('Page'));
            },
          ),
        ),
      ),
    );
    await _settle(tester);
    await _open(tester);

    expect(find.text('First'), findsOneWidget);

    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const Scaffold(body: Text('Other'))));
    await _settle(tester);

    expect(find.text('Other'), findsOneWidget);
    expect(find.text('First'), findsNothing);
    expect(state.tour.canStart, isFalse);
  });

  testWidgets('uses the texts of the strings it is given', (tester) async {
    await tester.pumpWidget(
      ShowcaseScope(
        state: ShowcaseState(),
        strings: const ShowcaseStrings(done: 'Klaar'),
        child: MaterialApp(localizationsDelegates: GlobalMaterialLocalizations.delegates, home: _page(const [_first])),
      ),
    );
    await _settle(tester);
    await _open(tester);

    expect(find.text('Klaar'), findsOneWidget);
  });

  group(ShowcaseTour, () {
    testWidgets('can start while the page on screen has a closed explanation', (tester) async {
      final state = ShowcaseState();
      await tester.pumpWidget(_app(state, _page(const [_first])));
      await _settle(tester);

      expect(state.tour.canStart, isTrue);

      state.tour.start();
      await _settle(tester);

      expect(find.text('First'), findsOneWidget);
      expect(state.tour.canStart, isFalse);

      await tester.tap(find.byIcon(Icons.close));
      await _settle(tester);

      expect(state.tour.canStart, isTrue);
    });

    testWidgets('can start right away on the next page, without waiting for its transition', (tester) async {
      late BuildContext context;
      final state = ShowcaseState();
      await tester.pumpWidget(
        _app(
          state,
          HighlightedPage(
            id: 'page',
            highlights: const [_first],
            child: Builder(
              builder: (builderContext) {
                context = builderContext;

                return const Scaffold(body: Text('Page'));
              },
            ),
          ),
        ),
      );
      await _settle(tester);

      unawaited(Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => _page(const [_second]))));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(state.tour.canStart, isTrue);

      state.tour.start();
      await _settle(tester);

      expect(find.text('Second'), findsOneWidget);
    });

    testWidgets('cannot start on a page without explanations', (tester) async {
      final state = ShowcaseState();
      await tester.pumpWidget(_app(state, _page(const [])));
      await _settle(tester);

      expect(state.tour.canStart, isFalse);
    });

    testWidgets('leaves the button to the page around the demo when it runs the tour', (tester) async {
      final state = ShowcaseState(config: const ShowcaseConfig(tourOnHost: true));
      await tester.pumpWidget(_app(state, _page(const [_first])));
      await _settle(tester);

      expect(find.byIcon(Icons.info_outline), findsNothing);

      state.tour.start();
      await _settle(tester);

      expect(find.text('First'), findsOneWidget);
    });
  });
}
