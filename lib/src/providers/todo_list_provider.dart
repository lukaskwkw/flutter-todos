import 'package:flutter/material.dart';
import 'package:todos/src/models/todo_list.dart';
import 'package:todos/src/models/todo_model.dart';
import 'package:todos/src/providers/shared_preferences_provider.dart';
import 'package:fpdart/fpdart.dart';

class TodoListProvider with ChangeNotifier {
  List<TodoList> todoLists = [];
  List<TodoModel> todos = [];
  SharedPreferencesProvider shared;

  TodoListProvider({required this.shared});

  Future<void> init() async {
    await loadTodoLists();
    await loadTodos();
  }

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

  // add TodoModel to todos
  Future<void> addTodoModel(TodoModel todoModel) async {
    todos.add(todoModel);

    await saveTodos();
    notifyListeners();
  }

  Future<void> removeTodoModel(TodoModel todoModel) async {
    todos.remove(todoModel);

    await saveTodos();
    notifyListeners();
  }

  Future<void> updateTodoModel(TodoModel todoModel) async {
    final int index =
        todos.indexWhere((TodoModel item) => item.id == todoModel.id);
    todos[index] = todoModel;

    await saveTodos();
    notifyListeners();
  }

  Future<void> loadTodos() async {
    final Either<String, List<dynamic>> result =
        shared.getJson<List<dynamic>>('todos');

    result
        .andThen(() => result.fold((l) => left(l), (r) {
              try {
                final list = r.map((e) => TodoModel.fromJson(e)).toList();
                return right(list);
              } catch (e) {
                return left(e.toString());
              }
            }))
        .fold((e) => print(e), (r) => todos = r);
  }

  Future<void> saveTodos() async {
    await shared
        .saveJson<List<TodoModel>>('todos', todos)
        .run()
        .then((value) => value.fold((l) => {print(l)}, (r) => null));
  }

  // save TodoList to storage
  Future<void> saveTodoLists() async {
    await shared
        .saveJson<List<TodoList>>('todoLists', todoLists)
        .run()
        .then((value) => value.fold((l) => {print(l)}, (r) => null));
  }

  TodoList getTodoList(String id) {
    return todoLists.firstWhere((TodoList item) => item.id == id);
  }

  List<TodoModel> getTodoModels(String id) {
    return todos.where((TodoModel item) => item.todoListId == id).toList();
  }
}
