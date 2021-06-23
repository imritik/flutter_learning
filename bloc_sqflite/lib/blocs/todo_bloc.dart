import 'dart:async';

import 'package:bloc_sqflite/models/todo.dart';
import 'package:bloc_sqflite/repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc {
  final _todoRepository = TodoRepository();

  final _todoController = StreamController<List<Todo>>.broadcast();

  get todos => _todoController.stream;

  TodoBloc() : super(null) {
    getTodos();
  }

  // List<Todo> getTodoList(String? query) {
  //   return _todoRepository.getAllTodos(query: query);
  // }

  getTodos({String? query}) async {
    _todoController.sink.add(await _todoRepository.getAllTodos(query: query));
  }

  addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
    getTodos();
  }

  updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodos();
  }

  deleteTodoById(int id) async {
    _todoRepository.deleteTodoById(id);
    getTodos();
  }

  dispose() {
    _todoController.close();
  }

  @override
  Stream mapEventToState(event) {
    throw UnimplementedError();
  }
}
