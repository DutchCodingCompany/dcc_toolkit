import 'dart:async';

import 'package:stepping_stones/src/stone/stone.dart';

final defaultStones = <Stone>[
  Setup(),
  Clean(),
  Format(),
  Analyze(),
  CheckFormat(),
  CheckStyle(),
  Get(),
  CodeGen(),
  CodeGenWatcher(),
  Tests(),
  ShowCoverage(),
  UpdateGoldens(),
];

class Setup extends Stone {
  @override
  FutureOr<void> step() async {
    await run('fvm install');
    await run('bundle config set --local path "${envs['HOME']}/.gem"');
    await run('bundle install');
  }
}

class Clean extends Stone {
  @override
  FutureOr<void> step() async {
    await run('fvm flutter clean');
  }
}

class Format extends Stone {
  @override
  FutureOr<void> step() async {
    await run('fvm dart format -l 120 .');
  }
}

class Analyze extends Stone {
  @override
  FutureOr<void> step() async {
    await run('fvm flutter analyze --no-pub --no-fatal-infos');
  }
}

class CheckFormat extends Stone {
  @override
  FutureOr<void> step() async {
    await run('fvm dart format --output=none -l 120 --set-exit-if-changed .');
  }
}

class CheckStyle extends Stone {
  @override
  Set<Stone> preRun = {Analyze(), CheckFormat()};

  @override
  void step() {}
}

class Get extends Stone {
  @override
  FutureOr<void> step() async {
    await run('fvm flutter pub get');
  }
}

class CodeGen extends Stone {
  @override
  Set<Stone> preRun = {Get()};

  @override
  FutureOr<void> step() async {
    await run('fvm flutter gen-l10n');
    await run('fvm flutter pub run build_runner build --delete-conflicting-outputs');
  }
}

class CodeGenWatcher extends Stone {
  @override
  Set<Stone> preRun = {Get()};

  @override
  FutureOr<void> step() async {
    await run('fvm flutter pub run build_runner watch --delete-conflicting-outputs');
  }
}

class Tests extends Stone {
  @override
  FutureOr<void> step() async {
    await run('fvm flutter test -r github --file-reporter json:report.json -x shadow --no-pub --coverage');
    await run(
      "lcov --remove coverage/lcov.info '**/*.chopper.dart' '**/*.g.dart' '**/*.gr.dart' '**/*.freezed.dart' '**/*.config.dart' -o coverage/lcov_without_generated_code.info --ignore-errors unused",
    );
    await run('genhtml coverage/lcov_without_generated_code.info -o coverage/html');
  }
}

class ShowCoverage extends Stone {
  @override
  Set<Stone> preRun = {Tests()};

  @override
  FutureOr<void> step() async {
    await run('open coverage/html/index.html');
  }
}

class UpdateGoldens extends Stone {
  @override
  FutureOr<void> step() async {
    await run('fvm flutter test --update-goldens');
  }
}
