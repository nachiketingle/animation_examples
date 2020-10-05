import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

/// Tap and hold anywhere on the screen to create a circle which grows over time

/// Circle model
class _Circle {
  double radii;
  final Offset pos; // Center of the circle
  Color color;

  // List of colors to choose from
  static List<Color> colors;

  _Circle({this.radii, this.pos}) {
   color = colors[Random().nextInt(colors.length)];
  }
}

/// Main Class
class GrowingCircles extends StatefulWidget {
  GrowingCircles({Key key, this.colors}):super(key: key) {
   _Circle.colors = colors;
  }

  // Just put the colors in the static Circle variable
  final List<Color> colors;
  _GrowingCirclesState createState() => _GrowingCirclesState();

}

class _GrowingCirclesState extends State<GrowingCircles> {

  // List of finished circles
  List<_Circle> _allCircles = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: CustomPaint(
        painter: FinalPainter(circles: _allCircles),
        child: _GrowingCircle(
          onFinish: (circle) {
            setState(() {
              _allCircles.add(circle);
            });
          },
        ),
      ),
    );
  }

}

/// Used to paint all of the final and finished circles
class FinalPainter extends CustomPainter {

  FinalPainter({@required this.circles});
  final List<_Circle> circles;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..color = Colors.blue;
    for(_Circle circle in circles) {
      circlePaint.color = circle.color;
      canvas.drawCircle(circle.pos, circle.radii, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}


/// Used to create the growing circle
/// Put as a seperate StatefulWidget for optimization (no need to keep redrawing
/// the finished circles)
class _GrowingCircle extends StatefulWidget {
  _GrowingCircle({this.onFinish});

  final Function(_Circle circle) onFinish; // Called when user lifts finger

  _GrowingCircleState createState() => _GrowingCircleState();
}

class _GrowingCircleState extends State<_GrowingCircle> {

  _Circle _current; // Current circle
  Timer _timer;     // Timer that controls growth rate

  // Every time timer is activated/called, grow the circle
  void timerCall(Timer timer) {
    _current.radii += 0.1;
    if(mounted) {
      setState(() {

      });
    }
  }

  // Touch has ended, adjust final radius based on touch type
  void endTap({double adjust: 0}) {
    setState(() {
      _timer.cancel();
      _current.radii += adjust;
      widget.onFinish.call(_current);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        // Create circle
        _current = _Circle(
          pos: details.localPosition,
          radii: 0.0,
        );

        // Start our timer to grow circle
        _timer = Timer.periodic(Duration(milliseconds: 10), timerCall);
      },

      // End touch calls
      onTapUp: (details) {
        endTap(adjust: 5);
      },
      onLongPressEnd: (details) {
        endTap();
      },

      // Paint and painter to actually draw circle
      child: CustomPaint(
        painter: GrowingPainter(_current),
      ),
    );
  }
}

/// Used to paint the growing circle
class GrowingPainter extends CustomPainter {

  GrowingPainter(this.circle);
  final _Circle circle;

  @override
  void paint(Canvas canvas, Size size) {
    if(circle == null) {
      return;
    }
    Paint paint = Paint()
      ..color = circle.color;
    canvas.drawCircle(circle.pos, circle.radii, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}