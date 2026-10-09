import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/showcase/showcase_colors.dart';
import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:dcc_toolkit/showcase/showcase_state.dart';
import 'package:material_ui/material_ui.dart';

const _bottomOffset = 104.0;

/// Shows [ShowcaseState.notice] above the whole app, including the highlights, so a message is never hidden
/// behind an explanation. `ShowcaseShell` adds it, so there is no need to use it yourself.
class const ShowcaseNotice({super.key}) extends StatelessWidget {
  /// Creates a [ShowcaseNotice].
  this;

  @override
  Widget build(BuildContext context) {
    final builder = ShowcaseScope.noticeBuilderOf(context);

    return IgnorePointer(
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: Paddings.horizontal16 + const EdgeInsets.only(bottom: _bottomOffset),
            child: ValueListenableBuilder(
              valueListenable: ShowcaseScope.of<ShowcaseState>(context, listen: false).notice,
              builder: (context, text, _) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: text == null
                    ? const SizedBox.shrink()
                    : KeyedSubtree(
                        key: ValueKey(text),
                        child: builder?.call(context, text) ?? _DefaultNotice(text: text),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const _DefaultNotice({required final String text}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = ShowcaseColors.of(context);

    return Material(
      color: colors.onSurface,
      borderRadius: Radiuses.circular10,
      child: Padding(
        padding: Paddings.horizontal16 + Paddings.vertical12,
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.surface)),
      ),
    );
  }
}
