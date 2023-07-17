import 'package:todos/src/models/todo_model.dart';

class TodoList {
  // array of TodoModel
  List<TodoModel> todos = [];
  // date of creation
  DateTime createdAt = DateTime.now();
  // date of last update
  DateTime updatedAt = DateTime.now();
  // list name
  String name = '';
  // show or hide completed todos
  bool showCompleted = false;
  // show or hide todos that are not completed
  bool showNotCompleted = false;

  String description = '';

  TodoList({
    required this.name,
    String? description,
    List<TodoModel>? todos,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? showCompleted,
    bool? showNotCompleted,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
    this.showCompleted = showCompleted ?? false;
    this.showNotCompleted = showNotCompleted ?? false;
    this.todos = todos ?? [];
    this.description = description ?? "";
  }

  factory TodoList.fromJson(Map<String, dynamic> json) {
    final x = TodoList(
      todos: (json['todos'] as List<dynamic>)
          .map((e) => TodoModel.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name'],
      showCompleted: json['showCompleted'],
      showNotCompleted: json['showNotCompleted'],
      description: json['description'],
    );
    return x;
  }

  Map<String, dynamic> toJson() => {
        'todos': todos,
        'createdAt': createdAt.toString(),
        'updatedAt': updatedAt.toString(),
        'name': name,
        'showCompleted': showCompleted,
        'showNotCompleted': showNotCompleted,
        'description': description,
      };
}
