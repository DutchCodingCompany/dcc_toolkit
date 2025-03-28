/// StackTrace extension methods.
extension ZapStackTraceExtension on StackTrace {
  /// Strike the [StackTrace] which will format it so that it's easier to read.
  String get strike => toString()
      .split('\n')
      .map((e) => e.isNotEmpty && e.startsWith('#') ? e.replaceAll(RegExp(r'\s\s+'), ' ') : null)
      .whereType<String>()
      .join('\n');
}
