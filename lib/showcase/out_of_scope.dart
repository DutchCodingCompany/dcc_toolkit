import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:dcc_toolkit/showcase/showcase_state.dart';
import 'package:material_ui/material_ui.dart';

/// Lets any widget of the demo tell the visitor a part of the app is left out.
extension OutOfScope on BuildContext {
  /// Tells the visitor that the tapped part of the app is not included in the demo, optionally by [feature] name.
  void showOutOfScope([String? feature]) {
    final strings = ShowcaseScope.stringsOf(this);

    ShowcaseScope.of<ShowcaseState>(
      this,
      listen: false,
    ).showNotice(feature == null ? strings.outOfScope : strings.featureOutOfScope(feature));
  }
}
