import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/control_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ControlProvider>();
    final state = provider.state;
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Settings', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      Text('target_T: ${state.targetTemp.toStringAsFixed(1)}'),
      Slider(value: state.targetTemp, min: 16, max: 32, onChanged: (v) => provider.updateTargets(v, state.targetHumidity, state.sensitivity)),
      Text('target_H: ${state.targetHumidity.toStringAsFixed(0)}'),
      Slider(value: state.targetHumidity, min: 20, max: 90, onChanged: (v) => provider.updateTargets(state.targetTemp, v, state.sensitivity)),
      Text('sensitivity: ${state.sensitivity.toStringAsFixed(2)}'),
      Slider(value: state.sensitivity, min: 0, max: 1, onChanged: (v) => provider.updateTargets(state.targetTemp, state.targetHumidity, v)),
    ]);
  }
}
