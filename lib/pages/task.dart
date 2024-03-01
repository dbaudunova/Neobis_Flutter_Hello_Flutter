import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:neobis_flutter_hello_flutter/client/hive_names.dart';
import 'package:neobis_flutter_hello_flutter/models/todo.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  String task = '';
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  _isNullOrNot() {
    if (controller.text.isEmpty) {
      Fluttertoast.showToast(msg: 'You cannot add null task',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pop();
    } else if(controller.text.isNotEmpty) {
      setState(() {
        _onFormSubmit();
        controller.clear();
      });

    }
  }

  _dialogOpen() {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Add Task',
                  style: TextStyle(
                      fontFamily: 'TTNorms', fontWeight: FontWeight.bold)),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: 'Add your task',
                    hintStyle: TextStyle(fontFamily: 'TTNorms')),
                onChanged: (String value) {
                  setState(() {
                    task = value;
                  });
                },
              ),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      _isNullOrNot();
                    },
                    child: const Text('Add',
                        style: TextStyle(
                            fontFamily: 'TTNorms',
                            fontWeight: FontWeight.bold)))
              ],
            ));
  }

  void _onFormSubmit() {
    Box<Todo> contactsBox = Hive.box<Todo>(HiveBoxes.todo);
    contactsBox.add(Todo(task: task));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          title: const Text('To-do List'),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'TTNorms',
            fontWeight: FontWeight.bold,
          )),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Todo>(HiveBoxes.todo).listenable(),
          builder: (context, Box<Todo> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child:
                Text("Todo list is empty", style: TextStyle(fontSize: 20)),
              );
            }
            return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  Todo? res = box.getAt(index);
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[350],
                      child: ListTile(
                        titleTextStyle: const TextStyle(
                            fontFamily: 'TTNorms', fontSize: 24),
                        textColor: Colors.black,
                        title: Text(res!.task),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              res.delete();
                            });
                          },
                        ),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
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
