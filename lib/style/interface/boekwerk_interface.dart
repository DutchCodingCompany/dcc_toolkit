import 'package:dcc_toolkit/style/text_style/handschrift.dart';
import 'package:flutter/material.dart';

/// An abstract interface that defines a typography scale contract.
///
/// This interface provides a standardized set of text style getters following
/// a hierarchical typography system. Implementations can use any type [T] to
/// represent text styles (e.g., [TextStyle], [Handschrift], or custom types).
///
/// The naming follows Material Design typography conventions with additional
/// custom categories like [navbar] and [subtitleLarge]/[subtitleMedium]/[subtitleSmall] variants.
///
/// ## Typography Categories
///
/// - **Display**: Largest text styles, used for hero sections or prominent headings
/// - **Subtitle**: Secondary text styles for subtitles and supporting content
/// - **Headline**: Section headers and important callouts
/// - **Title**: Component titles and smaller headers
/// - **Body**: Main content text for paragraphs and descriptions
/// - **Label**: Small text for buttons, tabs, and form labels
/// - **Navbar**: Navigation bar specific styling
///
/// ## Example
///
/// ```dart
/// class MyTypography implements BoekwerkInterface<TextStyle> {
///   @override
///   TextStyle? get displayLarge => TextStyle(fontSize: 57);
///   // ... other implementations
/// }
/// ```
abstract interface class BoekwerkInterface<T> {
  /// Creates a new [BoekwerkInterface] instance.
  BoekwerkInterface();

  /// The largest display text style.
  ///
  /// Typically used for short, important text like hero headers.
  T? get displayLarge;

  /// The medium display text style.
  ///
  /// Used for prominent text that is slightly smaller than [displayLarge].
  T? get displayMedium;

  /// The smallest display text style.
  ///
  /// Used for emphasized text that still needs to stand out.
  T? get displaySmall;

  /// The largest subtitle text style.
  ///
  /// Used for prominent secondary text or large subtitles.
  T? get subtitleLarge;

  /// The medium subtitle text style.
  ///
  /// Used for standard secondary text and subtitles.
  T? get subtitleMedium;

  /// The smallest subtitle text style.
  ///
  /// Used for compact secondary text.
  T? get subtitleSmall;

  /// The largest headline text style.
  ///
  /// Used for section headers and important callouts.
  T? get headlineLarge;

  /// The medium headline text style.
  ///
  /// Used for sub-section headers.
  T? get headlineMedium;

  /// The smallest headline text style.
  ///
  /// Used for smaller section divisions.
  T? get headlineSmall;

  /// The largest title text style.
  ///
  /// Used for component titles and card headers.
  T? get titleLarge;

  /// The medium title text style.
  ///
  /// Used for list item titles and smaller component headers.
  T? get titleMedium;

  /// The smallest title text style.
  ///
  /// Used for compact titles and inline headers.
  T? get titleSmall;

  /// The largest body text style.
  ///
  /// Used for emphasized paragraph text.
  T? get bodyLarge;

  /// The medium body text style.
  ///
  /// The default text style for most content.
  T? get bodyMedium;

  /// The smallest body text style.
  ///
  /// Used for secondary or less important content.
  T? get bodySmall;

  /// The largest label text style.
  ///
  /// Used for prominent buttons and action items.
  T? get labelLarge;

  /// The medium label text style.
  ///
  /// Used for standard buttons, tabs, and form labels.
  T? get labelMedium;

  /// The smallest label text style.
  ///
  /// Used for compact labels and captions.
  T? get labelSmall;

  /// The navigation bar text style.
  ///
  /// Used specifically for navigation bar items and labels.
  T? get navbar;
}
