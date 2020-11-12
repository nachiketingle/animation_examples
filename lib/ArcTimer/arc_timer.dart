import 'dart:math';
import 'dart:ui';

import 'package:animation_examples/ArcTimer/timer_controller.dart';
import 'package:flutter/material.dart';

export 'timer_controller.dart';

class ArcTimer extends StatefulWidget {
  ArcTimer({
    Key key,
    this.outerRadius:100,
    this.color:Colors.black,
    this.innerRadius:50,
    this.fillColor:Colors.white,
    this.seconds:60,
    this.startASAP:false,
    this.textStyle,
    this.onFinish,
    this.arcTimerController
  }) : super(key: key);

  final Color color;          // Color of the arc
  final Color fillColor;      // Color of the inner circle
  final double outerRadius;   // Radius of the arc
  final double innerRadius;   // Radius of the inner circle
  final double seconds;       // Number of seconds the timer runs for
  final bool startASAP;       // Whether we should start timer immediately
  final TextStyle textStyle;  // Text style for the display of the seconds
  final Function onFinish;        // Callback when timer hits 0
  final TimerController arcTimerController;   // Controller for the timer

  _ArcTimerState createState() => _ArcTimerState();
}

class _ArcTimerState extends State<ArcTimer> with SingleTickerProviderStateMixin{
  final int updateCycle = 10;     // Number of milliseconds between screen refresh
  int initialCount;               // Number of seconds per cycle
  double fraction = 1;            // Fraction of circle that arc should go to
  TimerController controller;   // Controller driving the arctimer animation

  /// Setup controller
  void controllerSetup() {
    // Initialize our controller
    controller = widget.arcTimerController == null ?
      TimerController() : widget.arcTimerController;

    // Initialize the controller values
    controller.initValues(
      vsync: this,
      initialCount: initialCount,
      onFinish: widget.onFinish
    );

    // Animation driver
    controller.addListener(() {
      setState(() {
        fraction = 1 - (lerpDouble(0, initialCount, controller.value) / initialCount);
      });
    });

  }

  @override
  void initState() {
    super.initState();

    // Set our count in milliseconds
    initialCount = (widget.seconds * 1000).toInt();

    // Setup our controller
    controllerSetup();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.outerRadius * 2,
      height: widget.outerRadius * 2,
      child: CustomPaint(
        painter: _ArcTimerPainter(
          color: widget.color,
          radii: widget.innerRadius,
          fillColor: widget.fillColor,
          fraction: fraction,
          seconds: (fraction * initialCount / 1000).ceil(),
          textStyle: widget.textStyle,
        ),
      ),
    );
  }

}

/// Used to paint the timer
class _ArcTimerPainter extends CustomPainter {

  _ArcTimerPainter({
    @required this.color,
    @required this.radii,
    @required this.fillColor,
    this.textStyle,
    this.fraction:0.5,
    this.seconds: -1
  });

  /// Color of the arc of the timer.
  final Color color;

  /// Color of the inner circle.
  final Color fillColor;
  final double radii;

  /// Current fraction of circle that arc should sweep
  final double fraction;

  /// Value to display
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
      ..strokeWidth = (size.width/2 - radii) * 2
      ..style = PaintingStyle.stroke;
    Paint fillPaint = Paint()
      ..color = fillColor;

    // Drawing
    canvas.drawArc(arcRect, 3 * pi / 2, -fraction * 2 * pi, false, arcPaint);
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
