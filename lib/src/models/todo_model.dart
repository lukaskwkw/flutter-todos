class TodoModel {
  late int id;
  String title;
  late String description;
  late bool isDone;

  TodoModel({
    id,
    required this.title,
    description,
    isDone,
  }) {
    this.id = id ?? DateTime.now().millisecondsSinceEpoch;
    this.description = description ?? "";
    this.isDone = isDone ?? false;
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isDone': isDone,
      };

  @override
  String toString() {
    return 'TodoModel{id: $id, title: $title, description: $description, isDone: $isDone}';
  }
}
