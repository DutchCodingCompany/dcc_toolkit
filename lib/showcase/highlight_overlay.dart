import 'dart:math' as math;

import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/showcase/highlight.dart';
import 'package:dcc_toolkit/showcase/showcase_colors.dart';
import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_ui/material_ui.dart';

const _spotlightRadius = Radius.circular(Sizes.px16);
const double _tooltipGap = Sizes.px10;
const double _screenMargin = Sizes.px16;
const _cardMaxWidth = 320.0;
const _maxScrollAttempts = 2;

/// Room the card needs at least below the target before it moves above it.
const _minCardHeight = 120.0;

/// Marks the [Highlight.target] with a pulsing ring and explains it in a small card next to it. Nothing is
/// dimmed and touches pass through everything but the card, so the visitor can keep using the app.
class const HighlightOverlay({
  required final GlobalKey contentKey,
  required final Highlight highlight,
  required final int step,
  required final int total,
  required final VoidCallback onNext,
  required final VoidCallback onClose,
  super.key,
}) extends StatefulWidget {
  /// Creates a [HighlightOverlay].
  this;

  @override
  State<HighlightOverlay> createState() => _HighlightOverlayState();
}

class _HighlightOverlayState extends State<HighlightOverlay> with TickerProviderStateMixin {
  late final Ticker _ticker;
  late final AnimationController _pulse;

  Element? _targetElement;
  Rect? _targetRect;
  int _scrollAttempts = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => _track())..start();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _pulse.dispose();
    super.dispose();
  }

  /// Follows the target on every frame, because it moves when the screen scrolls or animates.
  void _track() {
    final matcher = widget.highlight.target;
    if (matcher == null) return;

    final element = _targetElement?.mounted ?? false ? _targetElement : _findTarget(matcher);
    _targetElement = element;

    final rect = _globalRectOf(element);
    if (rect != null && _scrollAttempts < _maxScrollAttempts && _scrollIntoView(element!, rect)) _scrollAttempts++;

    final localRect = rect == null ? null : _toLocal(rect);
    if (!_isSameRect(localRect, _targetRect)) setState(() => _targetRect = localRect);
  }

  Element? _findTarget(WidgetMatcher matcher) {
    final root = widget.contentKey.currentContext as Element?;
    if (root == null) return null;

    Element? found;
    void visit(Element element) {
      if (found != null) return;
      if (matcher(element.widget)) {
        found = element;
        return;
      }
      element.visitChildren(visit);
    }

    root.visitChildren(visit);

    return found;
  }

  Rect? _globalRectOf(Element? element) {
    final renderObject = element?.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.attached || !renderObject.hasSize) return null;

    return renderObject.localToGlobal(Offset.zero) & renderObject.size;
  }

  Rect _toLocal(Rect globalRect) {
    final overlay = context.findRenderObject();
    if (overlay is! RenderBox || !overlay.hasSize) return globalRect;

    return overlay.globalToLocal(globalRect.topLeft) & globalRect.size;
  }

  /// Scrolls the target into view when it is (partly) off screen. Returns whether it started scrolling.
  bool _scrollIntoView(Element element, Rect rect) {
    final height = MediaQuery.sizeOf(context).height;
    if (rect.top >= 0 && rect.bottom <= height) return false;

    // A target outside any scrollable cannot be scrolled, which is fine.
    if (Scrollable.maybeOf(element) == null) return false;
    Scrollable.ensureVisible(element, alignment: 0.15, duration: const Duration(milliseconds: 350));

    return true;
  }

  bool _isSameRect(Rect? a, Rect? b) {
    if (a == null || b == null) return a == b;

    return (a.left - b.left).abs() < 0.5 &&
        (a.top - b.top).abs() < 0.5 &&
        (a.width - b.width).abs() < 0.5 &&
        (a.height - b.height).abs() < 0.5;
  }

  @override
  Widget build(BuildContext context) {
    final highlight = widget.highlight;
    final targetRect = _targetRect;
    if (highlight.target != null && targetRect == null) return const SizedBox.shrink();

    final spotlight = targetRect == null
        ? null
        : Rect.fromLTRB(
            targetRect.left - highlight.padding.left,
            targetRect.top - highlight.padding.top,
            targetRect.right + highlight.padding.right,
            targetRect.bottom + highlight.padding.bottom,
          );

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final padding = MediaQuery.paddingOf(context);

        return Stack(
          children: [
            if (spotlight != null)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(painter: _RingPainter(spotlight, _pulse, ShowcaseColors.of(context).accent)),
                ),
              ),
            _positioned(
              spotlight: spotlight,
              size: size,
              safePadding: padding,
              child: Align(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _cardMaxWidth),
                  child: _HighlightCard(
                    highlight: highlight,
                    step: widget.step,
                    total: widget.total,
                    onNext: widget.onNext,
                    onClose: widget.onClose,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Puts the card on the side of the target that has the most room.
  Widget _positioned({
    required Rect? spotlight,
    required Size size,
    required EdgeInsets safePadding,
    required Widget child,
  }) {
    final fallbackBottom = safePadding.bottom + _screenMargin;
    // Without a target the card goes to the top: the bottom of a screen usually holds its primary action.
    if (spotlight == null) {
      return Positioned(
        left: _screenMargin,
        right: _screenMargin,
        top: safePadding.top + _screenMargin + kToolbarHeight,
        child: child,
      );
    }

    final spaceAbove = spotlight.top - safePadding.top;
    final spaceBelow = size.height - spotlight.bottom - safePadding.bottom;

    if (spaceBelow >= spaceAbove) {
      return Positioned(
        left: _screenMargin,
        right: _screenMargin,
        top: math.min(
          spotlight.bottom + _tooltipGap,
          size.height - safePadding.bottom - _screenMargin - _minCardHeight,
        ),
        child: child,
      );
    }

    return Positioned(
      left: _screenMargin,
      right: _screenMargin,
      bottom: math.max(size.height - spotlight.top + _tooltipGap, fallbackBottom),
      child: child,
    );
  }
}

class _RingPainter(final Rect spotlight, final Animation<double> pulse, final Color color) extends CustomPainter {
  this : super(repaint: pulse);

  @override
  void paint(Canvas canvas, Size size) {
    final ring = RRect.fromRectAndRadius(spotlight.inflate(pulse.value * 2), _spotlightRadius);

    canvas
      ..drawRRect(
        ring.inflate(3),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..color = color.withValues(alpha: 0.12 + 0.18 * pulse.value),
      )
      ..drawRRect(
        ring,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = color.withValues(alpha: 0.9),
      );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) => oldDelegate.spotlight != spotlight || oldDelegate.color != color;
}

class const _HighlightCard({
  required final Highlight highlight,
  required final int step,
  required final int total,
  required final VoidCallback onNext,
  required final VoidCallback onClose,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = ShowcaseColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final strings = ShowcaseScope.stringsOf(context);
    final isLast = step == total - 1;

    return Material(
      color: colors.surface,
      elevation: 3,
      borderRadius: Radiuses.circular10,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Sizes.px12, Sizes.px10, Sizes.px8, Sizes.px8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.px4,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(highlight.title, style: textTheme.titleSmall?.copyWith(color: colors.onSurface)),
                ),
                InkResponse(
                  onTap: onClose,
                  radius: Sizes.px16,
                  child: Padding(
                    padding: Paddings.all4,
                    child: Icon(Icons.close, size: Sizes.px16, color: colors.onSurface),
                  ),
                ),
              ],
            ),
            Padding(
              padding: Paddings.right4,
              child: Text(highlight.body, style: textTheme.bodySmall?.copyWith(color: colors.onSurface)),
            ),
            Row(
              children: [
                if (total > 1) _StepDots(step: step, total: total, color: colors.accent),
                const Spacer(),
                InkWell(
                  borderRadius: Radiuses.circular8,
                  onTap: onNext,
                  child: Padding(
                    padding: Paddings.horizontal8 + Paddings.vertical4,
                    child: Text(
                      isLast ? strings.done : strings.next,
                      style: textTheme.labelMedium?.copyWith(color: colors.accent, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class const _StepDots({required final int step, required final int total, required final Color color})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Sizes.px4,
      children: [
        for (var index = 0; index < total; index++)
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == step ? color : color.withValues(alpha: 0.25),
            ),
            child: const SizedBox.square(dimension: Sizes.px6),
          ),
      ],
    );
  }
}
