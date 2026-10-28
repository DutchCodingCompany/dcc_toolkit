import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/showcase/highlight.dart';
import 'package:dcc_toolkit/showcase/highlight_overlay.dart';
import 'package:dcc_toolkit/showcase/showcase_colors.dart';
import 'package:dcc_toolkit/showcase/showcase_navigator.dart';
import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:dcc_toolkit/showcase/showcase_state.dart';
import 'package:dcc_toolkit/showcase/showcase_tour.dart';
import 'package:material_ui/material_ui.dart';

/// Shows the [highlights] of a page on top of [child] while that page is the one on screen.
///
/// The explanation is an [OverlayPortal] in the overlay of the navigator. It lies above the page, below the routes
/// that are pushed later, and only appears once the page has settled. It never opens by itself: the visitor opens
/// it with a small button, or the page around the demo does through [ShowcaseState.tour]. It starts at the first
/// step every time, and closes when the page leaves the screen or its content, identified by [id], changes.
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

  ShowcaseState? _state;
  int _step = 0;
  bool _isOpen = false;
  bool _isCurrent = false;
  bool _isOnScreen = false;
  bool _isReportScheduled = false;

  /// The page is current when it is the top route of its navigator and nothing covers that navigator.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isCurrent = (ModalRoute.of(context)?.isCurrent ?? false) && isShowcaseOnTop(context);
    if (!_isCurrent) _isOpen = false;
  }

  @override
  void didUpdateWidget(HighlightedPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) _isOpen = false;
  }

  // Every ShowcaseState holds a TourController; only the pages may update it.
  TourController? get _tour => _state?.tour as TourController?;

  @override
  void dispose() {
    _tour?.hide(this);
    super.dispose();
  }

  void _open() {
    setState(() {
      _step = 0;
      _isOpen = true;
    });
  }

  void _next(int total) {
    setState(() {
      if (_step >= total - 1) {
        _isOpen = false;
      } else {
        _step++;
      }
    });
  }

  /// Tells the tour whether this page is on screen and open, after the frame, as listeners may rebuild.
  ///
  /// A page counts as on screen from the moment it is current, not only once its transition has ended.
  /// Otherwise the tour could not start for a moment between two pages that both have an explanation, and a button
  /// for it would flicker.
  void _report({required bool isOnScreen}) {
    _isOnScreen = isOnScreen;
    if (_isReportScheduled) return;

    _isReportScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isReportScheduled = false;
      final tour = _tour;
      if (!mounted || tour == null) return;

      if (_isOnScreen) {
        tour.show(this, isOpen: _isOpen, start: _open);
      } else {
        tour.hide(this);
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
    final state = _state = ShowcaseScope.of<ShowcaseState>(context);
    final route = ModalRoute.of(context);
    final content = KeyedSubtree(key: _contentKey, child: widget.child);

    final hasHighlights = state.config.highlightsEnabled && widget.highlights.isNotEmpty && route != null;
    _report(isOnScreen: hasHighlights && _isCurrent);
    if (!hasHighlights) return content;

    _showPortal();
    final step = _step.clamp(0, widget.highlights.length - 1);

    return AnimatedBuilder(
      animation: Listenable.merge([?route.animation, ?route.secondaryAnimation]),
      builder: (context, _) {
        // Compares values, because an animation only reports its new status after the last value was notified.
        final isSettled =
            _isCurrent && (route.animation?.value ?? 1) >= 1 && (route.secondaryAnimation?.value ?? 0) <= 0;

        return OverlayPortal(
          controller: _portalController,
          overlayChildBuilder: (context) {
            if (!isSettled) return const SizedBox.shrink();
            if (!_isOpen) return state.config.tourOnHost ? const SizedBox.shrink() : _OpenButton(onPressed: _open);

            return HighlightOverlay(
              key: ValueKey('${widget.id}:$step'),
              contentKey: _contentKey,
              highlight: widget.highlights[step],
              step: step,
              total: widget.highlights.length,
              onNext: () => _next(widget.highlights.length),
              onClose: () => setState(() => _isOpen = false),
            );
          },
          child: content,
        );
      },
    );
  }
}

/// Opens the explanation. It is small and sits on the right edge, because the top and bottom of most screens are
/// taken by the app bar and the primary action.
class const _OpenButton({required final VoidCallback onPressed}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final strings = ShowcaseScope.stringsOf(context);

    return Stack(
      children: [
        Positioned(
          right: Sizes.px8,
          top: height * 0.4,
          child: Tooltip(
            message: strings.explanation,
            child: Material(
              color: ShowcaseColors.surface,
              elevation: 2,
              shape: const CircleBorder(side: BorderSide(color: ShowcaseColors.outline)),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onPressed,
                child: const SizedBox.square(
                  dimension: Sizes.px32,
                  child: Icon(Icons.info_outline, size: Sizes.px20, color: ShowcaseColors.onSurfaceDim),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
