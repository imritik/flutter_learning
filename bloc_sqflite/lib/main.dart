import 'package:bloc_sqflite/blocs/bloc_provider.dart';
import 'package:bloc_sqflite/blocs/todo_bloc.dart';
import 'package:bloc_sqflite/view/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Sqflite demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: BlocProvider(
          todoBloc: TodoBloc(),
          child: const TodoPage(title: 'My Todo List'),
        ));
  }
}
