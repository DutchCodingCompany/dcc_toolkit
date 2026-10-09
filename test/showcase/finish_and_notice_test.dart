import 'package:dcc_toolkit/showcase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'test_state.dart';

Widget _app(TestState state, Widget home) => ShowcaseScope(
  state: state,
  child: MaterialApp(
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: home,
    builder: (context, child) => ShowcaseShell(insets: EdgeInsets.zero, child: child!),
  ),
);

void main() {
  group(FinishPrompt, () {
    testWidgets('offers to start over after finishing, and does when asked', (tester) async {
      final state = TestState()
        ..step()
        ..step()
        ..step();
      await tester.pumpWidget(_app(state, const FinishPrompt(child: Scaffold(body: Text('Home')))));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('Demo finished'), findsOneWidget);

      await tester.tap(find.text('Start over'));
      await tester.pumpAndSettle();

      expect(state.steps, 0);
      expect(find.text('Demo finished'), findsNothing);
    });

    testWidgets('keeps the result when the visitor keeps looking around', (tester) async {
      final state = TestState()
        ..step()
        ..step()
        ..step();
      await tester.pumpWidget(_app(state, const FinishPrompt(child: Scaffold(body: Text('Home')))));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Keep looking around'));
      await tester.pumpAndSettle();

      expect(state.steps, 3);
      expect(state.isFinished, isTrue);
    });

    testWidgets('stays quiet while the demo is not finished', (tester) async {
      await tester.pumpWidget(_app(TestState(), const FinishPrompt(child: Scaffold(body: Text('Home')))));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('Demo finished'), findsNothing);
    });
  });

  group('notices', () {
    testWidgets('shows that a part is out of the demo and removes the notice again', (tester) async {
      await tester.pumpWidget(
        _app(
          TestState(),
          Scaffold(
            body: Builder(
              builder: (context) =>
                  TextButton(onPressed: () => context.showOutOfScope('The map'), child: const Text('Tap')),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap'));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('The map is outside this demo.'), findsOneWidget);

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(find.text('The map is outside this demo.'), findsNothing);
    });

    testWidgets('uses the general text without a name', (tester) async {
      await tester.pumpWidget(
        _app(
          TestState(),
          Scaffold(
            body: Builder(
              builder: (context) => TextButton(onPressed: context.showOutOfScope, child: const Text('Tap')),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap'));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('This part is outside this demo.'), findsOneWidget);

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });
  });
}
