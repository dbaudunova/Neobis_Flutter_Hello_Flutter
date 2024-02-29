import 'package:flutter/material.dart';
import 'package:neobis_flutter_hello_flutter/pages/task.dart';

void main() => runApp(MaterialApp(
      theme:
          ThemeData(appBarTheme: AppBarTheme(color: Colors.deepPurpleAccent)),
      home: const Task(),
    ));
