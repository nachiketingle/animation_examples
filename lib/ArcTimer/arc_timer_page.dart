import 'package:flutter/material.dart';
import 'arc_timer.dart';
import 'dart:math';
import 'package:animation_examples/Constants.dart';

class ArcTimerPage extends StatefulWidget {
  _ArcTimerPageState createState() => _ArcTimerPageState();
}

/// Page to showcase the capabilities of the ArcTimer
class _ArcTimerPageState extends State<ArcTimerPage> {

  // Use the ArcTimerContoller to control the timer
  final TimerController controller = TimerController(startASAP: false, repeatOnFinish: true);

  // A random fill color
  final Color fillColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  double seconds = 5;

  @override
  Widget build(BuildContext context) {
    print("Rebuilding everything");
    return Scaffold(
      appBar: AppBar(
        title: Text("Arc Timer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ArcTimer(
              arcTimerController: controller,
              color: ColorConstants.gold,
              fillColor: fillColor,
              seconds: seconds,
              innerRadius: 80,
              outerRadius: 100,
              textStyle: TextStyle(
                  fontSize: 50,
                  color: Colors.black
              ),
              onFinish: () {
                print("Finished");
              },
            ),

            // Extracted buttons for readability
            ControlButtons(controller),

            // Let user decide timer length
            Slider(
              value: seconds,
              onChanged: (val) {
                setState(() {
                  //controller.setDuration(Duration(milliseconds: (val * 1000).toInt()));
                  seconds = val;
                });
              },
              min: 0.1,
              max: 100,
            ),
          ],
        ),
      ),
    );
  }
}


/// The buttons used to control the timer using the [ArcTimerController]
class ControlButtons extends StatelessWidget {
  final TimerController controller;

  ControlButtons(this.controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          child: Text("Stop"),
          onPressed: () {
            controller.stop();
          },
        ),
        RaisedButton(
          child: Text("Start"),
          onPressed: () {
            controller.start();
          },
        ),
        RaisedButton(
          child: Text("Reset"),
          onPressed: () {
            controller.reset(startAgain: true);
          },
        ),
      ],
    );
  }
}