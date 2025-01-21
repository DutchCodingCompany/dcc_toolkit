import 'dart:async';

import 'package:stepping_stones/stepping_stones.dart';

final createStones = <Stone>[Create()];

class Create extends Stone {
  @override
  FutureOr<void> step() async {
    await run(r'echo $MATCH_PASSWORD');
  }
}
