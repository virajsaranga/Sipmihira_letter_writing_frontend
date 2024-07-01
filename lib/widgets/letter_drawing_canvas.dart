import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:story_2/main.dart';
import 'package:story_2/models/drawing_model_letter.dart';
import 'package:story_2/models/letter_sketch.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DrawingCanvas extends HookWidget {
  final double height;
  final double width;
  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> strokeSize;
  final ValueNotifier<double> eraserSize;
  final ValueNotifier<DrawingMode> drawingMode;
  final AnimationController sideBarController;
  final ValueNotifier<Sketch?> currentSketch;
  final ValueNotifier<List<Sketch>> allSketches;
  final GlobalKey canvasGlobalKey;

  const DrawingCanvas({
    Key? key,
    required this.height,
    required this.width,
    required this.selectedColor,
    required this.strokeSize,
    required this.eraserSize,
    required this.drawingMode,
    required this.sideBarController,
    required this.currentSketch,
    required this.allSketches,
    required this.canvasGlobalKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.precise,
      child: Stack(
        children: [
          buildAllSketches(context),
          buildCurrentPath(context),
        ],
      ),
    );
  }

  void onPointerDown(PointerDownEvent details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);
    currentSketch.value = Sketch(
      points: [offset],
      size: drawingMode.value == DrawingMode.eraser
          ? eraserSize.value
          : strokeSize.value,
      color: drawingMode.value == DrawingMode.eraser
          ? kCanvasColor
          : selectedColor.value,
      type: SketchType.scribble, // Set the type appropriately
      filled: false, // Set filled to false for eraser
      sides: 3, // Set sides appropriately if needed
    );
  }

  void onPointerMove(PointerMoveEvent details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);
    final points = List<Offset>.from(currentSketch.value?.points ?? [])
      ..add(offset);
    currentSketch.value = Sketch(
      points: points,
      size: drawingMode.value == DrawingMode.eraser
          ? eraserSize.value
          : strokeSize.value,
      color: drawingMode.value == DrawingMode.eraser
          ? kCanvasColor
          : selectedColor.value,
      type: SketchType.scribble, // Set the type appropriately
      filled: false, // Set filled to false for eraser
      sides: 3, // Set sides appropriately if needed
    );
  }

  void onPointerUp(PointerUpEvent details) {
    allSketches.value = List<Sketch>.from(allSketches.value)
      ..add(currentSketch.value!);
  }

  Widget buildAllSketches(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ValueListenableBuilder<List<Sketch>>(
        valueListenable: allSketches,
        builder: (context, sketches, _) {
          return RepaintBoundary(
            key: canvasGlobalKey,
            child: Container(
              height: height,
              width: width,
              color: kCanvasColor,
              child: CustomPaint(
                painter: SketchPainter(
                  sketches: sketches,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    return Listener(
      onPointerDown: (details) => onPointerDown(details, context),
      onPointerMove: (details) => onPointerMove(details, context),
      onPointerUp: onPointerUp,
      child: ValueListenableBuilder(
        valueListenable: currentSketch,
        builder: (context, sketch, child) {
          return RepaintBoundary(
            child: SizedBox(
              height: height,
              width: width,
              child: CustomPaint(
                painter: SketchPainter(
                  sketches: sketch == null ? [] : [sketch],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Sketch> sketches;
  final Image? backgroundImage;

  const SketchPainter({
    Key? key,
    this.backgroundImage,
    required this.sketches,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundImage != null) {
      canvas.drawImageRect(
        backgroundImage!,
        Rect.fromLTWH(0, 0, backgroundImage!.width.toDouble(),
            backgroundImage!.height.toDouble()),
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint(),
      );
    }
    for (Sketch sketch in sketches) {
      final points = sketch.points;
      if (points.isEmpty) continue;

      final path = Path();

      path.moveTo(points[0].dx, points[0].dy);
      if (points.length < 2) {
        // If the path only has one line, draw a dot.
        path.addOval(
          Rect.fromCircle(
            center: Offset(points[0].dx, points[0].dy),
            radius: 1,
          ),
        );
      }

      for (int i = 1; i < points.length - 1; ++i) {
        final p0 = points[i];
        final p1 = points[i + 1];
        path.quadraticBezierTo(
          p0.dx,
          p0.dy,
          (p0.dx + p1.dx) / 2,
          (p0.dy + p1.dy) / 2,
        );
      }

      Paint paint = Paint()
        ..color = sketch.color
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      if (!sketch.filled) {
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = sketch.size;
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SketchPainter oldDelegate) {
    return oldDelegate.sketches != sketches;
  }
}
