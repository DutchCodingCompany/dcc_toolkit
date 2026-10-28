import 'package:dcc_toolkit/showcase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(ShowcaseState, () {
    test('shows a notice for a moment', () {
      final state = ShowcaseState()..showNotice('Hello');

      expect(state.notice.value, 'Hello');
    });
  });

  group(ShowcaseConfig, () {
    test('shows highlights and the splash, has no insets and keeps the tour in the app by default', () {
      final config = ShowcaseConfig.fromUri(Uri.parse('https://example.com/'));

      expect(config.highlightsEnabled, isTrue);
      expect(config.splashEnabled, isTrue);
      expect(config.insets.top, 0);
      expect(config.tourOnHost, isFalse);
    });

    test('reads highlights=off, insets=ios, splash=off and tour=host from the url', () {
      final config = ShowcaseConfig.fromUri(
        Uri.parse('https://example.com/?highlights=off&insets=ios&splash=off&tour=host'),
      );

      expect(config.highlightsEnabled, isFalse);
      expect(config.insets, iosInsets);
      expect(config.splashEnabled, isFalse);
      expect(config.tourOnHost, isTrue);
    });
  });

  group('removeShowcaseSplash', () {
    test('does nothing outside the browser', () async {
      await expectLater(removeShowcaseSplash(), completes);
    });
  });
}
