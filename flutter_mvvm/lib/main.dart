import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view/add_post_screen.dart';
import 'package:flutter_mvvm/view/home_screen.dart';
import 'package:provider/provider.dart';
import 'notifiers/post_notifier.dart';

Future<void> main() async {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PostsNotifier())],
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(title: 'Flutter Home Page'),
      routes: {
        "/add_post": (context) => AddPostScreen(),
      },
    );
  }
}
