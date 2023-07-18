import 'package:flutter/material.dart';
import 'package:todos/src/screens/home/home.dart';
import 'package:todos/src/screens/todo/todo.dart';

class Routes {
  static const home = '/';
  static const todo = '/todo';
  static const todoDetail = '/todo-detail';
}

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute<dynamic>(builder: (_) => const HomeScreen());
      case Routes.todo:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => TodosView(),
        );
      // case Routes.todoDetail:
      //   final Todo todo = settings.arguments as Todo;
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => TodoDetailScreen(todo: todo),
      //   );
      default:
        throw UnsupportedError('Route not found');
    }
  }
}
