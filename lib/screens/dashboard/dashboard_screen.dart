import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';
import '../../widgets/energy_ring.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/line_chart.dart';
import '../../widgets/status_badge.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DataProvider>();
    final data = provider.latest;
    final points = provider.history.map((e) => e.temp).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SMART SYSTEM', style: TextStyle(letterSpacing: 2, color: Colors.white70)),
          const Text('Dashboard', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          Center(child: EnergyRing(value: data?.score ?? 0, label: 'System Score')),
          const SizedBox(height: 16),
          Center(child: StatusBadge(label: data?.mode ?? 'idle')),
          const SizedBox(height: 10),
          Center(child: Text('Reason: ${data?.reason ?? 'awaiting data'}')),
          const SizedBox(height: 16),
          GlowLineChart(points: points),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _metric('Temperature', '${data?.temp.toStringAsFixed(1) ?? '--'} °C')),
              const SizedBox(width: 8),
              Expanded(child: _metric('Humidity', '${data?.humidity.toStringAsFixed(0) ?? '--'} %')),
              const SizedBox(width: 8),
              Expanded(child: _metric('Occupancy', '${data?.occupancy ?? '--'}')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metric(String title, String value) => GlassCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 20))]),
      );
}
