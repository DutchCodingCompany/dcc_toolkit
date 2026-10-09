import 'package:material_ui/material_ui.dart';

/// Safe areas of an iPhone 16, for embedding in a website without a status bar of its own.
const iosInsets = EdgeInsets.only(top: 59, bottom: 34);

/// How the host page configures the demo, read from the url: `?highlights=off&insets=ios`.
class const ShowcaseConfig({final bool highlightsEnabled = true, final EdgeInsets insets = EdgeInsets.zero}) {
  /// Creates a [ShowcaseConfig].
  this;

  /// Reads the configuration from the query parameters of [uri].
  factory fromUri(Uri uri) {
    final query = uri.queryParameters;

    return ShowcaseConfig(
      highlightsEnabled: query['highlights'] != 'off',
      insets: query['insets'] == 'ios' ? iosInsets : EdgeInsets.zero,
    );
  }
}
