import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/showcase/highlight.dart';
import 'package:dcc_toolkit/showcase/highlight_overlay.dart';
import 'package:dcc_toolkit/showcase/showcase_colors.dart';
import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:dcc_toolkit/showcase/showcase_state.dart';
import 'package:material_ui/material_ui.dart';

/// Shows the [highlights] of a page on top of [child] while that page is the one on screen.
///
/// The explanation is an [OverlayPortal] in the overlay of the navigator. It lies above the page, below the routes
/// that are pushed later, and only appears once the page has settled. A page explains itself once, identified by
/// [id]. After that the explanation waits behind a small button.
///
/// Put it inside the route of the page, so [ModalRoute] is the route of that page.
class const HighlightedPage({
  required final String id,
  required final List<Highlight> highlights,
  required final Widget child,
  super.key,
}) extends StatefulWidget {
  /// Creates a [HighlightedPage].
  this;

  @override
  State<HighlightedPage> createState() => _HighlightedPageState();
}

class _HighlightedPageState extends State<HighlightedPage> {
  final GlobalKey _contentKey = GlobalKey();
  final OverlayPortalController _portalController = OverlayPortalController();

  int _step = 0;
  bool _isClosed = false;
  bool _wasCurrent = false;
  String? _highlightsId;

  /// Opens the explanation the first time a page is shown. When the page comes back to the front, or its content
  /// changes, it only opens again if the visitor has not seen it yet. Otherwise it waits behind a small button.
  void _syncWithPage({required bool isCurrent, required ShowcaseState state}) {
    if (isCurrent && (!_wasCurrent || widget.id != _highlightsId)) {
      _step = 0;
      _isClosed = state.hasSeenHighlights(widget.id);
      state.markHighlightsSeen(widget.id);
    }
    _wasCurrent = isCurrent;
    _highlightsId = widget.id;
  }

  void _next(int total) {
    setState(() {
      if (_step >= total - 1) {
        _isClosed = true;
      } else {
        _step++;
      }
    });
  }

  /// The portal can only be shown once it is in the tree, and not while building.
  void _showPortal() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_portalController.isShowing) _portalController.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ShowcaseScope.of<ShowcaseState>(context);
    final route = ModalRoute.of(context);
    final content = KeyedSubtree(key: _contentKey, child: widget.child);

    if (!state.highlightsEnabled || widget.highlights.isEmpty || route == null) return content;

    _syncWithPage(isCurrent: route.isCurrent, state: state);
    _showPortal();
    final step = _step.clamp(0, widget.highlights.length - 1);

    return AnimatedBuilder(
      animation: Listenable.merge([?route.animation, ?route.secondaryAnimation]),
      builder: (context, _) {
        // Compares values, because an animation only reports its new status after the last value was notified.
        final isSettled =
            route.isCurrent && (route.animation?.value ?? 1) >= 1 && (route.secondaryAnimation?.value ?? 0) <= 0;

        return OverlayPortal(
          controller: _portalController,
          overlayChildBuilder: (context) {
            if (!isSettled) return const SizedBox.shrink();
            if (_isClosed) return _ReopenButton(onPressed: () => setState(() => _isClosed = false));

            return HighlightOverlay(
              key: ValueKey('${widget.id}:$step'),
              contentKey: _contentKey,
              highlight: widget.highlights[step],
              step: step,
              total: widget.highlights.length,
              onNext: () => _next(widget.highlights.length),
              onClose: () => setState(() => _isClosed = true),
            );
          },
          child: content,
        );
      },
    );
  }
}

/// Brings the explanation back after it was closed. It is small and sits on the right edge, because the top and
/// bottom of most screens are taken by the app bar and the primary action.
class const _ReopenButton({required final VoidCallback onPressed}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final colors = ShowcaseColors.of(context);
    final strings = ShowcaseScope.stringsOf(context);

    return Stack(
      children: [
        Positioned(
          right: Sizes.px8,
          top: height * 0.4,
          child: Tooltip(
            message: strings.explanation,
            child: Material(
              color: colors.surface.withValues(alpha: 0.92),
              elevation: 2,
              shape: CircleBorder(side: BorderSide(color: colors.accent.withValues(alpha: 0.5))),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onPressed,
                child: SizedBox.square(
                  dimension: Sizes.px32,
                  child: Icon(Icons.info_outline, size: Sizes.px20, color: colors.accent),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
