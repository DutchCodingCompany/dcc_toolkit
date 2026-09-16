import 'package:chopper/chopper.dart' hide Level;
import 'package:dcc_toolkit/chopper/json_converter_exception.dart';
import 'package:dcc_toolkit/chopper/json_serializable_converter.dart';
import 'package:dcc_toolkit/chopper/no_content.dart';
import 'package:dcc_toolkit/logger/bolt_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart' show CheckedFromJsonException;
import 'package:logging/logging.dart';

void main() {
  final baseResponse = http.Response('', 200);

  late MemoryCharge memoryCharge;

  setUp(() {
    memoryCharge = MemoryCharge();
    BoltLogger.charge([memoryCharge]);
  });

  tearDown(BoltLogger.discharge);

  test('Error is thrown when factory is missing', () async {
    final response = Response(baseResponse, '{"name":"John"}');

    const converter = JsonSerializableConverter({});

    await expectLater(
      converter.convertResponse<TestModel, TestModel>(response),
      throwsA(isA<JsonConverterException>()),
    );

    expect(memoryCharge.items.length, 1);
    expect(memoryCharge.items[0].origin.level, Level.WARNING);
    expect(memoryCharge.items[0].origin.loggerName, 'TestModel');
    expect(memoryCharge.items[0].origin.error, isA<JsonConverterException>());
  });

  test('Error is thrown when wrong factory is added', () async {
    final response = Response(baseResponse, '{"name":"John"}');

    const converter = JsonSerializableConverter({TestModel: TestModel2.fromJson});

    await expectLater(
      converter.convertResponse<TestModel, TestModel>(response),
      throwsA(isA<JsonConverterException>()),
    );

    expect(memoryCharge.items.length, 1);
    expect(memoryCharge.items[0].origin.level, Level.WARNING);
    expect(memoryCharge.items[0].origin.loggerName, 'TestModel');
    expect(memoryCharge.items[0].origin.error, isA<JsonConverterException>());
  });

  test('CheckedFromJsonException is logged and rethrown', () async {
    final response = Response(baseResponse, '{"name":"John"}');

    const converter = JsonSerializableConverter({ThrowingModel: ThrowingModel.fromJson});

    await expectLater(
      converter.convertResponse<ThrowingModel, ThrowingModel>(response),
      throwsA(isA<CheckedFromJsonException>()),
    );

    expect(memoryCharge.items.length, 1);
    expect(memoryCharge.items[0].origin.level, Level.SEVERE);
    expect(memoryCharge.items[0].origin.loggerName, 'ThrowingModel');
    expect(memoryCharge.items[0].origin.error, isA<CheckedFromJsonException>());
    expect(memoryCharge.items[0].origin.stackTrace, isNotNull);
  });

  test('Uses model to convert json into model', () async {
    final response = Response(baseResponse, '{"name":"John"}');

    const converter = JsonSerializableConverter({TestModel: TestModel.fromJson});

    final result = await converter.convertResponse<TestModel, TestModel>(response);

    expect(result.body?.name, 'John');
    expect(memoryCharge.items, isEmpty);
  });

  test('Uses model to convert json into List<model>', () async {
    final response = Response(baseResponse, '[{"name":"John"},{"name":"John2"}]');

    const converter = JsonSerializableConverter({TestModel: TestModel.fromJson});

    final result = await converter.convertResponse<List<TestModel>, TestModel>(response);

    expect(result.body?[0].name, 'John');
    expect(result.body?[1].name, 'John2');
  });

  test('Handles an empty body for NoContent without a registered factory', () async {
    final response = Response(baseResponse, '');

    const converter = JsonSerializableConverter({});

    final result = await converter.convertResponse<NoContent, NoContent>(response);

    expect(result.body, '');
  });

  test('Returns the raw body for NoContent when the response is not empty', () async {
    final response = Response(baseResponse, '{"name":"John"}');

    const converter = JsonSerializableConverter({});

    final result = await converter.convertResponse<NoContent, NoContent>(response);

    expect(result.body, {'name': 'John'});
  });
}

class TestModel {
  TestModel(this.name);

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(json['name'] as String);

  final String name;

  Map<String, dynamic> toJson() => {'name': name};
}

class TestModel2 {
  TestModel2(this.name);

  factory TestModel2.fromJson(Map<String, dynamic> json) => TestModel2(json['name'] as String);

  final String name;

  Map<String, dynamic> toJson() => {'name': name};
}

class ThrowingModel {
  factory ThrowingModel.fromJson(Map<String, dynamic> json) =>
      throw CheckedFromJsonException(json, 'name', 'ThrowingModel', 'invalid');
}
