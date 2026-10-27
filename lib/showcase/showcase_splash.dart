import 'package:dcc_toolkit/showcase/splash_dom.dart'
    if (dart.library.js_interop) 'package:dcc_toolkit/showcase/splash_dom_web.dart';
import 'package:flutter/widgets.dart';

/// Removes the splash of `web/index.html`, the element with id `splash`, like the native splash of the app on a
/// phone. Call it right after `runApp`.
///
/// The splash stays until the first frame is drawn and at least [minimum] has passed since the page started
/// loading, so a slow connection never waits longer. It fades out by adding the class `splash--hidden` and is
/// removed a second later. Outside the browser this does nothing.
Future<void> removeShowcaseSplash({Duration minimum = const Duration(seconds: 2)}) async {
  if (!hasSplashDom) return;

  // Not waitUntilFirstFrameRasterized: it relies on frame timings, which the web does not report for a single frame.
  await WidgetsBinding.instance.endOfFrame;
  final remaining = minimum - timeSincePageLoad();
  if (remaining > Duration.zero) await Future<void>.delayed(remaining);

  hideSplashDom();
}
