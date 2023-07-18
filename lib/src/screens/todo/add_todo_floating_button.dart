part of "todo.dart";

class AddTodoFloatingButton extends StatelessWidget {
  late Function(TodoModel todo) onAddTodo;

  AddTodoFloatingButton({Key? key, required this.onAddTodo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // show a dialog to add a new Todo
        showDialog<AlertDialog>(
          context: context,
          builder: (BuildContext context) {
            // controller for the text field
            final TextEditingController controller = TextEditingController();
            return AlertDialog(
              title: const Text('Add Todo'),
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
                    final TodoModel newTodo = TodoModel(
                      title: controller.text,
                      isDone: false,
                    );
                    onAddTodo(newTodo);

                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
