import 'package:flutter/material.dart';

import '../core/api_service.dart';
import '../models/system_state.dart';

class ControlProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  SystemState state = const SystemState(
    overrideMode: OverrideMode.auto,
    fanOn: true,
    targetTemp: 24,
    targetHumidity: 50,
    sensitivity: 0.5,
  );

  Future<void> setFan(bool value) async {
    state = SystemState(
      overrideMode: state.overrideMode,
      fanOn: value,
      targetTemp: state.targetTemp,
      targetHumidity: state.targetHumidity,
      sensitivity: state.sensitivity,
    );
    await _api.postControl({'fan_on': value});
    notifyListeners();
  }

  Future<void> setOverride(OverrideMode mode) async {
    state = SystemState(
      overrideMode: mode,
      fanOn: state.fanOn,
      targetTemp: state.targetTemp,
      targetHumidity: state.targetHumidity,
      sensitivity: state.sensitivity,
    );
    await _api.postControl({'mode': mode.name});
    notifyListeners();
  }

  Future<void> updateTargets(double t, double h, double s) async {
    state = SystemState(
      overrideMode: state.overrideMode,
      fanOn: state.fanOn,
      targetTemp: t,
      targetHumidity: h,
      sensitivity: s,
    );
    await _api.postConfig({'target_T': t, 'target_H': h, 'sensitivity': s});
    notifyListeners();
  }
}
