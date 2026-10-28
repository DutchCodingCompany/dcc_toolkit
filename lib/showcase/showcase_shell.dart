import 'dart:async';

import 'package:dcc_toolkit/showcase/host_dom.dart'
    if (dart.library.js_interop) 'package:dcc_toolkit/showcase/host_dom_web.dart';
import 'package:dcc_toolkit/showcase/showcase_config.dart';
import 'package:dcc_toolkit/showcase/showcase_notice.dart';
import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:dcc_toolkit/showcase/showcase_state.dart';
import 'package:dcc_toolkit/showcase/showcase_tour.dart';
import 'package:material_ui/material_ui.dart';

/// Wraps the app, for the `builder` of [MaterialApp]: it adds the safe areas that [ShowcaseConfig.insets] asks for
/// and shows the notices above everything else.
///
/// When the page around the demo starts the explanations ([ShowcaseConfig.tourOnHost]), it also connects the two
/// with `postMessage`, on the same origin only:
///
/// - the demo sends `{type: 'showcase:tour', canStart: bool}` at the start and whenever it changes, so the page
///   can enable its button only while the page on screen has an explanation that is not open yet;
/// - the page sends `{type: 'showcase:start-tour'}` to open it.
class const ShowcaseShell({required final Widget child, super.key}) extends StatelessWidget {
  /// Creates a [ShowcaseShell].
  this;

  @override
  Widget build(BuildContext context) {
    final state = ShowcaseScope.of<ShowcaseState>(context, listen: false);
    final ShowcaseConfig(:insets, :tourOnHost) = state.config;
    final app = Stack(
      children: [
        Positioned.fill(
          child: tourOnHost ? _HostBridge(tour: state.tour, child: child) : child,
        ),
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

const _tourMessage = 'showcase:tour';
const _startTourMessage = 'showcase:start-tour';

class const _HostBridge({required final ShowcaseTour tour, required final Widget child}) extends StatefulWidget {
  @override
  State<_HostBridge> createState() => _HostBridgeState();
}

class _HostBridgeState extends State<_HostBridge> {
  late final VoidCallback _stopListening;
  bool? _sentCanStart;
  bool _isSendScheduled = false;

  @override
  void initState() {
    super.initState();
    widget.tour.addListener(_scheduleSend);
    _send();
    _stopListening = listenToHost((data) {
      if (data is Map && data['type'] == _startTourMessage) widget.tour.start();
    });
  }

  /// Between two pages the tour changes twice in a row, once for each page. Only the result goes to the page.
  void _scheduleSend() {
    if (_isSendScheduled) return;

    _isSendScheduled = true;
    scheduleMicrotask(() {
      _isSendScheduled = false;
      if (mounted) _send();
    });
  }

  void _send() {
    final canStart = widget.tour.canStart;
    if (canStart == _sentCanStart) return;

    _sentCanStart = canStart;
    postToHost({'type': _tourMessage, 'canStart': canStart});
  }

  @override
  void dispose() {
    widget.tour.removeListener(_scheduleSend);
    _stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
