---
name: dcc-setup-kleurplaat-boekwerk
description: Create and configure a custom design system using KatjasKleurplaat (colors) and KatjasBoekwerk (typography) theme extensions. Use when setting up theming, adding a color palette, configuring typography, or integrating the DCC design system into a Flutter app.
metadata:
  last_modified: 2025-06-18
---

# Set Up Kleurplaat & Boekwerk Design System

## Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Core Concepts](#core-concepts)
- [Workflow](#workflow)
- [Complete Example](#complete-example)
- [Common Patterns](#common-patterns)
- [Feedback Loop](#feedback-loop)

## Overview

The DCC design system uses a two-part architecture with Dutch naming:

- **Kleurplaat** ("coloring page") -- the color system. `KatjasKleurplaat` is a `ThemeExtension` that defines color groups (primary, error, success, content, surface) with contrast/subtle variants.
- **Boekwerk** ("literary work") -- the typography system. `KatjasBoekwerk` is a `ThemeExtension` that defines a full typography scale using `Handschrift` (extended `TextStyle` with built-in `.bold` and `.link` variants).
- **BoekwerkDecorator** -- combines both systems, producing pre-colored text styles via `HandschriftDecorator`.

Both are registered as Flutter `ThemeExtension`s and accessed via `BuildContext` extensions.

## Prerequisites

```dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
```

For `KatjasBoekwerk` and `Handschrift` (not in barrel file), import directly:

```dart
import 'package:dcc_toolkit/style/text_style/katjas_boekwerk.dart';
import 'package:dcc_toolkit/style/text_style/handschrift.dart';
```

## Core Concepts

### Color System

| Class | Role |
|-------|------|
| `KatjasKleurplaat` | `ThemeExtension<KatjasKleurplaat>`. Holds all color groups. Supports `copyWith()`, `lerp()`, `toColorScheme()` |
| `ColorGroup` | A group of 2-3 colors: `color` (the color itself), `onColorContrast` (foreground), `onColorSubtle` (optional subtle foreground) |
| `SurfaceGroup` | Surface colors with 5 contrast levels, 5 container levels, link color, and optional error/success/primary surface colors |

#### Required Color Groups

| Group | Purpose |
|-------|---------|
| `primary` / `primaryFill` | Brand primary color and its filled variant |
| `content` / `contentFill` | Main content/text colors |
| `error` / `errorFill` | Error state colors |
| `success` / `successFill` | Success state colors |
| `surface` | Background and container colors |

#### Optional Color Groups

| Group | Purpose |
|-------|---------|
| `secondary` / `secondaryFill` | Secondary brand color |
| `tertiary` / `tertiaryFill` | Tertiary accent |
| `accent` / `accentFill` | Additional accent |
| `surfaceInverse` | Inverse surface (e.g., dark mode surface in light theme) |

### Typography System

| Class | Role |
|-------|------|
| `Handschrift` | Extended `TextStyle` with `.bold` and `.link` getters that merge variant styles |
| `KatjasBoekwerk` | `ThemeExtension<KatjasBoekwerk>`. Full typography scale (display/subtitle/headline/title/body/label/navbar) using `Handschrift` |
| `BoekwerkDecorator` | Combines `KatjasBoekwerk` + `KatjasKleurplaat` to produce `HandschriftDecorator` instances |
| `HandschriftDecorator` | A single `Handschrift` colored by all palette groups. Access: `.primary.color`, `.surface.onColorContrast`, etc. |

### BuildContext Extensions

| Extension | Access |
|-----------|--------|
| `context.theme` | `ThemeData` |
| `context.colors` | `ColorScheme` |
| `context.katjasKleurPlaat` | `KatjasKleurplaat` instance |
| `context.katjasBoekwerk` | `KatjasBoekwerk` instance |
| `context.katjasBoekwerkDecorator` | `BoekwerkDecorator` (pre-colored text styles) |

## Workflow

**Task Progress:**
- [ ] 1. Define color palette (`KatjasKleurplaat`)
- [ ] 2. Define typography scale (`KatjasBoekwerk`)
- [ ] 3. Register both as `ThemeExtension`s on `ThemeData`
- [ ] 4. Access colors and typography in widgets via `BuildContext` extensions
- [ ] 5. (Optional) Use `BoekwerkDecorator` for pre-colored text styles
- [ ] 6. Verify with `dart analyze`

### Step 1: Define Color Palette

Create a file (e.g., `lib/core/theme/app_kleurplaat.dart`):

```dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter/material.dart';

final appKleurplaatLight = KatjasKleurplaat(
  primary: const ColorGroup(
    color: Color(0xFF1A73E8),
    onColorContrast: Color(0xFFFFFFFF),
    onColorSubtle: Color(0xFFE8F0FE),
  ),
  primaryFill: const ColorGroup(
    color: Color(0xFFE8F0FE),
    onColorContrast: Color(0xFF1A73E8),
  ),
  content: const ColorGroup(
    color: Color(0xFF1C1B1F),
    onColorContrast: Color(0xFFFFFFFF),
    onColorSubtle: Color(0xFF49454F),
  ),
  contentFill: const ColorGroup(
    color: Color(0xFFE6E1E5),
    onColorContrast: Color(0xFF1C1B1F),
  ),
  error: const ColorGroup(
    color: Color(0xFFB3261E),
    onColorContrast: Color(0xFFFFFFFF),
  ),
  errorFill: const ColorGroup(
    color: Color(0xFFF9DEDC),
    onColorContrast: Color(0xFFB3261E),
  ),
  success: const ColorGroup(
    color: Color(0xFF198754),
    onColorContrast: Color(0xFFFFFFFF),
  ),
  successFill: const ColorGroup(
    color: Color(0xFFD1E7DD),
    onColorContrast: Color(0xFF198754),
  ),
  surface: const SurfaceGroup(
    color: Color(0xFFFFFBFE),
    onColorContrast: Color(0xFF1C1B1F),
    onColorContrastDim: Color(0xFF49454F),
    onColorSubtle: Color(0xFF79747E),
    onColorSubtleDim: Color(0xFFADA8B2),
    containerLowest: Color(0xFFFFFFFF),
    containerLow: Color(0xFFF7F2FA),
    container: Color(0xFFF3EDF7),
    containerHigh: Color(0xFFECE6F0),
    containerHighest: Color(0xFFE6E0E9),
    link: Color(0xFF1A73E8),
    onColorError: Color(0xFFB3261E),
    onColorSuccess: Color(0xFF198754),
    onColorPrimary: Color(0xFF1A73E8),
  ),
  surfaceInverse: const SurfaceGroup(
    color: Color(0xFF313033),
    onColorContrast: Color(0xFFE6E1E5),
    onColorContrastDim: Color(0xFFCAC4D0),
    onColorSubtle: Color(0xFF938F99),
    onColorSubtleDim: Color(0xFF79747E),
    containerLowest: Color(0xFF1C1B1F),
    containerLow: Color(0xFF2B2930),
    container: Color(0xFF313033),
    containerHigh: Color(0xFF3B383E),
    containerHighest: Color(0xFF484549),
    link: Color(0xFF8AB4F8),
  ),
);
```

### Step 2: Define Typography Scale

Create a file (e.g., `lib/core/theme/app_boekwerk.dart`):

```dart
import 'package:dcc_toolkit/style/text_style/handschrift.dart';
import 'package:dcc_toolkit/style/text_style/katjas_boekwerk.dart';
import 'package:flutter/material.dart';

final appBoekwerk = KatjasBoekwerk(
  displayLarge: const Handschrift(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  displayMedium: const Handschrift(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.16,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  displaySmall: const Handschrift(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.22,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  headlineLarge: const Handschrift(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  headlineMedium: const Handschrift(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.29,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  headlineSmall: const Handschrift(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.33,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  titleLarge: const Handschrift(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.27,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  titleMedium: const Handschrift(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  titleSmall: const Handschrift(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  bodyLarge: const Handschrift(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  bodyMedium: const Handschrift(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  bodySmall: const Handschrift(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  labelLarge: const Handschrift(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  labelMedium: const Handschrift(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  labelSmall: const Handschrift(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
    linkStyle: TextStyle(decoration: TextDecoration.underline),
  ),
  navbar: const Handschrift(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    boldStyle: TextStyle(fontWeight: FontWeight.w700),
  ),
);
```

### Step 3: Register on ThemeData

In your app's theme configuration:

```dart
import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  final kleurplaat = appKleurplaatLight;
  final boekwerk = appBoekwerk;

  return ThemeData(
    colorScheme: kleurplaat.toColorScheme(brightness: Brightness.light),
    textTheme: boekwerk.asTextTheme(
      bodyColor: kleurplaat.surface.onColorContrast,
      displayColor: kleurplaat.surface.onColorContrast,
    ),
    extensions: [
      kleurplaat,
      boekwerk,
    ],
  );
}
```

### Step 4: Access in Widgets

```dart
@override
Widget build(BuildContext context) {
  // Access colors
  final colors = context.katjasKleurPlaat;
  final primaryColor = colors.primary.color;
  final surfaceBg = colors.surface.color;
  final errorColor = colors.error.color;

  // Access typography
  final typography = context.katjasBoekwerk;
  final titleStyle = typography.titleLarge; // Handschrift

  return Container(
    color: surfaceBg,
    child: Text(
      'Hello',
      style: titleStyle, // or titleStyle?.bold, titleStyle?.link
    ),
  );
}
```

### Step 5: Use BoekwerkDecorator for Pre-Colored Text

The `BoekwerkDecorator` combines typography + colors into a single access point:

```dart
@override
Widget build(BuildContext context) {
  final textThemes = context.katjasBoekwerkDecorator;

  return Column(
    children: [
      // Body text with primary color applied
      Text('Primary text', style: textThemes.bodyMedium?.primary.color),

      // Title with surface contrast color
      Text('Title', style: textThemes.titleLarge?.surface.onColorContrast),

      // Error text
      Text('Error!', style: textThemes.bodySmall?.error.color),

      // Bold variant with primary color
      Text('Bold primary', style: textThemes.labelLarge?.primary.color.bold),
    ],
  );
}
```

## Complete Example

```dart
// lib/core/theme/app_theme.dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/style/text_style/handschrift.dart';
import 'package:dcc_toolkit/style/text_style/katjas_boekwerk.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    final kleurplaat = _lightKleurplaat;
    final boekwerk = _boekwerk;

    return ThemeData(
      useMaterial3: true,
      colorScheme: kleurplaat.toColorScheme(brightness: Brightness.light),
      textTheme: boekwerk.asTextTheme(
        bodyColor: kleurplaat.surface.onColorContrast,
      ),
      extensions: [kleurplaat, boekwerk],
    );
  }

  static final _lightKleurplaat = KatjasKleurplaat(
    primary: const ColorGroup(color: Color(0xFF6750A4), onColorContrast: Color(0xFFFFFFFF)),
    primaryFill: const ColorGroup(color: Color(0xFFEADDFF), onColorContrast: Color(0xFF6750A4)),
    content: const ColorGroup(color: Color(0xFF1D1B20), onColorContrast: Color(0xFFFFFFFF)),
    contentFill: const ColorGroup(color: Color(0xFFE6E0E9), onColorContrast: Color(0xFF1D1B20)),
    error: const ColorGroup(color: Color(0xFFB3261E), onColorContrast: Color(0xFFFFFFFF)),
    errorFill: const ColorGroup(color: Color(0xFFF9DEDC), onColorContrast: Color(0xFFB3261E)),
    success: const ColorGroup(color: Color(0xFF198754), onColorContrast: Color(0xFFFFFFFF)),
    successFill: const ColorGroup(color: Color(0xFFD1E7DD), onColorContrast: Color(0xFF198754)),
    surface: const SurfaceGroup(
      color: Color(0xFFFEF7FF),
      onColorContrast: Color(0xFF1D1B20),
      onColorContrastDim: Color(0xFF49454F),
      onColorSubtle: Color(0xFF79747E),
      onColorSubtleDim: Color(0xFFCAC4D0),
      containerLowest: Color(0xFFFFFFFF),
      containerLow: Color(0xFFF7F2FA),
      container: Color(0xFFF3EDF7),
      containerHigh: Color(0xFFECE6F0),
      containerHighest: Color(0xFFE6E0E9),
      link: Color(0xFF6750A4),
    ),
    surfaceInverse: null,
  );

  static final _boekwerk = KatjasBoekwerk(
    displayLarge: const Handschrift(fontSize: 57, fontWeight: FontWeight.w400, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
    headlineMedium: const Handschrift(fontSize: 28, fontWeight: FontWeight.w400, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
    titleLarge: const Handschrift(fontSize: 22, fontWeight: FontWeight.w500, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
    titleMedium: const Handschrift(fontSize: 16, fontWeight: FontWeight.w500, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
    bodyLarge: const Handschrift(fontSize: 16, fontWeight: FontWeight.w400, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
    bodyMedium: const Handschrift(fontSize: 14, fontWeight: FontWeight.w400, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
    bodySmall: const Handschrift(fontSize: 12, fontWeight: FontWeight.w400, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
    labelLarge: const Handschrift(fontSize: 14, fontWeight: FontWeight.w500, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
    labelMedium: const Handschrift(fontSize: 12, fontWeight: FontWeight.w500, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
    labelSmall: const Handschrift(fontSize: 11, fontWeight: FontWeight.w500, boldStyle: TextStyle(fontWeight: FontWeight.w700)),
  );
}
```

```dart
// Usage in a widget
class ProfileCard extends StatelessWidget {
  const ProfileCard({required this.name, required this.email, super.key});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    final kleurplaat = context.katjasKleurPlaat;
    final textThemes = context.katjasBoekwerkDecorator;

    return Container(
      padding: Paddings.all16,
      decoration: BoxDecoration(
        color: kleurplaat.surface.containerLow,
        borderRadius: Radiuses.px12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: textThemes.titleLarge?.surface.onColorContrast),
          Margins.vertical4,
          Text(email, style: textThemes.bodyMedium?.surface.onColorSubtle),
        ],
      ),
    );
  }
}
```

## Common Patterns

### Dark Theme Support

Create a separate `KatjasKleurplaat` for dark mode and use `lerp()` for smooth transitions:

```dart
static ThemeData get dark {
  final kleurplaat = _darkKleurplaat;
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: kleurplaat.toColorScheme(brightness: Brightness.dark),
    extensions: [kleurplaat, _boekwerk],
  );
}
```

### Using `toColorScheme()` for Material Widgets

`KatjasKleurplaat.toColorScheme()` maps the palette to Flutter's `ColorScheme`:
- `primary` -> `ColorScheme.primary`
- `content` -> `ColorScheme.secondary`
- `error` -> `ColorScheme.error`
- `surface` -> `ColorScheme.surface`

This ensures Material widgets (buttons, cards, etc.) respect your palette automatically.

### Using Handschrift's `.bold` and `.link` Variants

```dart
// Bold text
Text('Important', style: context.katjasBoekwerk.bodyLarge?.bold);

// Link-styled text
Text('Tap here', style: context.katjasBoekwerk.bodyMedium?.link);
```

### Converting Handschrift from an Existing TextStyle

```dart
final existing = TextStyle(fontSize: 16, color: Colors.black);
final handschrift = Handschrift.fromTextStyle(
  existing,
  boldStyle: const TextStyle(fontWeight: FontWeight.w700),
  linkStyle: const TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
);
```

## Feedback Loop

After implementing:

1. Run `dart analyze` -- ensure no lint errors.
2. Run the app -- verify text renders with correct sizes, weights, and colors.
3. Check that `context.katjasKleurPlaat` and `context.katjasBoekwerk` do not throw (they use `!` assertion, so missing extensions will crash at runtime).
4. If using dark mode -- toggle themes and verify `lerp()` animates smoothly.
5. Verify Material widgets (buttons, AppBar, etc.) pick up colors from `toColorScheme()`.
