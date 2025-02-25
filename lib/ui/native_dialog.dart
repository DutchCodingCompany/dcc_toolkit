import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A native dialog which shows a [CupertinoAlertDialog] on iOS and a [AlertDialog] on Android.
///
/// Example:
/// ```dart
/// showNativeDialog(
///   context,
///   title: 'Title',
///   content: 'Content',
///   actions: [
///     DialogAction(text: 'Action', onTap: () {}),
///   ],
/// );
/// ```
void showNativeDialog(
  BuildContext context, {
  required String title,
  required List<DialogAction> actions,
  required String content,
}) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions
            .map(
              (action) => CupertinoDialogAction(
                onPressed: action.onTap,
                isDestructiveAction: action.isDestructiveAction,
                child: Text(action.text),
              ),
            )
            .toList(),
      ),
    );
  } else {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions
            .map(
              (action) => TextButton(
                onPressed: action.onTap,
                child: Text(action.text),
              ),
            )
            .toList(),
      ),
    );
  }
}

/// A dialog action which is used to show the actions of a native dialog.
class DialogAction {
  /// Creates a [DialogAction].
  const DialogAction({
    required this.text,
    required this.onTap,
    this.isDestructiveAction = false,
  });

  /// The text of the action.
  final String text;

  /// The callback that is called when the action is tapped.
  final VoidCallback onTap;

  /// Whether the action is a destructive action. This is only used on iOS.
  final bool isDestructiveAction;
}
