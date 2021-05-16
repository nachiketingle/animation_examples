import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ModalSheetExample extends StatefulWidget {
  @override
  _ModalSheetExampleState createState() => _ModalSheetExampleState();
}

class _ModalSheetExampleState extends State<ModalSheetExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Some Text"),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Sheet();
                      },
                  );
                },
                child: Text("Show Sheet"),
            ),
          ],
        ),
      ),
    );
  }
}

class Sheet extends StatefulWidget {
  @override
  _SheetState createState() => _SheetState();
}

class _SheetState extends State<Sheet> {

  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            child: Text(time.toString()),
            onPressed: () async {
              time = await DatePicker.showDatePicker(context);
              setState(() {

              });
            },
          ),

        ],
      ),
    );;
  }
}

