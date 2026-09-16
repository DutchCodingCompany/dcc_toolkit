/// A type representing an empty response body.
///
/// Aliased to `dynamic` so chopper can handle empty (e.g. 204) response
/// bodies without requiring a registered `fromJson` factory.
typedef NoContent = dynamic;
