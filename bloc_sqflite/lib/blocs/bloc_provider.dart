import 'package:bloc_sqflite/blocs/todo_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final TodoBloc todoBloc;

  const BlocProvider({Key? key, required Widget child, required this.todoBloc})
      : super(key: key, child: child);

  static BlocProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
