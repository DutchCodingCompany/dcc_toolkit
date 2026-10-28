import 'package:dcc_toolkit/showcase/showcase_card.dart';
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
    return IgnorePointer(
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: cardMargin, right: cardMargin, bottom: _bottomOffset),
            child: ValueListenableBuilder(
              valueListenable: ShowcaseScope.of<ShowcaseState>(context, listen: false).notice,
              builder: (context, text, _) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: text == null
                    ? const SizedBox.shrink()
                    : KeyedSubtree(
                        key: ValueKey(text),
                        child: ShowcaseCard(body: text),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
