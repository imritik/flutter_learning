// @dart=2.9
import 'package:bloc_sqflite/services/notification_service.dart';
import 'package:bloc_sqflite/view/auth/signup.dart';
import 'package:bloc_sqflite/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sqflite demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: IntroScreen(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return SplashScreen(
        useLoader: true,
        loadingText: const Text("Loading..."),
        navigateAfterSeconds:
            result != null ? const TodoPage(title: 'My Todo List') : SignUp(),
        seconds: 5,
        title: const Text(
          'Welcome To Meet up!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.asset('assets/images/avatar.png', fit: BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: const TextStyle(),
        photoSize: 100.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.red);
  }
}
