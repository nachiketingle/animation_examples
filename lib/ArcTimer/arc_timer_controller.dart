import 'package:flutter/material.dart';

class ArcTimerController {

  AnimationController _controller;
  double get value => _controller.value;

  bool startASAP;
  bool repeatOnFinish;
  ArcTimerController({this.startASAP: false, this.repeatOnFinish: false});

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

  void addListener(Function listener) {
    _controller.addListener(listener);
  }

  void dispose() {
    _controller.dispose();
  }

  void stop() {
    _controller.stop();
  }

  void start() {
    _controller.forward();
  }

  void reset({bool startAgain: false}) {
    _controller.reset();
    if(startAgain) {
      _controller.forward();
    }
  }
}