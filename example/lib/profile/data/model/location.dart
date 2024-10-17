import 'package:freezed_annotation/freezed_annotation.dart';

import 'street.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  const factory Location({
    required Street street,
    required String city,
    required String state,
    required String country,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
