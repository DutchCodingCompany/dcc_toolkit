import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:dcc_toolkit/chopper/json_serializable_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  final baseResponse = http.Response('', 200);

  test('Error is thrown when factory is missing', () {
    final response = Response(baseResponse, '{"name":"John"}');

    const converter = JsonSerializableConverter({});

    expect(() => converter.convertResponse<TestModel, TestModel>(response),
        throwsA(isA<JsonUnsupportedObjectError>()));
  });

  test('Error is thrown when wrong factory is added', () {
    final response = Response(baseResponse, '{"name":"John"}');

    const converter =
        JsonSerializableConverter({TestModel: TestModel2.fromJson});

    expect(() => converter.convertResponse<TestModel, TestModel>(response),
        throwsA(isA<JsonUnsupportedObjectError>()));
  });

  test('Uses model to convert json into model', () async {
    final response = Response(baseResponse, '{"name":"John"}');

    const converter =
        JsonSerializableConverter({TestModel: TestModel.fromJson});

    final result =
        await converter.convertResponse<TestModel, TestModel>(response);

    expect(result.body?.name, 'John');
  });

  test('Uses model to convert json into List<model>', () async {
    final response =
        Response(baseResponse, '[{"name":"John"},{"name":"John2"}]');

    const converter =
        JsonSerializableConverter({TestModel: TestModel.fromJson});

    final result =
        await converter.convertResponse<List<TestModel>, TestModel>(response);

    expect(result.body?[0].name, 'John');
    expect(result.body?[1].name, 'John2');
  });
}

class TestModel {
  TestModel(this.name);

  factory TestModel.fromJson(Map<String, dynamic> json) =>
      TestModel(json['name'] as String);

  final String name;

  Map<String, dynamic> toJson() => {'name': name};
}

class TestModel2 {
  TestModel2(this.name);

  factory TestModel2.fromJson(Map<String, dynamic> json) =>
      TestModel2(json['name'] as String);

  final String name;

  Map<String, dynamic> toJson() => {'name': name};
}
