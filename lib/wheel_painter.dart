import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _degrees2Radians = math.pi / 180.0;

class WheelPainter extends CustomPainter {
  Paint _dataPaint;

  final WheelData wheelData;

  WheelPainter({this.wheelData});

  double radians(double degrees) => degrees * _degrees2Radians;

  @override
  void paint(Canvas canvas, Size size) {
    _dataPaint = Paint()..style = PaintingStyle.fill;

    final List<double> dataAngle =
        _calculateDataAngle(wheelData.listData, wheelData.sumValue);

    double h = math.min(size.width, size.height);
    double w = h;

    Size sizeWheel = Size(w, h);

    _drawWheel(canvas, sizeWheel, dataAngle);
    _drawText(canvas, sizeWheel, dataAngle);
  }

  List<double> _calculateDataAngle(List<Data> list, double sumValue) =>
      list.map((e) => (e.value / sumValue) * 360).toList();

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  _drawWheel(Canvas canvas, Size size, List<double> dataAngle) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    double tempAngle = wheelData.startDegreeOffset;

    for (int i = 0; i < wheelData.listData.length; i++) {
      final data = wheelData.listData[i];
      final dataDegree = dataAngle[i];
      final rect = Rect.fromCircle(
        center: center,
        radius: size.width,
      );

      _dataPaint.color = data.color;
      final double startAngle = tempAngle;
      final double sweepAngle = dataDegree;
      canvas.drawArc(
          rect, radians(startAngle), radians(sweepAngle), true, _dataPaint);
      tempAngle += sweepAngle;
    }
  }

  _drawText(Canvas canvas, Size size, List<double> dataAngle) {
    double tempAngle = wheelData.startDegreeOffset;
    final Offset center = Offset(size.width / 2, size.height / 2);
    canvas.translate(size.width / 2, size.width / 2);

    for (int i = 0; i < wheelData.listData.length; i++) {
      final data = wheelData.listData[i];
      final dataDegree = dataAngle[i];
      final double startAngle = tempAngle;
      final double sweepAngle = dataDegree;
      final double textAngle = startAngle + sweepAngle / 2;
      _rotateCanvas(canvas, radians(textAngle));
      _paintText(canvas, size, center,
          '${((data.value) * 100 / wheelData.sumValue).toStringAsFixed(1)}%');
      _rotateCanvas(canvas, -radians(textAngle));
      tempAngle += sweepAngle;
    }
  }

  _rotateCanvas(Canvas canvas, double angle) {
    canvas.rotate(angle);
  }

  _paintText(
    Canvas canvas,
    Size size,
    Offset offset,
    String text,
  ) {
    var textPainter = TextPainter(
      maxLines: 1,
      text: TextSpan(
          text: text,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    textPainter.paint(
        canvas,
        Offset(
            (size.width - textPainter.width) / 2, -(textPainter.height) / 2));
  }
}

class Data {
  final double value;
  final Color color;

  Data({this.value, this.color = Colors.red});
}

class WheelData {
  final double startDegreeOffset;
  final List<Data> listData;

  double get sumValue =>
      listData.map((e) => e.value).reduce((value, element) => value + element);

  WheelData({this.startDegreeOffset = 0, @required this.listData});
}
