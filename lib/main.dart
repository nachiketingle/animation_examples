import 'package:animation_examples/Constants.dart';
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
        primarySwatch: Colors.blue,
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
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class RandomDotsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
        top: size.height / 2,
        left: size.width / 2,
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
