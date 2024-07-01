import 'package:flutter/material.dart';

class Sketch {
  final List<Offset> points;
  final Color color;
  final double size;
  final SketchType type;
  final bool filled;
  final int sides;

  Sketch({
    required this.points,
    this.color = Colors.black,
    this.type = SketchType.scribble,
    this.filled = true,
    this.sides = 3,
    required this.size,
  });
}

enum SketchType { scribble }

extension ColorExtension on String {
  Color toColor() {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    } else {
      return Colors.black;
    }
  }
}

extension ColorExtensionX on Color {
  String toHex() => '#${value.toRadixString(16).substring(2, 8)}';
}
