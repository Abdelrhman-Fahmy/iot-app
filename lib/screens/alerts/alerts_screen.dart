import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = context.watch<DataProvider>().alerts;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: alerts.length,
      itemBuilder: (_, i) => ListTile(title: Text(alerts[i].title), subtitle: Text(alerts[i].message), trailing: Text(alerts[i].severity)),
    );
  }
}
