import 'package:flutter/material.dart';
import 'package:todos/src/providers/shared_preferences_provider.dart';
import 'package:todos/src/providers/todo_list_provider.dart';
import 'package:todos/src/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  SharedPreferencesProvider sharedProvider = SharedPreferencesProvider();
  await sharedProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoListProvider>(
            create: (context) => TodoListProvider(shared: sharedProvider)),
        // Provider(create: (context) => SomeOtherClass()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: MainRouter.generateRoute,
      initialRoute: Routes.home,
    );
  }
}
