import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';
import '../../widgets/line_chart.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<DataProvider>().history;
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('History', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      GlowLineChart(points: history.map((e) => e.temp).toList()),
      const SizedBox(height: 12),
      GlowLineChart(points: history.map((e) => e.humidity).toList()),
    ]);
  }
}
