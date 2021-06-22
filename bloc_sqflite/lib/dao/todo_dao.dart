import 'dart:async';

import 'package:bloc_sqflite/database/database.dart';
import 'package:bloc_sqflite/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = db!.insert(todoTable, todo.toDatabaseJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List<Todo>> getTodos({List<String>? columns, String? query}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = [];
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db!.query(todoTable,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
      }
    } else {
      result = await db!.query(todoTable, columns: columns);
    }
    List<Todo> todos = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;

    var result = await db!.update(todoTable, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result = db!.delete(todoTable, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
