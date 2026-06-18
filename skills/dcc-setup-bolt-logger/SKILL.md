---
name: dcc-setup-bolt-logger
description: Set up and configure BoltLogger for structured logging with charges (DebugConsole, File, Memory). Use when adding logging, setting up error tracking, adding an in-app log viewer, or bootstrapping a Flutter app with error handling.
metadata:
  last_modified: 2025-06-18
---

# Set Up BoltLogger

## Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Core Concepts](#core-concepts)
- [Workflow](#workflow)
- [Complete Example](#complete-example)
- [Common Patterns](#common-patterns)
- [Feedback Loop](#feedback-loop)

## Overview

BoltLogger is the DCC toolkit's structured logging system built on top of the `logging` package. It uses a "charge" architecture where output backends (charges) can be plugged in independently. The system supports:

- **DebugConsoleCharge** -- prints to the debug console with ANSI color for errors (only in debug mode)
- **FileCharge** -- writes logs to a file with buffering and periodic flushing
- **MemoryCharge** -- stores logs in memory for display via `BoltLoggerView`
- **ZapExtension** -- adds `zap()` and `shock()` methods to any object
- **runAppBootstrap()** -- wraps your app in error handling zones that auto-log with BoltLogger

## Prerequisites

The project must depend on `dcc_toolkit`. BoltLogger is exported from the main barrel file:

```dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
```

For `runAppBootstrap()` (not in the barrel), import directly:

```dart
import 'package:dcc_toolkit/common/run_app_bootstrap.dart';
```

## Core Concepts

| Class | Role |
|-------|------|
| `BoltLogger` | Singleton logger. Static methods: `charge()`, `zap()`, `shock()`, `discharge()`, `getCharge()` |
| `BoltCharge` | Interface for log output backends. Requires `name`, `logOutput(ZapEvent)`, `discharge()` |
| `DebugConsoleCharge` | Prints logs via `debugPrint`. ANSI red for errors. Only active in `kDebugMode` |
| `FileCharge` | Writes to `{path}/{yyyy-MM-dd}.log`. Buffers up to `bufferSize` lines, flushes every `writeDelay` |
| `MemoryCharge` | Stores up to `maxItems` events in memory. Exposes `stream` and `items` for UI display |
| `ZapEvent` | Wraps a `LogRecord` with pre-formatted `lines` (List<String>) |
| `ZapExtension` | Extension on `Object` adding `zap()` and `shock()` using `runtimeType` as tag |
| `ZapStackTraceExtension` | Extension on `StackTrace` with `strike` getter for cleaned formatting |
| `BoltLoggerView` | Widget that renders in-app logs from a `MemoryCharge` via `StreamBuilder` + `ListView` |
| `runAppBootstrap()` | Runs app inside `runZonedGuarded` with `FlutterError.onError`, defaults to `BoltLogger.shock()` |

### Log Levels

- `BoltLogger.zap(message)` -- logs at `Level.INFO` (general information)
- `BoltLogger.shock(message)` -- logs at `Level.SEVERE` (errors, exceptions)

### Message Types

The `message` parameter accepts:
- `String` -- simple text
- `Exception` or `Error` -- logged as the error field
- `StackTrace` -- logged as the stacktrace field
- `List` -- a list containing one of each (Object?, Exception/Error, StackTrace)

## Workflow

**Task Progress:**
- [ ] 1. Set up `runAppBootstrap()` in `main.dart`
- [ ] 2. Configure charges based on environment
- [ ] 3. Add logging calls (`zap`/`shock`) to business logic
- [ ] 4. (Optional) Add `BoltLoggerView` for in-app log viewing
- [ ] 5. Verify logs appear in console/file/viewer

### Step 1: Set Up `runAppBootstrap()`

Replace your `main()` function to use `runAppBootstrap()`. This wraps the app in `runZonedGuarded` and catches all Flutter errors automatically.

```dart
import 'package:dcc_toolkit/common/run_app_bootstrap.dart';
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await runAppBootstrap(() async {
    // Initialize charges BEFORE building the app
    BoltLogger.charge([
      const DebugConsoleCharge(),
      // Add more charges as needed
    ]);

    // Any other initialization (DI, etc.)
    return const MyApp();
  });
}
```

If you need custom error handling in addition to BoltLogger:

```dart
Future<void> main() async {
  await runAppBootstrap(
    () async {
      BoltLogger.charge([const DebugConsoleCharge()]);
      return const MyApp();
    },
    onError: (error, stackTrace) {
      BoltLogger.shock([error, stackTrace]);
      // Additional error reporting (e.g., Sentry, Crashlytics)
    },
  );
}
```

### Step 2: Configure Charges

Choose charges based on the app's needs:

**Debug only (most common starting point):**
```dart
BoltLogger.charge([const DebugConsoleCharge()]);
```

**Debug + file logging (for QA builds):**
```dart
BoltLogger.charge([
  const DebugConsoleCharge(),
  FileCharge(
    '/path/to/logs', // e.g., from path_provider: getApplicationDocumentsDirectory()
    bufferSize: 500,
    writeDelay: const Duration(seconds: 10),
  ),
]);
```

**Debug + in-app viewer (for dev builds):**
```dart
BoltLogger.charge([
  const DebugConsoleCharge(),
  MemoryCharge(maxItems: 500),
]);
```

**All three (full setup):**
```dart
BoltLogger.charge([
  const DebugConsoleCharge(),
  FileCharge(documentsPath),
  MemoryCharge(),
]);
```

### Step 3: Add Logging Calls

**Using static methods (anywhere):**
```dart
BoltLogger.zap('User logged in', tag: 'AuthService');
BoltLogger.shock(['Payment failed', exception, stackTrace], tag: 'PaymentService');
```

**Using the ZapExtension (inside classes):**
```dart
class UserRepository {
  Future<void> fetchUser() async {
    zap('Fetching user...'); // tag = 'UserRepository' (from runtimeType)
    try {
      // ...
    } catch (e, s) {
      shock([e, s]); // tag = 'UserRepository'
    }
  }
}
```

### Step 4: Add BoltLoggerView (Optional)

Create a debug page that shows logs in-app:

```dart
class DebugLogPage extends StatelessWidget {
  const DebugLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logs')),
      body: const BoltLoggerView(),
    );
  }
}
```

`BoltLoggerView` automatically finds the registered `MemoryCharge`. If one does not exist, it creates and registers one.

### Step 5: Cleanup on App Disposal

Call `discharge()` when the app is shutting down (e.g., in a top-level widget's `dispose`):

```dart
BoltLogger.discharge(); // Cancels subscription, flushes FileCharge, closes MemoryCharge stream
```

## Complete Example

```dart
// main.dart
import 'package:dcc_toolkit/common/run_app_bootstrap.dart';
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  await runAppBootstrap(() async {
    final docsDir = await getApplicationDocumentsDirectory();

    BoltLogger.charge([
      const DebugConsoleCharge(),
      FileCharge('${docsDir.path}/logs'),
      MemoryCharge(maxItems: 1000),
    ]);

    BoltLogger.zap('App starting up', tag: 'Bootstrap');

    return const MyApp();
  });
}
```

```dart
// some_cubit.dart
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SomeCubit extends Cubit<SomeState> {
  SomeCubit(this._repository) : super(const SomeState.initial());

  final SomeRepository _repository;

  Future<void> loadData() async {
    zap('Loading data...'); // Uses ZapExtension, tag = 'SomeCubit'

    final result = await _repository.getData();
    result.when(
      success: (data) {
        zap('Loaded ${data.length} items');
        emit(state.copyWith(items: data));
      },
      error: (error) {
        shock(['Failed to load data', error]);
        emit(state.copyWith(hasError: true));
      },
    );
  }
}
```

## Common Patterns

### Custom BoltCharge Implementation

Create a custom charge to send logs to an external service:

```dart
class CrashlyticsCharge implements BoltCharge {
  @override
  String get name => 'CrashlyticsCharge';

  @override
  void logOutput(ZapEvent event) {
    if (event.origin.level.value >= Level.SEVERE.value) {
      FirebaseCrashlytics.instance.recordError(
        event.origin.error,
        event.origin.stackTrace,
      );
    }
  }

  @override
  void discharge() {}
}
```

### Retrieving a Specific Charge

```dart
final memoryCharge = BoltLogger.getCharge('MemoryCharge') as MemoryCharge?;
final allLogs = memoryCharge?.items ?? [];
```

### Formatted Stack Traces

Use the `ZapStackTraceExtension` to clean up stack traces:

```dart
try {
  // ...
} catch (e, stackTrace) {
  final cleanTrace = stackTrace.strike; // Formatted, single-spaced lines
  BoltLogger.shock([e, stackTrace]);
}
```

## Feedback Loop

After implementing:

1. Run `dart analyze` -- ensure no lint errors from the new logging code.
2. Run the app in debug mode -- confirm logs appear in the debug console with the `⚡[HH:mm] I/Tag: message` format.
3. If using `FileCharge` -- verify the log file is created at the expected path.
4. If using `BoltLoggerView` -- navigate to the debug page and confirm logs are streaming.
5. Trigger an error -- confirm `shock()` messages appear in red (ANSI terminals) and include error + stack trace.
