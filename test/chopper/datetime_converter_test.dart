import 'package:dcc_toolkit/chopper/datetime_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('yyyyMMdd tests', () {
    const converter = DateTimeConverter.yyyyMMdd();
    final date = DateTime(2021);
    const dateString = '2021-01-01';

    expect(converter.toJson(date), dateString);
    expect(converter.fromJson(dateString), date);
  });

  test('HHmm tests', () {
    const converter = DateTimeConverter.HHmm();
    final date = DateTime(1970, 1, 1, 10,30);
    const dateString = '10:30';

    expect(converter.toJson(date), dateString);
    expect(converter.fromJson(dateString), date);
  });
}
