import 'package:dcc_toolkit/showcase/showcase_colors.dart';
import 'package:dcc_toolkit/showcase/showcase_scope.dart';
import 'package:material_ui/material_ui.dart';

/// The kit follows a Figma design of the demo on the website, where the phone is drawn at 90%. Sizes are taken
/// from there and divided by this, so everything measures the same as in Figma once the website scales it.
const figmaScale = 0.9;

/// Space between a card and the edges of the screen.
const double cardMargin = 11 / figmaScale;

/// The card everything of the kit is shown in: explanations and notices. It has the style of
/// Dutch Coding Company rather than that of the app.
class const ShowcaseCard({
  required final String body,
  final String? title,

  /// Shows a close button next to the [title].
  final VoidCallback? onClose,

  /// Below the [body], usually a row of [ShowcaseButton]s.
  final Widget? actions,
  super.key,
}) extends StatelessWidget {
  /// Creates a [ShowcaseCard].
  this : assert(onClose == null || title != null, 'The close button sits next to the title.');

  @override
  Widget build(BuildContext context) {
    final fontFamily = ShowcaseScope.fontFamilyOf(context);
    final title = this.title;
    final onClose = this.onClose;
    final actions = this.actions;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: ShowcaseColors.surface,
        border: Border.all(color: ShowcaseColors.outline, width: 1 / figmaScale),
        borderRadius: const BorderRadius.all(Radius.circular(8 / figmaScale)),
        boxShadow: const [
          BoxShadow(
            color: ShowcaseColors.shadowFar,
            offset: Offset(0, 8 / figmaScale),
            blurRadius: 12 / figmaScale,
            spreadRadius: 6 / figmaScale,
          ),
          BoxShadow(color: ShowcaseColors.shadowClose, offset: Offset(0, 4 / figmaScale), blurRadius: 4 / figmaScale),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.all(16 / figmaScale),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12 / figmaScale,
            children: [
              if (title != null)
                Row(
                  spacing: 8 / figmaScale,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16 / figmaScale,
                          height: 22 / 16,
                          fontWeight: FontWeight.w600,
                          color: ShowcaseColors.onSurface,
                        ),
                      ),
                    ),
                    if (onClose != null)
                      InkResponse(
                        onTap: onClose,
                        radius: 16 / figmaScale,
                        child: const Icon(Icons.close, size: 16 / figmaScale, color: ShowcaseColors.onSurfaceDim),
                      ),
                  ],
                ),
              Text(
                body,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12 / figmaScale,
                  letterSpacing: 0.1 / figmaScale,
                  color: ShowcaseColors.onSurfaceDim,
                ),
              ),
              ?actions,
            ],
          ),
        ),
      ),
    );
  }
}

/// A small white pill button on a [ShowcaseCard].
class const ShowcaseButton({
  required final String label,
  required final VoidCallback onPressed,
  final IconData? trailingIcon,
  super.key,
}) extends StatelessWidget {
  /// Creates a [ShowcaseButton].
  this;

  @override
  Widget build(BuildContext context) {
    const shape = StadiumBorder();
    final trailingIcon = this.trailingIcon;

    return Material(
      color: ShowcaseColors.inverse,
      shape: shape,
      child: InkWell(
        customBorder: shape,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16 / figmaScale, vertical: 8 / figmaScale),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6 / figmaScale,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: ShowcaseScope.fontFamilyOf(context),
                  fontSize: 12 / figmaScale,
                  height: 18 / 12,
                  letterSpacing: 0.1 / figmaScale,
                  fontWeight: FontWeight.w500,
                  color: ShowcaseColors.onInverse,
                ),
              ),
              if (trailingIcon != null) Icon(trailingIcon, size: 12 / figmaScale, color: ShowcaseColors.onInverseDim),
            ],
          ),
        ),
      ),
    );
  }
}
