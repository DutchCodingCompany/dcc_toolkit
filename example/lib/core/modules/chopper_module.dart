import 'package:chopper/chopper.dart';
import 'package:dcc_toolkit/chopper/json_serializable_converter.dart';
import 'package:dcc_toolkit/chopper/no_content.dart';
import 'package:example/profile/data/model/api_user_response.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ChopperModule {
  @lazySingleton
  ChopperClient chopper() => ChopperClient(
        converter: const JsonSerializableConverter(_factories),
        interceptors: [
          // We want to disable logging in release mode because it could leak sensitive information
          if (kDebugMode) ...[
            HttpLoggingInterceptor(),
          ],
        ],
      );
}

const _factories = {
  NoContent: NoContent.fromJson,
  ApiUserResponse: ApiUserResponse.fromJson,
};
