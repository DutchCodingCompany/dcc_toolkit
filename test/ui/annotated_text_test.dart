import 'package:dcc_toolkit/ui/annotated_text/annotated_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders annotated text without action', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AnnotatedText(
          text: 'Hello [world]',
          actions: {},
          defaultStyle: TextStyle(color: Colors.black),
          annotationStyle: TextStyle(color: Colors.blue),
        ),
      ),
    );

    // Get the Text widget that uses Text.rich
    final textWidget = tester.widget<Text>(find.byType(Text));
    final rootSpan = textWidget.textSpan! as TextSpan;

    // Combine all spans into a single string
    final fullText = rootSpan.children!.map((span) => (span as TextSpan).text).join();

    expect(fullText, equals('Hello world'));
    final annotatedSpan = rootSpan.children![1]; // "world"
    expect((annotatedSpan as TextSpan).style!.color, equals(Colors.blue));
  });

  testWidgets('annotated text applies annotationStyle', (WidgetTester tester) async {
    const annotationStyle = TextStyle(color: Colors.blue);

    await tester.pumpWidget(
      const MaterialApp(
        home: AnnotatedText(
          text: 'Hello [world]',
          actions: {},
          defaultStyle: TextStyle(color: Colors.black),
          annotationStyle: annotationStyle,
        ),
      ),
    );

    final textWidget = tester.widget<Text>(find.byType(Text));
    final rootSpan = textWidget.textSpan! as TextSpan;

    final annotatedSpan = rootSpan.children![1]; // "world"
    expect((annotatedSpan as TextSpan).style!.color, equals(annotationStyle.color));
  });

  testWidgets('annotated text with action has a GestureRecognizer', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnnotatedText(
          text: 'Click [here](onTap)',
          actions: {'onTap': () {}},
          defaultStyle: const TextStyle(color: Colors.black),
          annotationStyle: const TextStyle(color: Colors.blue),
        ),
      ),
    );

    // Get the Text widget that uses Text.rich
    final textWidget = tester.widget<Text>(find.byType(Text));
    final rootSpan = textWidget.textSpan! as TextSpan;

    // Locate the annotated span (second span in the children list)
    final annotatedSpan = rootSpan.children![1] as TextSpan;

    // Verify a recognizer exists and is a TapGestureRecognizer
    expect(annotatedSpan.recognizer, isNotNull);
    expect(annotatedSpan.recognizer, isA<TapGestureRecognizer>());
  });
}
