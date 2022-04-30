import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'bottom_navigator.dart';

class RootWrapper extends StatelessWidget {
  final String title;
  final Widget? body;
  final Widget? floatingActionButton;

  const RootWrapper({
    Key? key,
    this.title = '',
    this.body,
    this.floatingActionButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black87,
        child: body,
      ),
      bottomNavigationBar: const BottomNavigator(),
      floatingActionButton: floatingActionButton,
    );
  }

}