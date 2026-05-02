import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String label;

  const StatusBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.blueAccent;
    if (label == 'cooling') color = Colors.orangeAccent;
    if (label == 'heating') color = Colors.redAccent;
    if (label == 'idle') color = Colors.greenAccent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color),
      ),
      child: Text(label.toUpperCase()),
    );
  }
}
