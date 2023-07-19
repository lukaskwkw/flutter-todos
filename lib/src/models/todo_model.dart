import 'package:uuid/uuid.dart';

class TodoModel {
  late String id;
  String title;
  String todoListId;
  late String description;
  late bool isDone;

  TodoModel({
    id,
    required this.title,
    required this.todoListId,
    description,
    isDone,
  }) {
    this.id = id ?? Uuid().v4();
    this.description = description ?? "";
    this.isDone = isDone ?? false;
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        todoListId: json['todoListId'],
        title: json['title'],
        description: json['description'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'todoListId': todoListId,
        'title': title,
        'description': description,
        'isDone': isDone,
      };

  @override
  String toString() {
    return 'TodoModel{id: $id, title: $title, description: $description, isDone: $isDone}';
  }
}
