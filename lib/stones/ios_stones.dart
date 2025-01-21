import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:stepping_stones/stepping_stones.dart';

final iosStones = [
  Match(),
  BuildIosAdhocDebug(),
  BuildIosAdhocRelease(),
  BuildIosAppstoreRelease(),
];

abstract class IOSStone extends Stone {
  @override
  Set<String> get guards => {'KEY_ID', 'ISSUER_ID', 'KEY_CONTENT'};

  FutureOr<void> initFastlaneApple() async {
    await run(
      'bundle exec fastlane app_store_connect_api_key key_id:"${envs['key_id']}" issuer_id:"${envs['issuer_id']}" key_content:"${envs['APPLE_KEY']}" is_key_content_base64:true',
    );
    await run('bundle exec fastlane unlock_keychain path:"ci"');
  }

  FutureOr<void> match(String matchCommand) async {
    await run(r'echo $MATCH_PASSWORD');
    await run('bundle exec fastlane match $matchCommand');
  }
}

class Match extends IOSStone {
  @override
  ArgParser? get parser => ArgParser()
    ..addCommand('adhoc')
    ..addCommand('appstore');

  @override
  FutureOr<void> step() async {
    await initFastlaneApple();

    if (argResults?.name == null) {
      stderr.write('No match provided');
      exit(1);
    }

    await match(argResults!.name!);
  }
}

class BuildIosAdhocDebug extends IOSStone {
  @override
  Set<String> get guards => super.guards..addAll({'CI_PIPELINE_IID', 'EXPORT_OPTIONS'});

  @override
  FutureOr<void> step() async {
    await match('adhoc');
    await run('fvm flutter build ipa --debug --export-options-plist ${envs['EXPORT_OPTIONS']} --build-number=${envs['CI_PIPELINE_IID']} --dart-define-from-file=.envs/.env.dart_defines');
  }
}

class BuildIosAdhocRelease extends IOSStone {
  @override
  Set<String> get guards => super.guards..addAll({'CI_PIPELINE_IID', 'EXPORT_OPTIONS'});

  @override
  FutureOr<void> step() async {
    await match('adhoc');
    await run('fvm flutter build ipa --release --export-options-plist ${envs['EXPORT_OPTIONS']} --build-number=${envs['CI_PIPELINE_IID']} --dart-define-from-file=.envs/.env.dart_defines');
  }
}

class BuildIosAppstoreRelease extends IOSStone {
  @override
  Set<String> get guards => super.guards..addAll({'CI_PIPELINE_IID', 'EXPORT_OPTIONS'});

  @override
  FutureOr<void> step() async {
    await match('appstore');
    await run('fvm flutter build ipa --debug --export-options-plist ${envs['EXPORT_OPTIONS']} --build-number=${envs['CI_PIPELINE_IID']} --dart-define-from-file=.envs/.env.dart_defines');
  }
}

// build_ios_dev: guard-CI_PIPELINE_IID guard-APPLE_KEY##Help: Runs the mobile application in dev
// @echo "╠ Building the app: iOS dev buildnumber($(CI_PIPELINE_IID))"
// @bundle exec fastlane ios sync_profiles_dev
// @$(FLUTTER) build ipa --debug --export-options-plist ios/SaraMvMExportOptionsDev.plist $(FLAVOR_DEV) $(DARTDEFINE) $(BUILD_NUMBER)
//
// build_ios_dev_release: guard-CI_PIPELINE_IID guard-APPLE_KEY ##Help: Runs the mobile application in dev
// @echo "╠ Building the app: iOS dev-release buildnumber($(CI_PIPELINE_IID))"
// @bundle exec fastlane ios sync_profiles_dev
// @$(FLUTTER) build ipa --release --export-options-plist ios/SaraMvMExportOptionsDev.plist $(FLAVOR_DEV) $(DARTDEFINE) $(BUILD_NUMBER)
//
// build_ios_prod: guard-CI_PIPELINE_IID guard-APPLE_KEY ##Help: Runs the mobile application in prod
// @echo "╠ Building the app: iOS prod buildnumber($(CI_PIPELINE_IID))"
// @bundle exec fastlane ios sync_profiles_appstore
// @$(FLUTTER) build ipa --release --export-options-plist ios/SaraMvMExportOptions.plist $(FLAVOR_PROD) $(DARTDEFINE) $(BUILD_NUMBER)


