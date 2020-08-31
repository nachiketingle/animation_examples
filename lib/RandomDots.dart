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
    this.colors: const [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
    ],
  }) : super(key: key);

  final Widget child;
  final int numOfDots;
  final bool haveOrigin;
  final double left;
  final double top;
  final Color backgroundColor;
  final List<Color> colors;


  final Random rand = Random();
  

  double _getLeft(context) {
    return haveOrigin
        ? left
        : MediaQuery.of(context).size.width * rand.nextDouble();
  }

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
              for (int i = 0; i < numOfDots; i++)
                Dot(
                  key: Key(i.toString()),
                  color: colors[i % colors.length],
                  left: _getLeft(context),
                  top: _getTop(context),
                ),
            ],
          ),
        ),
        child == null ? Container() : child,
      ],
    );
  }
}

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

    Future.delayed(Duration(milliseconds: 10), () {
      setState(() {
        print("Updating");
        _updatePosition();
      });
    });

    timer = Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          _updatePosition();
        });
      }
    });
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
