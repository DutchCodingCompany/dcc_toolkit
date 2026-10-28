import 'dart:math' as math;

import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/showcase/highlight.dart';
import 'package:dcc_toolkit/showcase/showcase_card.dart';
import 'package:dcc_toolkit/showcase/showcase_colors.dart';
import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_ui/material_ui.dart';

const _spotlightRadius = Radius.circular(16 / figmaScale);
const double _ringWidth = 2.7 / figmaScale;
const double _tooltipGap = Sizes.px10;
const _maxScrollAttempts = 2;

/// Room the card needs at least below the target before it moves above it.
const _minCardHeight = 120.0;

/// Dims the app around the [Highlight.target], marks it with a ring and explains it in a card next to it. Touches
/// on the dimmed part are stopped, while the target itself can still be used.
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

class _HighlightOverlayState extends State<HighlightOverlay> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  Element? _targetElement;
  Rect? _targetRect;
  int _scrollAttempts = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => _track())..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
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
            Positioned.fill(
              child: CustomPaint(
                painter: _ScrimPainter(spotlight == null ? null : RRect.fromRectAndRadius(spotlight, _spotlightRadius)),
              ),
            ),
            _positioned(
              spotlight: spotlight,
              size: size,
              safePadding: padding,
              child: _HighlightCard(
                highlight: highlight,
                step: widget.step,
                total: widget.total,
                onNext: widget.onNext,
                onClose: widget.onClose,
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
    final fallbackBottom = safePadding.bottom + cardMargin;
    // Without a target the card goes to the top: the bottom of a screen usually holds its primary action.
    if (spotlight == null) {
      return Positioned(
        left: cardMargin,
        right: cardMargin,
        top: safePadding.top + cardMargin + kToolbarHeight,
        child: child,
      );
    }

    final spaceAbove = spotlight.top - safePadding.top;
    final spaceBelow = size.height - spotlight.bottom - safePadding.bottom;

    if (spaceBelow >= spaceAbove) {
      return Positioned(
        left: cardMargin,
        right: cardMargin,
        top: math.min(spotlight.bottom + _tooltipGap, size.height - safePadding.bottom - cardMargin - _minCardHeight),
        child: child,
      );
    }

    return Positioned(
      left: cardMargin,
      right: cardMargin,
      bottom: math.max(size.height - spotlight.top + _tooltipGap, fallbackBottom),
      child: child,
    );
  }
}

/// Dims everything but the [spotlight] and draws the ring inside its edge. Being hit outside the spotlight is what
/// keeps touches there from reaching the app.
class _ScrimPainter(final RRect? spotlight) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final spotlight = this.spotlight;
    final scrim = Paint()..color = ShowcaseColors.scrim;
    if (spotlight == null) {
      canvas.drawRect(Offset.zero & size, scrim);

      return;
    }

    canvas
      ..drawPath(
        Path()
          ..fillType = PathFillType.evenOdd
          ..addRect(Offset.zero & size)
          ..addRRect(spotlight),
        scrim,
      )
      ..drawRRect(
        spotlight.deflate(_ringWidth / 2),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _ringWidth
          ..color = ShowcaseColors.onSurface,
      );
  }

  @override
  bool hitTest(Offset position) => !(spotlight?.contains(position) ?? false);

  @override
  bool shouldRepaint(_ScrimPainter oldDelegate) => oldDelegate.spotlight != spotlight;
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
    final strings = ShowcaseScope.stringsOf(context);
    final isLast = step == total - 1;

    return ShowcaseCard(
      title: highlight.title,
      body: highlight.body,
      onClose: onClose,
      actions: Row(
        spacing: 16 / figmaScale,
        children: [
          Expanded(
            child: total > 1 ? _StepDots(step: step, total: total) : const SizedBox.shrink(),
          ),
          ShowcaseButton(
            label: isLast ? strings.done : strings.next,
            trailingIcon: isLast ? null : Icons.chevron_right,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}

class const _StepDots({required final int step, required final int total}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4 / figmaScale,
      children: [
        for (var index = 0; index < total; index++)
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == step ? null : ShowcaseColors.subtle,
              gradient: index == step ? ShowcaseColors.accent : null,
            ),
            child: const SizedBox.square(dimension: 6 / figmaScale),
          ),
      ],
    );
  }
}
