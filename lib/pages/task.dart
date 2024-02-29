import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List todoList = [];
  String _userTask = '';

  _dialogOpen() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Add Task'),
              content: TextField(
                onChanged: (String value) {
                  _userTask = value;
                },
              ),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        todoList.add(_userTask);
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.deepPurpleAccent,
          title: const Text('To-do List'),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'TTNorms',
            fontWeight: FontWeight.bold,
          )),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(todoList[index]),
                child: Card(
                  child: ListTile(
                    title: Text(todoList[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          todoList.removeAt(index);
                        });
                      },
                    ),
                  ),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _dialogOpen();
        },
      ),
    );
  }
}
