/// Thrown when a json response cannot be converted to the expected type.
class const JsonConverterException(
  /// The type that could not be converted.
  final Type type, {

  /// A description of what went wrong.
  required final String message,
}) implements Exception {
  /// Creates a new [JsonConverterException].
  this;

  @override
  String toString() => 'JsonConverterException: $message';
}
