import 'package:go_router/go_router.dart';
import 'package:todos/src/screens/home/home.dart';
import 'package:todos/src/screens/todos/todos.dart';

class Routes {
  static const home = '/';
  static const todos = '/todos';
  static const todoDetail = '/todo-detail';
}

class MainRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'todos/:id',
            builder: (context, state) => TodosView(
              todoListId: state.pathParameters['id']!,
            ),
          ),
        ]),
  ]);
}
