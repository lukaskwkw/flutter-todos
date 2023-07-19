part of 'todos.dart';

class AddTodoFloatingButton extends StatefulWidget {
  final Function(TodoModel todo) onAddTodo;
  final String todoListId;

  const AddTodoFloatingButton(
      {Key? key, required this.onAddTodo, required this.todoListId})
      : super(key: key);

  @override
  State<AddTodoFloatingButton> createState() => _AddTodoFloatingButtonState();
}

class _AddTodoFloatingButtonState extends State<AddTodoFloatingButton> {
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
                      todoListId: widget.todoListId,
                      title: controller.text,
                      isDone: false,
                    );
                    widget.onAddTodo(newTodo);

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
