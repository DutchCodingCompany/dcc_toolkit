import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'api_user_response.freezed.dart';
part 'api_user_response.g.dart';

@freezed
sealed class ApiUserResponse with _$ApiUserResponse {
  const factory ApiUserResponse({
    required List<User> results,
  }) = _ApiUserResponse;

  factory ApiUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiUserResponseFromJson(json);
}
