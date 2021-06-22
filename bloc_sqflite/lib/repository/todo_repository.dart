import 'package:bloc_sqflite/dao/todo_dao.dart';
import 'package:bloc_sqflite/models/todo.dart';

class TodoRepository {
  final todoDao = TodoDao();
  Future getAllTodos({String? query}) => todoDao.getTodos(query: query);
  Future insertTodo(Todo todo) => todoDao.createTodo(todo);
  Future updateTodo(Todo todo) => todoDao.updateTodo(todo);
  Future deleteTodoById(int id) => todoDao.deleteTodo(id);
}
