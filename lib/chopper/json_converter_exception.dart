/// Thrown when a json response cannot be converted to the expected type.
class JsonConverterException implements Exception {
  /// Creates a new [JsonConverterException].
  const JsonConverterException(this.type, {required this.message});

  /// The type that could not be converted.
  final Type type;

  /// A description of what went wrong.
  final String message;

  @override
  String toString() => 'JsonConverterException: $message';
}
