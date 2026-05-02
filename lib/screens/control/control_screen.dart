import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/system_state.dart';
import '../../providers/control_provider.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ControlProvider>();
    final state = provider.state;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Control', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        SwitchListTile(value: state.fanOn, onChanged: provider.setFan, title: const Text('Fan ON/OFF')),
        SegmentedButton<OverrideMode>(
          segments: const [ButtonSegment(value: OverrideMode.auto, label: Text('Auto')), ButtonSegment(value: OverrideMode.manual, label: Text('Manual'))],
          selected: {state.overrideMode},
          onSelectionChanged: (v) => provider.setOverride(v.first),
        ),
      ],
    );
  }
}
