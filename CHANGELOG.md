# Changelog

## 0.2.0
* **Breaking:** Showcase explanations no longer open by themselves. The visitor opens them with the info button, or the website does with `ShowcaseState.tour`. `hasSeenHighlights` and `markHighlightsSeen` are removed
* **Breaking:** Showcase explanations follow the style of Dutch Coding Company instead of the theme of the app, dim the app around the target with a cutout and stop touches outside it. Pass `fontFamily` to `ShowcaseScope` for DM Sans
* **Breaking:** Showcase notices follow that style as well. `ShowcaseScope.noticeBuilder` is removed
* **Breaking:** Removed the end of the showcase story: `FinishPrompt`, `ShowcaseState.finish`, `begin`, `reset`, `resetData`, `isFinished`, `takeFinishPrompt` and the strings of the finish dialog. `ShowcaseState` is no longer abstract; a demo that should start over resets its own data
* **Breaking:** `ShowcaseState` takes the whole `ShowcaseConfig` (`DemoState(config: config)`) instead of `highlightsEnabled`, and `ShowcaseShell` reads its insets from it
* Added the `?tour=host` url parameter and `ShowcaseConfig.tourOnHost`: the page around the demo starts the explanations through `postMessage`, see [doc/showcase.md](doc/showcase.md)
* Documented `overscroll-behavior: none` in `web/index.html`, so scrolling over an embedded showcase never scrolls the website

## 0.1.2
* Added `removeShowcaseSplash` to show the splash of the app from `web/index.html` while the showcase loads, for at least a fixed duration, and the `?splash=off` url parameter

## 0.1.1
* Added the showcase kit, building blocks for a clickable web demo of an app made from its real screens. Import it with `package:dcc_toolkit/showcase.dart`, see [doc/showcase.md](doc/showcase.md)
* Added the `dcc-toolkit-create-showcase` agent skill for setting up a showcase app

## 0.1.0
* **Breaking:** Requires Flutter `>=3.47.0` and Dart `^3.13.0`
* **Breaking:** Migrated from `package:flutter/material.dart` / `package:flutter/cupertino.dart` to the `material_ui` and `cupertino_ui` packages. Apps must migrate as well, see [doc/migrate_to_material_ui.md](doc/migrate_to_material_ui.md)
* Migrated classes to primary constructors; the public API is unchanged

## 0.0.22
* Added `BoltLogger.surge` and the `surge` extension method for logging at `Level.WARNING`, completing the `zap` (info) / `surge` (warning) / `shock` (severe) trio
* `DebugConsoleCharge` now prints warning level logs in yellow; severe logs and logs carrying an error or stack trace remain red
* `JsonSerializableConverter` now uses `BoltLogger.surge` for `JsonConverterException` logging

## 0.0.21
* Changed `NoContent` to a typedef for `dynamic` to fix chopper integration with empty response bodies
* `JsonSerializableConverter` now throws a `JsonConverterException` instead of a `JsonUnsupportedObjectError`, so it can be caught by `tryCall`
* Exported `base_error.dart` so `BaseError` and its subtypes are reachable from the package barrel
* `JsonSerializableConverter` now logs deserialization failures via `BoltLogger`, tagged with the target type: `CheckedFromJsonException` at severe level (rethrown), `JsonConverterException` at warning level

## 0.0.20
* Fixed bug in handschrift copyWith
* Fixed minor bugs in BoltLogger

## 0.0.19 
* Added extra surface group colors, added extra accent and accentFill color groups

## 0.0.18
* Made `AnnotatedText` accessible

## 0.0.17
* Added debouncer
* Added all sizes, paddings, radiusses and dimensions
* Made textAlign available for AnnotatedText widget

## 0.0.16
* Added PaginationStateView
* Added AnnotatedText
* Added native dialog button text styling
* Added PaginationState equality operator and hashCode

## 0.0.15
* Added `FutureOr<T?>` to `showNativeDialog` as return type;

## 0.0.14
* Added Pagination 
* Added RefreshStreamMixin

## 0.0.13
* Added automatic closing of native dialog.

## 0.0.12
* Updated dependencies
* Added test_util: catch presentation event helper, DeviceSizes
* Added typedef for single bool methods.
* Updated formatting
* exported more files

## 0.0.11
Added optional secondary, secondaryFill, tertiary and tertiaryFill ColorGroups to the Kleurplaat

## 0.0.10
Improved kleurplaat

## 0.0.9
Added kleurplaat

## 0.0.6

* :sparkles: Added new version of Result for mapping API responses
* :sparkles: Added BlocfulWidget for listening to presentation changes and state changes
* :sparkles: Added example project

## 0.0.6

* :arrow_up: Updated dependencies

## 0.0.5

* :bug: Exported addBetween function.

## 0.0.4

* :arrow_up: Updated dependencies

## 0.0.3

* :sparkles: Added addBetween iterable extension by @Guldem in https://github.com/DutchCodingCompany/dcc_toolkit/pull/3
* :zap: Bolt logger by @Guldem in https://github.com/DutchCodingCompany/dcc_toolkit/pull/4
* :sparkles: Bootstrap for running flutter apps by @Guldem in https://github.com/DutchCodingCompany/dcc_toolkit/pull/5

## 0.0.2

- Updated dependencies

## 0.0.1

- Initial release
