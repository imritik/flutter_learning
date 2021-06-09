import 'package:flutter/material.dart';
import 'package:flutter_application_1/gridView.dart';
import 'package:flutter_application_1/reloadListView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Network ListView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOn = false;
  var textSwitch = "Grid";

  void toggle() {
    setState(() {
      isOn = !isOn;
      textSwitch = textSwitch == "Collections" ? "Grid" : "Collections";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          toolbarHeight: 70,
          actions: <Widget>[
            Column(
              children: [
                Switch(
                    value: isOn,
                    onChanged: (val) {
                      toggle();
                    }),
                Text('$textSwitch')
              ],
            )
          ]),
      // body: SafeArea(child: ToggleButton())     //while using visibility widget
      body: isOn ? ReloadListView() : GridViewer(),
    );
  }
}
