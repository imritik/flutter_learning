import 'package:flurest/view/movie/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flurest',
      home: SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new MovieScreen(
        message: '',
      ),
      backgroundColor: Colors.blueAccent,
      title: new Text(
        "Flutter Demo App",
        textScaleFactor: 2,
        style: TextStyle(color: Colors.white),
      ),
      // image: new Image.asset("assets/images/download.png"),
      photoSize: 150.0,
    );
  }
}
