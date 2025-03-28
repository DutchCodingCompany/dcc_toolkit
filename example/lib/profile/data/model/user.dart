import 'package:freezed_annotation/freezed_annotation.dart';

import 'name.dart';
import 'location.dart';
import 'picture.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const factory User({
    required String gender,
    required Name name,
    required Location location,
    required String email,
    required String phone,
    required Picture picture,
    required String nat,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
