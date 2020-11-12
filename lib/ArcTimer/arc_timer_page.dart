import 'package:flutter/material.dart';
import 'arc_timer.dart';
import 'dart:math';
import 'package:animation_examples/Constants.dart';


/// Page to showcase the capabilities of the ArcTimer
class ArcTimerPage extends StatelessWidget {

  // Use the ArcTimerContoller to control the timer
  final ArcTimerController controller = ArcTimerController(startASAP: false, repeatOnFinish: true);

  // A random fill color
  final Color fillColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

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
              seconds: 5,
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
          ],
        ),
      ),
    );
  }
}


/// The buttons used to control the timer using the [ArcTimerController]
class ControlButtons extends StatelessWidget {
  final ArcTimerController controller;

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