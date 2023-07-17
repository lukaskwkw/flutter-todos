// HomeScreen class

// Path: lib\src\screens\home\home.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/src/models/todo_list.dart';
import 'package:todos/src/providers/todo_list_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    TodoListProvider todoListProvider = context.watch<TodoListProvider>();

    todoListProvider.loadTodoLists();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: ListView.builder(
        itemCount: todoListProvider.todoLists.length,
        itemBuilder: (BuildContext context, int index) {
          final TodoList todoList = todoListProvider.todoLists[index];
          return ListTile(
            title: Text(todoList.name),
            subtitle: Text('${todoList.todos.length} todos'),
            onTap: () {
              Navigator.pushNamed(context, '/todo', arguments: todoList);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // show a dialog to add a new TodoList
          showDialog<AlertDialog>(
            context: context,
            builder: (BuildContext context) {
              // controller for the text field
              final TextEditingController controller = TextEditingController();
              return AlertDialog(
                title: const Text('Add Todo List'),
                content: TextField(
                  controller: controller,
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () async {
                      // log hello world
                      print('hello world');
                      // create a new TodoList
                      final TodoList todoList = TodoList(
                        name: controller.text,
                      );
                      // add the TodoList to the list
                      await todoListProvider.addTodoList(todoList);
                      // close the dialog
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
