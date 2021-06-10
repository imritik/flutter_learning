import 'dart:ffi';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin/location/map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  String inkwell = '';
  void _incrementCounter() {
    FirebaseAnalytics().logEvent(name: 'Plus_icon_clicked', parameters: null);

    setState(() {
      _counter++;
    });
  }

  // showAlertDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     title: Text("AlertDialog"),
  //     actions: [
  //       FlatButton(
  //         child: Text("Cat"),
  //         onPressed: () {
  //           FirebaseAnalytics()
  //               .setUserProperty(name: "dog_or_cat", value: "cat_person");
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //       FlatButton(
  //         child: Text("Dog"),
  //         onPressed: () {
  //           FirebaseAnalytics()
  //               .setUserProperty(name: "dog_or_cat", value: "dog_person");
  //           Navigator.of(context).pop();
  //         },
  //       )
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.create),
              onPressed: () {
                // throw Exception("test a crash");
              }),
          IconButton(
              icon: Icon(Icons.map),
              onPressed: () {
                // throw Exception("test a crash");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  inkwell = 'Inkwell Tapped';
                });
              },
              onLongPress: () {
                setState(() {
                  inkwell = 'InkWell Long Pressed';
                });
              },
              child: Container(
                  color: Colors.indigo,
                  width: 120,
                  height: 70,
                  child: Center(
                      child: Text(
                    'Inkwell',
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                inkwell,
                textScaleFactor: 2,
              ),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              onPressed: () {
                FirebaseAnalytics()
                    .setUserProperty(name: "dog_or_cat", value: "cat_person");
              },
              child: Text("Set user property"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
