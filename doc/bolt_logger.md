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

`BoltLogger` offer `zap` as a extension on `Object` meaning you can call `zap` on or in any object. 
Because it's an extension we can automatically include the `runtimeType` of the object that called `zap` as tag for the log message.

Just as Zeus when zapping your not only limited to only zap `String`s, you can zap any object. For example: Exceptions, Errors, StackTrace. BoltLogger will take care of the objects accordingly.

Beside zapping messages you can also provide a custom `tag` and `level` to the `zap` method.

`BoltLogger` also offers a `shock` to zap logs with at a `Level.SERVERE` level.

If the extension methods are not available you can call `BoltLogger.zap` directly.

## 📦 Example
```dart

class MyAwesomeClass{
  void doSomething() {
    zap('This is a message');
  }
  
  void doSomethingElse() {
    shock(Exception('Shocking!'));
  }
}

void main() {
  BoltLogger.charge(DebugConsoleCharge());
  
  final myAwesomeClass = MyAwesomeClass();
  myAwesomeClass.doSomething();
  myAwesomeClass.doSomethingElse();
}
```