import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final d = context.watch<DataProvider>().latest;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Debug & Validation', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        _row('ΔT/Δt', d == null ? '--' : '${d.temp.toStringAsFixed(2)} / tick'),
        _row('cooling_score', d?.score.toStringAsFixed(2) ?? '--'),
        _row('anomaly_flag', '${d?.anomaly ?? false}'),
        _row('failsafe_level', '${d?.failsafeLevel ?? 0}'),
        _row('dominant_factor', d?.reason ?? '--'),
        _row('reason_code', d?.reason ?? '--'),
        _row('loop_time', '${d?.loopTime.toStringAsFixed(2) ?? '--'} ms'),
        _row('determinism', '${d?.deterministic ?? true}'),
      ],
    );
  }

  Widget _row(String k, String v) => ListTile(title: Text(k), trailing: Text(v));
}
