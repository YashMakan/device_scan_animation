import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedCircle extends CustomPainter {
  final double value;
  final double opacity;
  final int layers;
  final List<int> angles;
  final List<bool> showOnCircles;
  final double gap;
  final Color centerNodeColor;
  final Color nodeColor;
  final Color scanColor;
  final Color ringColor;
  final double ringThickness;

  AnimatedCircle({
    required this.value,
    required this.opacity,
    required this.layers,
    required this.angles,
    required this.showOnCircles,
    required this.gap,
    required this.nodeColor,
    required this.scanColor,
    required this.centerNodeColor,
    required this.ringColor,
    required this.ringThickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    var fillBrush = Paint();
    fillBrush.color = scanColor.withOpacity(opacity);

    var circlePaints = List.generate(layers, (index) {
      var circle = Paint();
      circle.style = PaintingStyle.stroke;
      circle.strokeWidth = ringThickness;
      circle.color = ringColor;
      return circle;
    });

    var childDot = Paint();
    childDot.color = nodeColor;

    var centerDot = Paint();
    centerDot.color = centerNodeColor;

    canvas.drawCircle(center, value, fillBrush);

    for (int i = 1; i < layers; i++) {
      var currentRadius = (i * gap).toDouble();
      canvas.drawCircle(center, currentRadius, circlePaints[i]);

      if (showOnCircles[i]) {
        double valX = x(currentRadius, angles[i], centerX);
        double valY = y(currentRadius, angles[i], centerY);
        Offset offset = Offset(valX, valY);
        canvas.drawCircle(
            offset, (value * 0.13).clamp(1, 10).toDouble(), childDot);
      }
    }

    canvas.drawCircle(center, 5.0, centerDot);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

double x(r, angle, centerX) => r * cos((angle - pi / 2)) + centerX;

double y(r, angle, centerY) => r * sin((angle - pi / 2)) + centerY;
