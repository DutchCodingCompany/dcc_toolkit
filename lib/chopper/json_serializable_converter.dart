import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:dcc_toolkit/chopper/json_converter_exception.dart';
import 'package:dcc_toolkit/logger/bolt_logger.dart';
import 'package:json_annotation/json_annotation.dart' show CheckedFromJsonException;

/// Method signature for a function that creates a dart object from a json map.
typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

/// JsonSeriablizableConverter
/// Converter for chopper to convert json response to a dart object using json_serializable.
/// Based of: https://hadrien-lejard.gitbook.io/chopper/faq#write-a-custom-jsonconverter
class JsonSerializableConverter extends JsonConverter {
  /// Creates a new JsonSerializableConverter
  const JsonSerializableConverter(this.factories);

  /// The factories to use for decoding the json responses.
  /// For example:
  /// ```dart
  /// final jsonConverter = JsonSerializableConverter({
  ///  User: User.fromJson,
  ///  });
  ///  ```
  final Map<Type, JsonFactory<dynamic>> factories;

  Never _logAndThrow<T>(String message) {
    final exception = JsonConverterException(T, message: message);
    BoltLogger.surge(exception, tag: '$T');

    throw exception;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null) {
      _logAndThrow<T>('No fromJson was registered for JsonSerializableConverter for $T');
    }
    if (jsonFactory is! JsonFactory<T>) {
      _logAndThrow<T>('fromJson type does not match $T');
    }

    try {
      return jsonFactory(values);
    } on CheckedFromJsonException catch (e, stackTrace) {
      BoltLogger.shock([e, stackTrace], tag: '$T');
      rethrow;
    }
  }

  List<T> _decodeList<T>(Iterable<dynamic> values) => values.nonNulls.map<T>((v) => _decode<T>(v) as T).toList();

  dynamic _decode<T>(dynamic entity) {
    if (T == dynamic) return entity;

    if (entity is Iterable) return _decodeList<T>(entity as List);

    if (entity is Map) return _decodeMap<T>(entity as Map<String, dynamic>);

    return entity;
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(Response<dynamic> response) async {
    final jsonRes = await super.convertResponse<dynamic, dynamic>(response);

    return jsonRes.copyWith<BodyType>(body: _decode<InnerType>(jsonRes.body) as BodyType);
  }
}
