class SensorModel {
  final double temp;
  final double humidity;
  final int occupancy;
  final double current;
  final double score;
  final String mode;
  final String reason;
  final bool anomaly;
  final int failsafeLevel;
  final double loopTime;
  final bool deterministic;
  final int timestamp;

  const SensorModel({
    required this.temp,
    required this.humidity,
    required this.occupancy,
    required this.current,
    required this.score,
    required this.mode,
    required this.reason,
    required this.anomaly,
    required this.failsafeLevel,
    required this.loopTime,
    required this.deterministic,
    required this.timestamp,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      temp: (json['temp'] as num?)?.toDouble() ?? 0,
      humidity: (json['humidity'] as num?)?.toDouble() ?? 0,
      occupancy: json['occupancy'] as int? ?? 0,
      current: (json['current'] as num?)?.toDouble() ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0,
      mode: json['mode'] as String? ?? 'idle',
      reason: json['reason'] as String? ?? 'unknown',
      anomaly: json['anomaly'] as bool? ?? false,
      failsafeLevel: json['failsafe_level'] as int? ?? 0,
      loopTime: (json['loop_time'] as num?)?.toDouble() ?? 0,
      deterministic: json['deterministic'] as bool? ?? true,
      timestamp: json['timestamp'] as int? ?? 0,
    );
  }
}
