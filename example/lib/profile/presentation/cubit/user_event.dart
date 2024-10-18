sealed class UserEvent {
  final String reason = '';
}

class UserLoaded implements UserEvent {
  const UserLoaded();

  @override
  String get reason => 'User loaded';
}

class UserFetchFailed implements UserEvent {
  const UserFetchFailed();

  @override
  String get reason => 'User fetch failed';
}
