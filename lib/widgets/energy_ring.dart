import 'dart:math';

import 'package:flutter/material.dart';

import '../core/constants.dart';

class EnergyRing extends StatefulWidget {
  final double value;
  final String label;

  const EnergyRing({super.key, required this.value, required this.label});

  @override
  State<EnergyRing> createState() => _EnergyRingState();
}

class _EnergyRingState extends State<EnergyRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 8))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.rotate(
          angle: _controller.value * pi * 2 * widget.value.clamp(0.1, 1.0),
          child: Container(
            height: 220,
            width: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const SweepGradient(
                colors: [
                  AppConstants.neonOrange,
                  AppConstants.neonAmber,
                  AppConstants.neonYellow,
                  AppConstants.neonPink,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.neonPink.withValues(alpha: 0.6),
                  blurRadius: 28,
                ),
              ],
            ),
            child: Center(
              child: Container(
                height: 170,
                width: 170,
                decoration: const BoxDecoration(color: Color(0xFF110E20), shape: BoxShape.circle),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(widget.label), Text(widget.value.toStringAsFixed(2), style: const TextStyle(fontSize: 28))],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
