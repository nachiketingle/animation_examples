import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ArcTimer extends StatefulWidget {
  ArcTimer({Key key, this.outerRadius:100, this.color:Colors.black, this.innerRadius:50, this.fillColor:Colors.white, this.seconds:60, this.repeat}) : super(key: key);
  final Color color;
  final Color fillColor;
  final double outerRadius;
  final double innerRadius;
  final double seconds;
  final bool repeat;

  _ArcTimerState createState() => _ArcTimerState();
}

class _ArcTimerState extends State<ArcTimer> {
  final int updateCycle = 10;
  double initialCount;
  double count;
  double fraction;
  Timer timer;

  void reset() {
    if(timer != null) {
      timer.cancel();
    }

    initialCount = widget.seconds * 1000;
    count = initialCount;
    fraction = count / initialCount;
    timer = Timer.periodic(Duration(milliseconds: updateCycle), _countdown);
  }

  void _countdown(Timer timer) {
    if(mounted) {
      setState(() {
        count -= updateCycle;
        fraction = count / initialCount;
      });
    }
    if(count <= 0) {
      widget.repeat ? reset() : timer.cancel();
    }

  }

  @override
  void initState() {
    super.initState();
    reset();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.outerRadius * 2,
      height: widget.outerRadius * 2,
      child: CustomPaint(
        painter: ArcTimerPrinter(
            color: widget.color,
            radii: widget.innerRadius,
            fillColor: widget.fillColor,
            fraction: fraction
        ),
      ),
    );
  }

}

class ArcTimerPrinter extends CustomPainter {

  ArcTimerPrinter({@required this.color, @required this.radii, @required this.fillColor, this.fraction:0.5});
  final Color color;
  final Color fillColor;
  final double radii;
  final double fraction;

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height/2);

    // Rectangles
    Rect arcRect = Rect.fromCircle(center: center, radius: size.width/2);
    Rect fillRect = Rect.fromCircle(center: center, radius: radii);

    // Paints
    Paint arcPaint = Paint()
      ..color = color
      ..strokeWidth = 10;
    Paint fillPaint = Paint()
      ..color = fillColor;

    // Drawing
    canvas.drawArc(arcRect, 3 * pi / 2, fraction * 2 * pi, true, arcPaint);
    canvas.drawArc(fillRect, 0, 2 * pi, true, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
