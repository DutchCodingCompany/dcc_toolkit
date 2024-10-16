import 'package:chopper/chopper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'model/api_user_response.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: 'https://randomuser.me/api/')
@singleton
abstract class UserService extends ChopperService {
  @Get()
  Future<ApiUserResponse> getRandomUser();

  @Get()
  Future<ApiUserResponse> getRandomUserFails() {
    throw CheckedFromJsonException({}, null, '', '');
  }

  @factoryMethod
  static UserService create(ChopperClient client) => _$UserService(client);
}
