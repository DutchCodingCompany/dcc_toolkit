/// A class representing an empty response body.
class NoContent {
  /// Creates a new [NoContent] instance.
  const NoContent();

  /// Creates a new [NoContent] instance from a json map.
  // ignore unused parameter in factory constructor. This is done to match the method signature of the converter.
  //ignore: avoid_unused_constructor_parameters
  factory NoContent.fromJson(Map<String, dynamic> json) => const NoContent();
}
