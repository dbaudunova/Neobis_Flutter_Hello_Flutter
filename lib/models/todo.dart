import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool isComplete;
  @HiveField(2)
  final String task;

  Todo({this.id = '', this.isComplete = false, required this.task});
}