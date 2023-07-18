import 'package:flutter/material.dart';
import 'package:todos/src/models/todo_list.dart';
import 'package:todos/src/models/todo_model.dart';
import 'package:todos/src/providers/shared_preferences_provider.dart';
import 'package:fpdart/fpdart.dart';

class TodoListProvider with ChangeNotifier {
  List<TodoList> todoLists = [];
  SharedPreferencesProvider shared;

  TodoListProvider({required this.shared});

  // load TodoList from storage
  Future<void> loadTodoLists() async {
    final Either<String, List<dynamic>> result =
        shared.getJson<List<dynamic>>('todoLists');

    result
        .andThen(() => result.fold((l) => left(l), (r) {
              try {
                final list = r.map((e) => TodoList.fromJson(e)).toList();
                return right(list);
              } catch (e) {
                return left(e.toString());
              }
            }))
        .fold((e) => print(e), (r) => todoLists = r);
  }

  // add a TodoList to the list
  Future<void> addTodoList(TodoList todoList) async {
    todoLists.add(todoList);
    await saveTodoLists();
    notifyListeners();
  }

  // remove a TodoList from the list
  Future<void> removeTodoList(TodoList todoList) async {
    todoLists.remove(todoList);
    await saveTodoLists();

    notifyListeners();
  }

  // update a TodoList in the list
  Future<void> updateTodoList(TodoList todoList) async {
    final int index =
        todoLists.indexWhere((TodoList item) => item.name == todoList.name);
    todoLists[index] = todoList;
    await saveTodoLists();

    notifyListeners();
  }

  // push TodoModel to TodoList
  Future<void> pushTodoModelToTodoList(
      TodoList todoList, TodoModel todoModel) async {
    final int index =
        todoLists.indexWhere((TodoList item) => item.name == todoList.name);
    todoLists[index].todos.add(todoModel);
    await saveTodoLists();

    notifyListeners();
  }

  // save TodoList to storage
  Future<void> saveTodoLists() async {
    await shared
        .saveJson<List<TodoList>>('todoLists', todoLists)
        .run()
        .then((value) => value.fold((l) => {print(l)}, (r) => null));
  }
}
