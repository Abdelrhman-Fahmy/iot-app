import 'package:flutter/material.dart';

class GlowLineChart extends StatelessWidget {
  final List<double> points;

  const GlowLineChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: CustomPaint(
        painter: _LinePainter(points),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final List<double> points;
  _LinePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;
    final maxP = points.reduce((a, b) => a > b ? a : b);
    final minP = points.reduce((a, b) => a < b ? a : b);
    final range = (maxP - minP).abs() < 0.01 ? 1 : maxP - minP;
    final path = Path();

    for (var i = 0; i < points.length; i++) {
      final x = i / (points.length - 1) * size.width;
      final y = size.height - ((points[i] - minP) / range) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..shader = const LinearGradient(colors: [Colors.orange, Colors.pink]).createShader(Offset.zero & size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) => oldDelegate.points != points;
}
