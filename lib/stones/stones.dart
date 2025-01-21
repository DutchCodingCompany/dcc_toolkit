import 'package:dcc_toolkit/stones/android_stones.dart';
import 'package:dcc_toolkit/stones/create_stones.dart';
import 'package:dcc_toolkit/stones/default_stones.dart';
import 'package:dcc_toolkit/stones/deploy_stones.dart';
import 'package:dcc_toolkit/stones/ios_stones.dart';
import 'package:stepping_stones/stepping_stones.dart';

export 'android_stones.dart';
export 'create_stones.dart';
export 'default_stones.dart';
export 'deploy_stones.dart';
export 'ios_stones.dart';

final allDCCStones = <Stone>[
  ...defaultStones,
  ...androidStones,
  ...iosStones,
  ...deployStones,
  ...createStones,
];
