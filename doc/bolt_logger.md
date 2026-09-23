# ⚡️ BoltLogger!
_**Super charge your logging and zap logs like Zeus with the BoltLogger.**_

## 🚀 Features
 - Built on top of the `logging` package. Meaning package that use the `logging` package will also be visible in the BoltLogger.
 - Easy to use and setup.
 - Supports multiple charges (log outputs).
 - Supports multiple log levels.
 - Has extension methods for easy logging, with include reference to the calling class.

## 🛠 Setup
To use the `BoltLogger`, you need to charge the logger with a `BoltCharge`.

```dart
BoltLogger.charge(DebugConsoleCharge());
```

Available charges:
 - `DebugConsoleCharge`: Logs output to the console.
 - `FileCharge`: Logs output to a file.
 - `MemoryCharge`: Keeps track of logs in memory.

## 📝 Zapping! (Usage)
The `BoltLogger` aims to be easy to use. Once `BoltLogger` is charged you can start zapping logs! By zapping we mean literally calling `zap`.

Logging a message in `BoltLogger` is as simple as calling the `zap` method.

```dart
class MyAwesomeClass{
  void doSomething() {
   zap('This is a message');
  }
}
```

`BoltLogger` offers `zap` as a extension on `Object` meaning you can call `zap` on or in any object. 
Because it's an extension we can automatically include the `runtimeType` of the object that called `zap` as tag for the log message.

Just as Zeus when zapping your not only limited to only zap `String`s, you can zap any object. For example: Exceptions, Errors, StackTrace. BoltLogger will take care of the objects accordingly.

Beside zapping messages you can also provide a custom `tag` and `level` to the `zap` method.

Next to `zap` there are two intensities available:
 - `surge`: zaps a log at `Level.WARNING`, for things that are off but not fatal.
 - `shock`: a zap intensified, zaps a log at `Level.SEVERE`.

Both take the same arguments as `zap`, so you can pass a message, an `Exception`/`Error`, a `StackTrace` or a `List` combining them.

If the extension methods are not available you can call `BoltLogger.zap`, `BoltLogger.surge` or `BoltLogger.shock` directly.

## 🎨 Colors in the console
The `DebugConsoleCharge` colors its output when the terminal supports ANSI escapes:
 - 🔴 Red: `Level.SEVERE` and up, or any log that carries an error or stack trace.
 - 🟡 Yellow: `Level.WARNING` logs without an error or stack trace (a `surge`).
 - ⚪️ Default: everything else.

## 📦 Example
```dart

class MyAwesomeClass{
  void doSomething() {
    zap('This is a message');
  }

  void doSomethingRisky() {
    surge('This is not looking good...');
  }

  void doSomethingElse() {
    shock(Exception('Shocking!'));
  }
}

void main() {
  BoltLogger.charge(DebugConsoleCharge());
  
  final myAwesomeClass = MyAwesomeClass();
  myAwesomeClass.doSomething();
  myAwesomeClass.doSomethingRisky();
  myAwesomeClass.doSomethingElse();
}
```