import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A widget that displays a text with inline actions.
/// Supported formats: [text](action) or [text]
/// This way translations can be done with inline actions.
///
/// The text is displayed as a [RichText] widget.
/// The annotations are displayed as a [TextSpan] widget with optionally a [TapGestureRecognizer] attached to it (if the action is not null).
/// The [actions] map is used to map the action name to the action to perform when the text is tapped.
/// The [defaultStyle] is the style of the default text.
/// The [annotationStyle] is the style of the annotated text.
/// The [textAlign] is the alignment of the text.
///
/// [some text] only highlights the text, but does not trigger an action.
/// [some text](action) highlights the text and triggers the action when tapped.
/// [some text](action) without a defined action for the exact name 'action' will not trigger an action.
///
/// Example:
/// ```dart
/// AnnotatedText(
///   text: 'Hello [world](onWorldTapped)',
///   actions: {'onWorldTapped': () => print('world')},
///   defaultStyle: TextStyle(color: Colors.black),
///   annotationStyle: TextStyle(color: Colors.blue),
/// )
/// ```
class AnnotatedText extends StatelessWidget {
  /// Creates a widget that displays a text with annotations.
  const AnnotatedText({
    required this.text,
    required this.actions,
    required this.defaultStyle,
    required this.annotationStyle,
    this.textAlign = TextAlign.start,
    super.key,
  });

  /// The complete text to display.
  final String text;

  /// A map {actionName: action} of actions to perform when the text is tapped.
  final Map<String, VoidCallback>? actions;

  /// The style of the default text.
  final TextStyle defaultStyle;

  /// The style of the annotated text.
  final TextStyle annotationStyle;

  /// The alignment of the text.
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      _buildTextSpan(text: text, defaultStyle: defaultStyle, annotationStyle: annotationStyle, actions: actions),
      textAlign: textAlign,
    );
  }
}

TextSpan _buildTextSpan({
  required String text,
  required TextStyle defaultStyle,
  required TextStyle annotationStyle,
  Map<String, VoidCallback>? actions,
}) {
  /// matches [text](action) with an action, or [text] without an action
  final regex = RegExp(r'\[([^\]]+?)\](?:\((.*?)\))?');
  final spans = <TextSpan>[];
  var currentIndex = 0;

  for (final match in regex.allMatches(text)) {
    final matchStart = match.start;
    final matchEnd = match.end;

    // Add normal text before match
    if (matchStart > currentIndex) {
      spans.add(TextSpan(text: text.substring(currentIndex, matchStart), style: defaultStyle));
    }

    final displayText = match.group(1)!;
    final actionKey = match.group(2);
    final action = (actionKey != null && actionKey.isNotEmpty && actions != null) ? actions[actionKey] : null;

    spans.add(
      TextSpan(
        text: displayText,
        style: annotationStyle,
        recognizer: action != null ? (TapGestureRecognizer()..onTap = action) : null,
      ),
    );

    currentIndex = matchEnd;
  }

  // Add remaining text
  if (currentIndex < text.length) {
    spans.add(TextSpan(text: text.substring(currentIndex), style: defaultStyle));
  }

  return TextSpan(children: spans);
}
