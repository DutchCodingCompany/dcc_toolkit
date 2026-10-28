import 'package:dcc_toolkit/showcase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _app(ShowcaseState state, Widget home) => ShowcaseScope(
  state: state,
  child: MaterialApp(
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: home,
    builder: (context, child) => ShowcaseShell(child: child!),
  ),
);

void main() {
  group('notices', () {
    testWidgets('shows that a part is out of the demo and removes the notice again', (tester) async {
      await tester.pumpWidget(
        _app(
          ShowcaseState(),
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
          ShowcaseState(),
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
