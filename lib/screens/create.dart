import 'package:flutter/material.dart';
import 'package:dante/widgets/app_bar.dart';
import 'package:dante/screens/create/form.dart';

class CreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DanteAppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: CreateGoalForm(),
    );
  }
}
