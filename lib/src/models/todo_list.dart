import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TodoList {
  late String id;
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
    String? id,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? showCompleted,
    bool? showNotCompleted,
  }) {
    this.id = id ?? Uuid().v4();
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
    this.showCompleted = showCompleted ?? false;
    this.showNotCompleted = showNotCompleted ?? false;
    this.description = description ?? "";
  }

  factory TodoList.fromJson(Map<String, dynamic> json) {
    final x = TodoList(
      id: json['id'],
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
        'id': id,
        'createdAt': createdAt.toString(),
        'updatedAt': updatedAt.toString(),
        'name': name,
        'showCompleted': showCompleted,
        'showNotCompleted': showNotCompleted,
        'description': description,
      };
}
