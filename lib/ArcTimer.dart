import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ArcTimer extends StatefulWidget {
  ArcTimer({
    Key key,
    this.outerRadius:100,
    this.color:Colors.black,
    this.innerRadius:50,
    this.fillColor:Colors.white,
    this.seconds:60,
    this.repeat,
    this.textStyle,
  }) : super(key: key);

  final Color color;          // Color of the arc
  final Color fillColor;      // Color of the inner circle
  final double outerRadius;   // Radius of the arc
  final double innerRadius;   // Radius of the inner circle
  final double seconds;       // Number of seconds the timer runs for
  final bool repeat;          // Whether the timer should repeat
  final TextStyle textStyle;  // Text style for the display of the seconds

  _ArcTimerState createState() => _ArcTimerState();
}

class _ArcTimerState extends State<ArcTimer> {
  final int updateCycle = 10; // Number of milliseconds between screen refresh
  double initialCount;        // Number of seconds per cycle
  double count;               // Current millisecond count for the arc timer
  double fraction;            // Fraction of circle that arc should go to
  Timer timer;                // Timer controlling the refresh and updates

  // Reset the timer
  void reset() {
    if(timer != null) {
      timer.cancel();
    }

    initialCount = widget.seconds * 1000;
    count = initialCount;
    fraction = count / initialCount;
    timer = Timer.periodic(Duration(milliseconds: updateCycle), _countdown);
  }

  // Called after every updateCycle
  // Updates the arc and seconds with setState
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
    timer.cancel();   // Called just in case
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.outerRadius * 2,
      height: widget.outerRadius * 2,
      child: CustomPaint(
        painter: ArcTimerPainter(
          color: widget.color,
          radii: widget.innerRadius,
          fillColor: widget.fillColor,
          fraction: fraction,
          seconds: (count / 1000).ceil(),
          textStyle: widget.textStyle,
        ),
      ),
    );
  }

}

/// Used to paint the timer
class ArcTimerPainter extends CustomPainter {

  ArcTimerPainter({
    @required this.color,
    @required this.radii,
    @required this.fillColor,
    this.textStyle,
    this.fraction:0.5,
    this.seconds: -1
  });
  final Color color;
  final Color fillColor;
  final double radii;
  final double fraction;
  final int seconds;
  final TextStyle textStyle;

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height/2);

    // Rectangles / Models
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

    // Add time if applicable
    if(seconds >= 0 && textStyle != null) {
      TextPainter painter = TextPainter(
        text: TextSpan(text: seconds.toString(), style: textStyle),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )
      ..layout(maxWidth: size.width);
      painter.paint(canvas, Offset((size.width - painter.width) / 2, (size.height - painter.height) / 2));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
