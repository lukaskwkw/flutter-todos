import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todos/src/providers/todo_list_provider.dart';

import '../../models/todo_model.dart';
part "add_todo_floating_button.dart";

class TodosView extends HookWidget {
  final String todoListId;

  TodosView({required this.todoListId});

  @override
  Widget build(BuildContext context) {
    TodoListProvider todoListProvider = Provider.of<TodoListProvider>(context);
    List<TodoModel> todos = todoListProvider.getTodoModels(todoListId);
    // create a list of todos that each have a checkbox
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          final TodoModel todo = todos[index];
          return CheckboxListTile(
            title: Text(todo.title),
            value: todo.isDone,
            onChanged: (bool? value) {
              todo.isDone = value!;
              todoListProvider.updateTodoModel(todo);
            },
          );
        },
      ),
      floatingActionButton: AddTodoFloatingButton(
        onAddTodo: (todo) => todoListProvider.addTodoModel(todo),
        todoListId: todoListId,
      ),
    );
  }
}
