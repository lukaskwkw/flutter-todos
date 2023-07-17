class TodoModel {
  int id;
  String title;
  String description;
  bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

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
