import 'dart:async';

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
Future<T?> showNativeDialog<T>(
  BuildContext context, {
  required String title,
  required List<DialogAction<T>> actions,
  required String content,
}) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return showCupertinoDialog<T>(
      context: context,
      builder:
          (dialogContext) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions:
                actions
                    .map(
                      (action) => CupertinoDialogAction(
                        onPressed: () async {
                          final result = await action.onTap();
                          if (dialogContext.mounted) Navigator.of(dialogContext).pop(result);
                        },
                        isDestructiveAction: action.isDestructiveAction,
                        child: Text(action.text, style: action.textStyle),
                      ),
                    )
                    .toList(),
          ),
    );
  } else {
    return showDialog<T?>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions:
                actions
                    .map(
                      (action) => TextButton(
                        onPressed: () async {
                          final result = await action.onTap();
                          if (dialogContext.mounted) Navigator.of(dialogContext).pop(result);
                        },
                        child: Text(action.text, style: action.textStyle),
                      ),
                    )
                    .toList(),
          ),
    );
  }
}

/// A dialog action which is used to show the actions of a native dialog. Tapping a action will also close the dialog.
class DialogAction<T> {
  /// Creates a [DialogAction].
  const DialogAction({required this.text, required this.onTap, this.isDestructiveAction = false, this.textStyle});

  /// The text of the action.
  final String text;

  /// The callback that is called when the action is tapped.
  final FutureOr<T?> Function() onTap;

  /// Whether the action is a destructive action. This is only used on iOS.
  final bool isDestructiveAction;

  /// The style of the action text.
  final TextStyle? textStyle;
}
