import 'package:dcc_toolkit/logger/bolt_logger.dart';
import 'package:flutter/material.dart';

/// {@template bolt_logger_view}
/// A widget that displays the logs stored in the [MemoryCharge].
/// {@endtemplate}
class BoltLoggerView extends StatefulWidget {
  /// {@macro bolt_logger_view}
  const BoltLoggerView({super.key});

  @override
  State<BoltLoggerView> createState() => _BoltLoggerViewState();
}

class _BoltLoggerViewState extends State<BoltLoggerView> {
  late final MemoryCharge charge;

  @override
  void initState() {
    super.initState();
    final hasCharge = BoltLogger.getCharge('MemoryCharge');
    if (hasCharge != null) {
      charge = hasCharge as MemoryCharge;
    } else {
      charge = MemoryCharge();
      BoltLogger.charge([charge]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: charge.stream,
      builder: (context, _) {
        return ListView.builder(
          itemCount: charge.items.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: charge.items[index].lines
                  .map(
                    (e) => Text(
                      e,
                      style: const TextStyle(fontSize: 10),
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }
}
