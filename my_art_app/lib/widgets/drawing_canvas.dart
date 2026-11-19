import 'dart:io';
import 'package:flutter/material.dart';

class Stroke {
  final List<Offset> points;
  final Color color;
  final double width;
  final double opacity;

  Stroke({
    required this.points,
    required this.color,
    required this.width,
    required this.opacity,
  });
}

class DrawingCanvas extends StatefulWidget {
  final String? imagePath;
  final Color selectedColor;
  final double brushSize;
  final double opacity;
  final bool isEraser;
  final List<Stroke> strokes;
  final VoidCallback onStrokeChanged;

  const DrawingCanvas({
    Key? key,
    this.imagePath,
    required this.selectedColor,
    required this.brushSize,
    required this.opacity,
    required this.isEraser,
    required this.strokes,
    required this.onStrokeChanged,
  }) : super(key: key);

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  Stroke? _currentStroke;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: [
          CustomPaint(
            painter: _CheckerboardPainter(),
            size: Size.infinite,
          ),
          if (widget.imagePath != null && widget.imagePath!.isNotEmpty)
            Positioned.fill(
              child: Image.file(
                File(widget.imagePath!),
                fit: BoxFit.contain,
              ),
            ),
          GestureDetector(
            onPanStart: (details) {
              final renderBox = context.findRenderObject() as RenderBox;
              final pos = renderBox.globalToLocal(details.globalPosition);
              setState(() {
                _currentStroke = Stroke(
                  points: [pos],
                  color: widget.isEraser ? Colors.white : widget.selectedColor,
                  width: widget.brushSize,
                  opacity: widget.isEraser ? 1.0 : widget.opacity,
                );
              });
            },
            onPanUpdate: (details) {
              if (_currentStroke == null) return;
              final renderBox = context.findRenderObject() as RenderBox;
              final pos = renderBox.globalToLocal(details.globalPosition);
              setState(() {
                _currentStroke!.points.add(pos);
              });
            },
            onPanEnd: (_) {
              if (_currentStroke != null) {
                setState(() {
                  widget.strokes.add(_currentStroke!);
                  _currentStroke = null;
                });
                widget.onStrokeChanged();
              }
            },
            child: CustomPaint(
              painter: _CanvasPainter(
                strokes: widget.strokes,
                currentStroke: _currentStroke,
              ),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double squareSize = 12.0;
    final paintLight = Paint()..color = const Color(0xFFFFFFFF);
    final paintDark = Paint()..color = const Color(0xFFE6E6E6);

    for (double y = 0; y < size.height; y += squareSize) {
      for (double x = 0; x < size.width; x += squareSize) {
        final isEven = ((x / squareSize).floor() + (y / squareSize).floor()) % 2 == 0;
        canvas.drawRect(
          Rect.fromLTWH(x, y, squareSize, squareSize),
          isEven ? paintLight : paintDark,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CanvasPainter extends CustomPainter {
  final List<Stroke> strokes;
  final Stroke? currentStroke;

  _CanvasPainter({required this.strokes, this.currentStroke});

  void _drawStroke(Canvas canvas, Stroke stroke) {
    final paint = Paint()
      ..color = stroke.color.withValues(alpha: stroke.opacity)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = stroke.width
      ..style = PaintingStyle.stroke;

    if (stroke.points.length == 1) {
      canvas.drawCircle(stroke.points.first, stroke.width / 2, paint..style = PaintingStyle.fill);
      return;
    }

    final path = Path()..moveTo(stroke.points.first.dx, stroke.points.first.dy);
    for (int i = 1; i < stroke.points.length; i++) {
      path.lineTo(stroke.points[i].dx, stroke.points[i].dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      _drawStroke(canvas, stroke);
    }
    if (currentStroke != null) {
      _drawStroke(canvas, currentStroke!);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}