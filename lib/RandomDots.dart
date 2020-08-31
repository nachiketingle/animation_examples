import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// Use to get a background of dots moving randomly
/// The more dots used, the higher the processing power is needed
class RandomDots extends StatelessWidget {
  RandomDots({
    Key key,
    this.child,
    this.numOfDots: 250,
    this.haveOrigin: false,
    this.left,
    this.top,
    this.backgroundColor: Colors.black,

    /// Default list of colors for the dots
    this.colors: Colors.primaries,
  }) : super(key: key);

  final Widget child;
  final int numOfDots;
  final bool haveOrigin;
  final double left;
  final double top;
  final Color backgroundColor;
  final List<Color> colors;

  final Random rand = Random();

  /// Return offset from the left
  double _getLeft(context) {
    return haveOrigin
        ? left
        : MediaQuery.of(context).size.width * rand.nextDouble();
  }

  /// Return offset from the top
  double _getTop(context) {
    return haveOrigin
        ? top
        : MediaQuery.of(context).size.height * rand.nextDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: backgroundColor,
        ),
        Opacity(
          opacity: 0.75,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              // Create all the Dots
              for (int i = 0; i < numOfDots; i++)
                Dot(
                  color: colors[i % colors.length], // Assign each dot a color
                  left: _getLeft(context),
                  top: _getTop(context),
                ),
            ],
          ),
        ),

        // Ability to use a child if needed
        child == null ? Container() : child,
      ],
    );
  }
}

/// Model to represent a dot
class Dot extends StatefulWidget {
  Dot({Key key, this.color, this.top, this.left}) : super(key: key);
  final Color color;
  final double top;
  final double left;
  _DotState createState() => _DotState();
}

class _DotState extends State<Dot> {
  Duration duration;
  Timer timer;
  double left;
  double top;
  double size;
  Random rand;

  /// Calculate a new position for the dot
  void _updatePosition() {
    left = rand.nextDouble() * MediaQuery.of(context).size.width;
    top = rand.nextDouble() * MediaQuery.of(context).size.height;
  }

  @override
  void initState() {
    super.initState();
    rand = Random();
    size = 5 + rand.nextDouble() * 4 - 2;
    duration = Duration(milliseconds: 10000 + rand.nextInt(500) - 250);
    left = widget.left;
    top = widget.top;

    // Used to start the initial animation
    Future.delayed(Duration(milliseconds: 10), () {
      setState(() {
        _updatePosition();
      });
    });

    // Used to continuously animate the dot
    timer = Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          _updatePosition();
        });
      }
    });
  }

  @override
  void dispose() {
    // Make sure to cancel timer when page has been left
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
      ),
      duration: duration,
      left: left,
      top: top,
    );
  }
}
