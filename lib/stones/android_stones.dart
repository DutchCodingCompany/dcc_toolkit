import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:stepping_stones/stepping_stones.dart';

final androidStones = <Stone>[
  AndroidBuildStone(isRelease: false, type: 'apk'),
  AndroidBuildStone(isRelease: true, type: 'apk'),
  AndroidBuildStone(isRelease: true, type: 'appbundle'),
];

class AndroidBuildStone extends Stone {
  final bool isRelease;
  final String type;

  AndroidBuildStone({
    required this.isRelease,
    required this.type,
  });

  @override
  Set<String> get guards => {
        'CI_PIPELINE_IID',
        if (isRelease) 'KEYSTORE',
        if (isRelease) 'KEYPROPERTIES',
      };

  @override
  FutureOr<void> step() async {
    if (isRelease) {
      final keyStore = base64Decode(envs['KEYSTORE']!);
      File('android/app/upload-keystore.jks').writeAsBytesSync(keyStore);
      final keyProperties = base64Decode(envs['KEYPROPERTIES']!);
      File('android/app/key.properties').writeAsBytesSync(keyProperties);
    }

    await run(
      'fvm flutter build $type --${isRelease ? 'release' : 'debug'} --build-number=${envs['CI_PIPELINE_IID']} --dart-define-from-file=.envs/.env.dart_defines ${envs['FLAVOR_CONFIG']}',
    );
  }

  @override
  String toString() {
    return 'build_${type}_${isRelease ? 'release' : 'debug'}';
  }
}
