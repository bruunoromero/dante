import 'package:dante/app.dart';
import 'package:flutter/material.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dante',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dante(),
    );
  }
}

void main() {
  runApp(Main());
}
