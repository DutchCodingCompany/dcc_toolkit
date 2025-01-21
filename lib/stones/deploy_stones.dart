import 'dart:async';

import 'package:dcc_toolkit/stones/ios_stones.dart';
import 'package:stepping_stones/stepping_stones.dart';

final deployStones = <Stone>[
  DeployIosFirebase(),
  DeployTestflight(),
  DeployAndroidFirebase(),
  DeployPlayStore(),
];

class DeployIosFirebase extends Stone {
  @override
  Set<String> get guards => {
        'ipa_path',
        'FIREBASE_CLI_TOKEN',
        'FIREBASE_IOS_APP_ID',
        'groups',
        'CI_COMMIT_MESSAGE',
      };

  @override
  FutureOr<void> step() async {
    final firebaseArgs = [
      'firebase_cli_token:"${envs['firebase_cli_token']}"',
      'app:"${envs['FIREBASE_IOS_APP_ID']}"',
      'ipa_path:"${envs['ipa_path']}"',
      'groups:"${envs['groups']}"',
      'release_notes:"${envs['CI_COMMIT_MESSAGE']}"',
    ].join(' ');

    await run(
      'bundle exec fastlane firebase_app_distribution $firebaseArgs',
    );
  }
}

class DeployTestflight extends IOSStone {
  @override
  Set<String> get guards => super.guards..add('ipa_path');

  @override
  FutureOr<void> step() async {
    await initFastlaneApple();
    await run(
        'bundle exec fastlane upload_to_testflight ipa:"${envs['ipa_path']}" skip_waiting_for_build_processing:true');
  }
}

class DeployAndroidFirebase extends Stone {
  @override
  Set<String> get guards => {
        'FIREBASE_CLI_TOKEN',
        'FIREBASE_ANDROID_APP_ID',
        'ANDROID_ARTIFACT_PATH',
        'GROUPS',
        'CI_COMMIT_MESSAGE',
      };

  @override
  FutureOr<void> step() async {
    await run('bundle exec fastlane android firebase');
  }
}

class DeployPlayStore extends Stone {
  @override
  Set<String> get guards => {'aab_path'};

  @override
  FutureOr<void> step() async {
    await run(
      'bundle exec fastlane supply --aab ${envs['aab_path']} --track internal --release_status draft',
    );
  }
}
