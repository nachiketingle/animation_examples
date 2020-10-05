import 'package:flutter/material.dart';

class PageFadeTransition extends PageRouteBuilder {
  final Widget page;
  PageFadeTransition({this.page})
      : super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      }
  );
}
