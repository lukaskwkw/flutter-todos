import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todos/src/providers/todo_list_provider.dart';

import '../../models/todo_model.dart';
part "add_todo_floating_button.dart";

class TodosView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final todos = ModalRoute.of(context)!.settings.arguments as List<TodoModel>;
    print(todos);
    if (todos == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
        ),
        body: const Center(
          child: Text('Todos not found'),
        ),
      );
    }
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
                // update the todo
                todo.isDone = value!;
                // update the todo list
                // Provider.of<TodoListProvider>(context, listen: false)
                //     .updateTodoList(todos);
              },
            );
          },
        ),
        floatingActionButton: AddTodoFloatingButton(
          onAddTodo: (todo) => {todos.add(todo)},
          // Provider.of<TodoListProvider>(context, listen: false)
          // .updateTodoList(todos);
        ));
  }
}
