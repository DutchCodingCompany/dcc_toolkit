import 'dart:async';

import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:dcc_toolkit/showcase/showcase_state.dart';
import 'package:material_ui/material_ui.dart';

/// Wait a moment, so the visitor sees the result of the last step first.
const _delay = Duration(milliseconds: 700);

/// Offers to start over once the demo is finished and the visitor is back on the page that contains this widget,
/// usually the home of the app.
///
/// Keeping looking around closes the dialog. The demo then starts over by itself at the next
/// [ShowcaseState.begin].
class const FinishPrompt({required final Widget child, super.key}) extends StatefulWidget {
  /// Creates a [FinishPrompt].
  this;

  @override
  State<FinishPrompt> createState() => _FinishPromptState();
}

class _FinishPromptState extends State<FinishPrompt> {
  bool _isScheduled = false;

  Future<void> _showAfterDelay(ShowcaseState state) async {
    await Future<void>.delayed(_delay);
    _isScheduled = false;
    if (!mounted) return;

    final strings = ShowcaseScope.stringsOf(context);
    await showNativeDialog<void>(
      context,
      title: strings.finishTitle,
      content: strings.finishMessage,
      actions: [
        DialogAction(text: strings.keepLooking, onTap: () {}),
        DialogAction(text: strings.startOver, onTap: state.reset),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ShowcaseScope.of<ShowcaseState>(context);
    final isCurrent = ModalRoute.of(context)?.isCurrent ?? false;

    if (isCurrent && !_isScheduled && state.takeFinishPrompt()) {
      _isScheduled = true;
      unawaited(_showAfterDelay(state));
    }

    return widget.child;
  }
}
