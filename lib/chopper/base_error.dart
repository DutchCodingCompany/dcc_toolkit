/// Interface for the errors that could be returned
interface class BaseError {}

/// The device is not connected error
class NoInternetError implements BaseError {
  /// The device is not connected error
  const NoInternetError();
}

/// Http client error
class ServerError implements BaseError {
  /// Http client error
  const ServerError();
}

/// Unknown error
class UnknownError implements BaseError {
  /// Unknown error
  const UnknownError();
}

/// User not authenticated error
class AuthenticationFailedError implements BaseError {
  /// User not authenticated error
  const AuthenticationFailedError();
}
