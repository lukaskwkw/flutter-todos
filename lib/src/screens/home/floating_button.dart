part of "home.dart";

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TodoListProvider todoListProvider = Provider.of<TodoListProvider>(context);

    final TextEditingController controller = TextEditingController();
    return [
      FloatingActionButton(
        heroTag: "addList_btn",
        child: const Icon(Icons.add),
        autofocus: true,
        onPressed: () {
          // show a dialog to add a new TodoList
          showDialog<AlertDialog>(
            context: context,
            builder: (BuildContext context) {
              // controller for the text field
              // add watcher to controller.text
              // final controller = context.watch<TextEditingController>();
              return ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, child) => AlertDialog(
                  title: const Text('Add Todo List'),
                  content: TextField(
                      autofocus: true,
                      controller: controller,
                      onSubmitted: (_) async {
                        await onSubmit(value, todoListProvider, context);
                      },
                      decoration: InputDecoration(
                        labelText: "Todo List Name",
                        errorText: errorText(value),
                        border: OutlineInputBorder(),
                      )),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Add'),
                      onPressed: value.text.isEmpty
                          ? null
                          : () async {
                              await onSubmit(value, todoListProvider, context);
                            },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      FloatingActionButton(
          heroTag: "mic_btn", onPressed: () => {}, child: Icon(Icons.mic))
    ].toWrap(spacing: 10);
  }

  String? errorText(TextEditingValue value) {
    // at any time, we can get the text from _controller.value.text
    final text = value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  Future<void> onSubmit(TextEditingValue value,
      TodoListProvider todoListProvider, BuildContext context) async {
    print("obt");
    if (value.text.isEmpty) {
      return;
    }
    final TodoList todoList = TodoList(
      name: value.text,
    );
    await todoListProvider.addTodoList(todoList);
    Navigator.pop(context);
  }
}
