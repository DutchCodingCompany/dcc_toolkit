import 'package:example/core/injectable/injectable.config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async =>
    getIt.init(environment: kDebugMode ? dev.name : prod.name);
