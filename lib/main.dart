import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:neobis_flutter_hello_flutter/client/hive_names.dart';
import 'package:neobis_flutter_hello_flutter/models/todo.dart';
import 'package:neobis_flutter_hello_flutter/pages/task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>(HiveBoxes.todo);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.black)),
    home: const Task(),
  ));
}
