import 'package:dcc_toolkit/showcase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'test_state.dart';

Widget _app(TestState state, Widget home, {TransitionBuilder? builder}) => ShowcaseScope(
  state: state,
  child: MaterialApp(localizationsDelegates: GlobalMaterialLocalizations.delegates, home: home, builder: builder),
);

Widget _page(List<Highlight> highlights) => HighlightedPage(
  id: 'page',
  highlights: highlights,
  child: const Scaffold(body: Center(child: Text('Page'))),
);

/// The pulsing ring never stops animating, so waiting for the frames to settle would take forever.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump(const Duration(milliseconds: 500));
}

const _first = Highlight(title: 'First', body: 'About the first');
const _second = Highlight(title: 'Second', body: 'About the second');

void main() {
  testWidgets('explains a page the first time it is shown', (tester) async {
    await tester.pumpWidget(_app(TestState(), _page(const [_first])));
    await _settle(tester);

    expect(find.text('Page'), findsOneWidget);
    expect(find.text('First'), findsOneWidget);
    expect(find.text('About the first'), findsOneWidget);
  });

  testWidgets('walks through the steps and closes after the last', (tester) async {
    await tester.pumpWidget(_app(TestState(), _page(const [_first, _second])));
    await _settle(tester);

    await tester.tap(find.text('Next'));
    await _settle(tester);

    expect(find.text('Second'), findsOneWidget);

    await tester.tap(find.text('Done'));
    await _settle(tester);

    expect(find.text('Second'), findsNothing);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
  });

  testWidgets('waits behind a button when the page was explained before, and opens from it', (tester) async {
    final state = TestState()..markHighlightsSeen('page');
    await tester.pumpWidget(_app(state, _page(const [_first])));
    await _settle(tester);

    expect(find.text('First'), findsNothing);

    await tester.tap(find.byIcon(Icons.info_outline));
    await _settle(tester);

    expect(find.text('First'), findsOneWidget);
  });

  testWidgets('closing the explanation leaves the page usable', (tester) async {
    await tester.pumpWidget(_app(TestState(), _page(const [_first])));
    await _settle(tester);

    await tester.tap(find.byIcon(Icons.close));
    await _settle(tester);

    expect(find.text('First'), findsNothing);
    expect(find.text('Page'), findsOneWidget);
  });

  testWidgets('shows nothing when highlights are switched off', (tester) async {
    await tester.pumpWidget(_app(TestState(highlightsEnabled: false), _page(const [_first])));
    await _settle(tester);

    expect(find.text('Page'), findsOneWidget);
    expect(find.text('First'), findsNothing);
    expect(find.byIcon(Icons.info_outline), findsNothing);
  });

  testWidgets('waits for a target that is not on the page', (tester) async {
    final highlight = Highlight(title: 'Missing', body: 'Not there', target: Highlight.type<Icon>());
    await tester.pumpWidget(_app(TestState(), _page([highlight])));
    await _settle(tester);

    expect(find.text('Missing'), findsNothing);
  });

  testWidgets('explains a target that is on the page', (tester) async {
    final highlight = Highlight(title: 'About the text', body: 'This is it', target: Highlight.type<Text>());
    await tester.pumpWidget(_app(TestState(), _page([highlight])));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('About the text'), findsOneWidget);
  });

  testWidgets('hides the explanation while another page is on top', (tester) async {
    late BuildContext context;
    await tester.pumpWidget(
      _app(
        TestState(),
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

    expect(find.text('First'), findsOneWidget);

    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const Scaffold(body: Text('Other'))));
    await _settle(tester);

    expect(find.text('Other'), findsOneWidget);
    expect(find.text('First'), findsNothing);
  });

  testWidgets('uses the texts of the strings it is given', (tester) async {
    await tester.pumpWidget(
      ShowcaseScope(
        state: TestState(),
        strings: const ShowcaseStrings(done: 'Klaar'),
        child: MaterialApp(localizationsDelegates: GlobalMaterialLocalizations.delegates, home: _page(const [_first])),
      ),
    );
    await _settle(tester);

    expect(find.text('Klaar'), findsOneWidget);
  });
}
