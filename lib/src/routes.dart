import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todos/src/components/NavigationRailCustom.dart';
import 'package:todos/src/screens/home/home.dart';
import 'package:todos/src/screens/settings/settings.dart';
import 'package:todos/src/screens/todos/todos.dart';

class Routes {
  static const home = '/';
  static const settings = '/settings';
  static const todos = '/todos';
  static const todoDetail = '/todo-detail';
}

class MainRouter {
  static GoRouter router = GoRouter(routes: [
    ShellRoute(
        // navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return Scaffold(
            body: NavRail(
              child: child,
            ),
            // appBar: AppBar(title: Text(state.location)),
          );
        },
        routes: [
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
          GoRoute(
              path: Routes.settings,
              builder: (context, state) =>
                  const SettingsPage(title: "Settings")),
        ]),
  ]);
}
