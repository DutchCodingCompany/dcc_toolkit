import 'package:dcc_toolkit/showcase/showcase_notice.dart';
import 'package:material_ui/material_ui.dart';

/// Wraps the app, for the `builder` of [MaterialApp]: it adds the safe areas that [insets] ask for and shows the
/// notices above everything else.
class const ShowcaseShell({required final EdgeInsets insets, required final Widget child, super.key})
    extends StatelessWidget {
  /// Creates a [ShowcaseShell].
  this;

  @override
  Widget build(BuildContext context) {
    final app = Stack(
      children: [
        Positioned.fill(child: child),
        const Positioned.fill(child: ShowcaseNotice()),
      ],
    );

    if (insets == EdgeInsets.zero) return app;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(padding: insets, viewPadding: insets),
      child: app,
    );
  }
}
