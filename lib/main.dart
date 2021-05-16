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
              PageButton(ModalSheetExample(), "Modal Sheet"),
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
      body: Stack(
        children: [
          RandomDots(
            numOfDots: 250,
            backgroundColor: Colors.white,
            colors: [ColorConstants.gold, Colors.black],
            opacity: 0.25,
            haveOrigin: true,
            top: size.height / 2,
            left: size.width / 2,
          ),
          Align(
            alignment: Alignment(0, -0.66),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: "S", style: TextStyle(fontSize: 55), ),
                    TextSpan(text: "AFEWALK")
                  ]
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: RaisedButton(
              color: ColorConstants.gold,
              child: Text("Purdue Account Login"),
              onPressed: (){
                print("Pressed");
              },
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: IconButton(
              color: ColorConstants.gold,
              icon: Icon(Icons.info_sharp),
              iconSize: 30,
              onPressed: () {
                print("Info pressed");
              },
            ),
          ),
        ],
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
