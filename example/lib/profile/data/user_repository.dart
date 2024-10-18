import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:injectable/injectable.dart';

import 'model/api_user_response.dart';
import 'user_service.dart';

@lazySingleton
class UserRepository {
  const UserRepository(this._userService);

  final UserService _userService;

  Future<Result<ApiUserResponse>> getRandomUser() async {
    return tryCall(() => _userService.getRandomUser());
  }

  Future<Result<ApiUserResponse>> getRandomUserFails() async {
    return tryCall(() => _userService.getRandomUserFails());
  }
}
