import "package:flutter/widgets.dart";

import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

import "../models/todo.dart";

Future<Database> database;

Future initializeDb() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    join(await getDatabasesPath(), "todo_database.db"),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)",
      );
    },
    version: 1,
  );
}

Future insertTodo(Todo todo) async {
  final Database db = await database;
  return await db.insert(
    'todos',
    todo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Todo>> todos() async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('todos');

  return List.generate(maps.length, (i) {
    return Todo(
      id: maps[i]['id'],
      name: maps[i]['name'],
    );
  });
}

Future<void> updateTodo(Todo todo) async {
  final db = await database;

  await db.update(
    'todos',
    todo.toMap(),
    where: "id = ?",
    whereArgs: [todo.id],
  );
}

Future<void> deleteTodo(int id) async {
  final db = await database;

  await db.delete(
    'todos',
    where: "id = ?",
    whereArgs: [id],
  );
}
