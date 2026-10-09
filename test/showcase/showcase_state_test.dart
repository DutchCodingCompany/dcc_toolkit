import 'package:dcc_toolkit/showcase.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_state.dart';

void main() {
  group(ShowcaseState, () {
    test('is not finished at the start', () {
      expect(TestState().isFinished, isFalse);
    });

    test('is finished after the last step and asks once to start over', () {
      final state = TestState()
        ..step()
        ..step()
        ..step();

      expect(state.isFinished, isTrue);
      expect(state.takeFinishPrompt(), isTrue);
      expect(state.takeFinishPrompt(), isFalse);
    });

    test('begin does not reset a demo that is not finished', () {
      final state = TestState()
        ..step()
        ..begin();

      expect(state.steps, 1);
    });

    test('begin starts a finished demo over', () {
      final state = TestState()
        ..step()
        ..step()
        ..step()
        ..begin();

      expect(state.steps, 0);
      expect(state.isFinished, isFalse);
      expect(state.takeFinishPrompt(), isFalse);
    });

    test('reset starts over right away and tells listeners', () {
      var notified = 0;
      final state = TestState()
        ..step()
        ..addListener(() => notified++)
        ..reset();

      expect(state.steps, 0);
      expect(notified, 1);
    });

    test('remembers which highlights were seen, also after a reset', () {
      final state = TestState();

      expect(state.hasSeenHighlights('home'), isFalse);

      state
        ..markHighlightsSeen('home')
        ..reset();

      expect(state.hasSeenHighlights('home'), isTrue);
    });

    test('shows a notice for a moment', () {
      final state = TestState()..showNotice('Hello');

      expect(state.notice.value, 'Hello');
    });
  });

  group(ShowcaseConfig, () {
    test('shows highlights and has no insets by default', () {
      final config = ShowcaseConfig.fromUri(Uri.parse('https://example.com/'));

      expect(config.highlightsEnabled, isTrue);
      expect(config.insets.top, 0);
    });

    test('reads highlights=off and insets=ios from the url', () {
      final config = ShowcaseConfig.fromUri(Uri.parse('https://example.com/?highlights=off&insets=ios'));

      expect(config.highlightsEnabled, isFalse);
      expect(config.insets, iosInsets);
    });
  });
}
