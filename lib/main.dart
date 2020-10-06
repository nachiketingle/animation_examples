import 'dart:math';

import 'package:animation_examples/Constants.dart';
import 'package:animation_examples/GrowingCircles.dart';
import 'package:animation_examples/Transitions/PageFadeTransition.dart';
import 'package:flutter/material.dart';
import 'ImportAllAnimations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use AppBar to test refresh
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () {
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),

      // Body to show animations
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          heightFactor: 1,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            children: [
              PageButton(RandomDotsPage(), "Random Dots"),
              PageButton(ArcTimerPage(), "Arc Timer"),
              PageButton(GrowingCirclesPage(), "Growing Circles"),
            ],
          ),
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget{
  PageButton(this.page, this.text);
  final Widget page;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context, PageFadeTransition(page: page));
          },
          child: Center(child: Text(text, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
        ),
      ),
    );
  }
}

class RandomDotsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Random Dots"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RandomDots(
        numOfDots: 250,
        backgroundColor: Colors.black,
        colors: [ColorConstants.gold],
        haveOrigin: true,
        top: MediaQuery.of(context).size.height / 2,
        left: MediaQuery.of(context).size.width / 2,
      ),
    );
  }
}

class ArcTimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Arc Timer"),),
      body: Center(
        heightFactor: 2,
        child: ArcTimer(
          color: ColorConstants.gold,
          fillColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          seconds: 10,
          innerRadius: 80,
          outerRadius: 100,
          repeat: true,
          textStyle: TextStyle(
              fontSize: 50,
              color: Colors.black
          ),
        ),
      ),
    );
  }
}

class GrowingCirclesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Growing Circles"),),
        body: GrowingCircles(colors: Colors.primaries,)
    );
  }
}
