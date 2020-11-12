import 'package:flutter/material.dart';

class TimerController {

  AnimationController _controller;
  double get value => _controller.value;

  bool startASAP;
  bool repeatOnFinish;
  TimerController({this.startASAP: false, this.repeatOnFinish: false});

  /// Initialize values for the controller. This should only be called from inside a timer widget
  void initValues({@required TickerProvider vsync, @required int initialCount, Function onFinish}) {
    _controller = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: initialCount),
      value: 0
    );

    // Notify parent when timer reaches 0
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        if(onFinish != null) {
          onFinish.call();
        }

        if(repeatOnFinish) {
          reset(startAgain: true);
        }
      }
    });

    // Start immediately if needed
    if(startASAP) {
      _controller.forward();
    }
  }

  /// Add a listener to the animation controller
  void addListener(Function listener) {
    _controller.addListener(listener);
  }

  /// Make sure to dispose the [TimerController] when finished
  void dispose() {
    _controller.dispose();
  }

  /// Stop the timer
  void stop() {
    _controller.stop();
  }

  /// Start the timer
  void start() {
    _controller.forward();
  }

  /// Reset the timer
  void reset({bool startAgain: false}) {
    _controller.reset();
    if(startAgain) {
      _controller.forward();
    }
  }
}