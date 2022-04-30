import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volga_it/constants/routes.dart';

class BottomNavigator extends StatefulWidget implements PreferredSizeWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  int _getItemIndexByRoute(BuildContext context) {
    String? path = ModalRoute.of(context)!.settings.name;

    if (path == null) {
      return 0;
    }

    return Routes.routesMap[path] ?? 0;
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, Routes.root);
        break;
      case 1:
        Navigator.pushNamed(context, Routes.list);
        break;
      case 2:
        Navigator.pushNamed(context, Routes.search);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = _getItemIndexByRoute(context);

    return BottomNavigationBar(
      backgroundColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24, color: Colors.white),
            activeIcon: Icon(Icons.home, size: 24, color: Colors.amber),
            label: ''
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted, size: 24, color: Colors.white),
            activeIcon: Icon(Icons.format_list_bulleted, size: 24, color: Colors.amber),
            label: ''
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 24, color: Colors.white),
            activeIcon: Icon(Icons.search, size: 24, color: Colors.amber),
            label: ''
        )
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

}