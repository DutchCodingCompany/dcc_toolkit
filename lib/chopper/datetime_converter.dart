import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

enum _DateFormats {
  yyyyMMdd,
// Name contains the exact pattern for date formatting.
//ignore: constant_identifier_names
  HHmm,
}

final DateFormat _yyyyMMdd = DateFormat('yyyy-MM-dd');
// Name contains the exact pattern for date formatting.
//ignore: non_constant_identifier_names
final DateFormat _HHmm = DateFormat('HH:mm');

String _format(DateTime time, _DateFormats format) {
  switch (format) {
    case _DateFormats.yyyyMMdd:
      return _yyyyMMdd.format(time);
    case _DateFormats.HHmm:
      return _HHmm.format(time);
  }
}

DateTime _parse(String time, _DateFormats format) {
  switch (format) {
    case _DateFormats.yyyyMMdd:
      return _yyyyMMdd.parse(time);
    case _DateFormats.HHmm:
      return _HHmm.parse(time);
  }
}

/// DateTimeConverter that parses and formats dates in the selected format.
/// For example:
/// ```dart
/// class Example {
/// const Example(this.date);
/// @DateTimeConverter.yyyyMMdd()
/// final DateTime date;
/// }
class DateTimeConverter implements JsonConverter<DateTime, String> {
  /// Creates a DateTimeConverter that parses and formats dates in the format yyyy-MM-dd.
  const DateTimeConverter.yyyyMMdd() : _dateFormat = _DateFormats.yyyyMMdd;

  /// Creates a DateTimeConverter that parses and formats dates in the format HH:mm.
  // Name contains the exact pattern for date formatting.
  //ignore: non_constant_identifier_names
  const DateTimeConverter.HHmm() : _dateFormat = _DateFormats.HHmm;

  final _DateFormats _dateFormat;

  @override
  DateTime fromJson(String json) {
    return _parse(json, _dateFormat);
  }

  @override
  String toJson(DateTime time) {
    return _format(time, _dateFormat);
  }
}
