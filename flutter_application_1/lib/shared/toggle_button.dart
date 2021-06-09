import 'package:flutter/material.dart';
import 'package:flutter_application_1/gridView.dart';
import 'package:flutter_application_1/reloadListView.dart';

void main() {
  runApp(ToggleButton());
}

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  List<bool> _selections = [true, false];
  // List<bool> _selections = List.generate(3, (_) => false);
  bool widgetVisible = true;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          child: ToggleButtons(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Collections"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Grid View"),
              )
            ],
            isSelected: _selections,
            onPressed: (int index) {
              setState(() {
                if (currentIndex == index) {
                } else {
                  widgetVisible = !widgetVisible;
                  currentIndex = index;
                  for (int i = 0; i < _selections.length; i++) {
                    _selections[i] = i == index;
                  }
                }
              });
              // showAlertDialog(context, index);
            },
          ),
        ),
        Visibility(
            maintainAnimation: true,
            maintainState: true,
            visible: widgetVisible,
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              child: ReloadListView(),
            )),
        Visibility(
            maintainAnimation: true,
            maintainState: true,
            visible: !widgetVisible,
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              child: GridViewer(),
            ))
      ],
    ));
  }

  showAlertDialog(BuildContext context, int index) {
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message." + index.toString()),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
