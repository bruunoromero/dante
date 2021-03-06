import 'package:flutter/material.dart';
import 'package:dante/goals/models/goal.dart';
import 'package:dante/goals/screens/create/form.dart';

class EditScreen extends StatelessWidget {
  final Goal goal;

  const EditScreen({@required this.goal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create OKR"),
      ),
      body: CreateGoalForm(
        goal: goal,
      ),
    );
  }
}
