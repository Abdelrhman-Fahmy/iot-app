import 'dart:async';

import 'package:flutter/material.dart';

import '../core/api_service.dart';
import '../models/alert_model.dart';
import '../models/sensor_model.dart';

class DataProvider extends ChangeNotifier {
  final ApiService _api = ApiService();
  Timer? _timer;
  SensorModel? latest;
  final List<SensorModel> history = [];
  final List<AlertModel> alerts = [];

  Future<void> startPolling() async {
    await fetchLatest();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) => fetchLatest());
  }

  Future<void> fetchLatest() async {
    try {
      latest = await _api.getLatestData();
      history.add(latest!);
      if (history.length > 200) history.removeAt(0);
      _generateAlerts(latest!);
      notifyListeners();
    } catch (_) {}
  }

  void _generateAlerts(SensorModel data) {
    if (data.temp > 32) {
      alerts.insert(
        0,
        AlertModel(
          title: 'High Temperature',
          message: 'Temperature reached ${data.temp.toStringAsFixed(1)}°C',
          severity: 'high',
          timestamp: DateTime.now(),
        ),
      );
    }
    if (data.anomaly) {
      alerts.insert(
        0,
        AlertModel(
          title: 'Sensor Anomaly',
          message: 'Anomaly flag raised by validation module',
          severity: 'critical',
          timestamp: DateTime.now(),
        ),
      );
    }
    if (alerts.length > 50) alerts.removeLast();
  }
}
