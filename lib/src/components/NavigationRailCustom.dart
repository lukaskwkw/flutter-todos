import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:todos/src/routes.dart';

/// Flutter code sample for [NavigationRail].
class NavRail extends StatefulWidget {
  final Widget child;
  const NavRail({super.key, required this.child});

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  @override
  Widget build(BuildContext context) {
    final go = GoRouter.of(context);
    return Scaffold(
        body: <Widget>[
      NavigationRail(
        selectedIndex: _selectedIndex,
        groupAlignment: groupAlignment,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          go.go(_getLocationFromIndex(index));
        },
        labelType: labelType,
        destinations: const <NavigationRailDestination>[
          NavigationRailDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt_rounded),
            label: Text('Todos'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.settings),
            selectedIcon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ],
      ),
      const VerticalDivider(thickness: 1, width: 1),
      // This is the main content.
      Expanded(child: widget.child),
    ].toRow());
  }

  String _getLocationFromIndex(int index) {
    switch (index) {
      case 0:
        return Routes.home;
      case 1:
        return Routes.settings;
      default:
        return '/'; // return default location or throw an exception based on your use-case
    }
  }
}
