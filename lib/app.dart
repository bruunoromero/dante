import 'package:dante/goals/screens/home.dart';
import 'package:dante/utils/tab.dart';
import 'package:flutter/material.dart';

class Dante extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _DanteState createState() => _DanteState();
}

class _DanteState extends State<Dante> {
  var _tabIndex = 0;
  List<ITab> _children = [HomeScreen(), HomeScreen()];

  void _setIndex(index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = _children[_tabIndex];
    return Scaffold(
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: child.actionButton(context),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _setIndex,
        currentIndex: _tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
        ],
      ),
    );
  }
}
