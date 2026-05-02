enum OverrideMode { auto, manual }

enum ClimateMode { cooling, heating, idle }

class SystemState {
  final OverrideMode overrideMode;
  final bool fanOn;
  final double targetTemp;
  final double targetHumidity;
  final double sensitivity;

  const SystemState({
    required this.overrideMode,
    required this.fanOn,
    required this.targetTemp,
    required this.targetHumidity,
    required this.sensitivity,
  });
}
