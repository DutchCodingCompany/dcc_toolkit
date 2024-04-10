import 'package:dcc_toolkit/logger/bolt_logger.dart';

export 'package:dcc_toolkit/logger/charges/debug_console_charge.dart';
export 'package:dcc_toolkit/logger/charges/file_charge.dart';
export 'package:dcc_toolkit/logger/charges/memory_charge.dart';

/// Interface for creating [BoltCharge]s to power the [BoltLogger]
abstract interface class BoltCharge {
  /// The name of the charge.
  abstract final String name;

  /// Log the output of the [ZapEvent].
  void logOutput(ZapEvent event);

  /// Discharge the charge.
  void discharge();
}
