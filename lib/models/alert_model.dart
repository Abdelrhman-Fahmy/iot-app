class AlertModel {
  final String title;
  final String message;
  final String severity;
  final DateTime timestamp;

  const AlertModel({
    required this.title,
    required this.message,
    required this.severity,
    required this.timestamp,
  });
}
